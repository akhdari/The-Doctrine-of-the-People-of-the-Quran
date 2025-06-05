import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../controllers/chart_config_controller.dart';
import '../controllers/chart_filter_controller.dart';
import '../system/utils/chart_utils.dart';
import '../system/utils/snackbar_helper.dart';
import '../system/utils/chart_download_utils.dart';
import '../system/models/chart_data_models.dart';
import './stats/download_button.dart';

class ChartScreen<T> extends StatelessWidget {
  final String title;
  final List<T> data;
  final String tag;
  final List<ChartSeriesConfig> seriesConfigs;
  final ChartAxisConfig axisConfig;

  const ChartScreen({
    super.key,
    required this.title,
    required this.data,
    required this.tag,
    required this.seriesConfigs,
    required this.axisConfig,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _ChartContent<T>(
          data: data,
          tag: tag,
          seriesConfigs: seriesConfigs,
          axisConfig: axisConfig,
        ),
      ),
    );
  }
}

class _ChartContent<T> extends StatefulWidget {
  final List<T> data;
  final String tag;
  final List<ChartSeriesConfig> seriesConfigs;
  final ChartAxisConfig axisConfig;

  const _ChartContent({
    super.key,
    required this.data,
    required this.tag,
    required this.seriesConfigs,
    required this.axisConfig,
  });

  @override
  State<_ChartContent<T>> createState() => _ChartContentState<T>();
}

class _ChartContentState<T> extends State<_ChartContent<T>> {
  final GlobalKey<SfCartesianChartState> _chartKey = GlobalKey();
  final List<ChartEntry> _chartData = [];
  bool _isLoading = false;
  late final ChartConfigController _configController;
  late final ChartFilterController _filterController;

  @override
  void initState() {
    super.initState();
    _configController = Get.put(ChartConfigController(), tag: widget.tag);
    _filterController = Get.put(
      ChartFilterController(tag: widget.tag),
      tag: widget.tag,
    );
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    setState(() => _isLoading = true);
    try {
      _filterData();
    } catch (e) {
      showErrorSnackbar(context, "فشل في تحميل البيانات: ${e.toString()}");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _filterData() {
    if (!_filterController.isFilterApplied.value) {
      setState(() => _chartData.clear());
      return;
    }

    final studentFilter =
        _filterController.studentNameController.text.toLowerCase();
    final lectureFilter =
        _filterController.lectureNameController.text.toLowerCase();
    final fromDate = _filterController.fromDate.value;
    final toDate = _filterController.toDate.value;

    if (fromDate == null || toDate == null) {
      showErrorSnackbar(context, "نطاق التاريخ غير صالح");
      return;
    }

    final filteredData = widget.data.where((data) {
      final record = data as dynamic;
      final studentName = record.studentName?.toString() ?? '';
      final lectureName = record.lectureName?.toString() ?? '';
      final date = record.date as DateTime?;

      if (date == null) {
        debugPrint("تحذير: تم تجاوز سجل بدون تاريخ: $record");
        return false;
      }

      final studentMatch = studentFilter.isEmpty ||
          studentName.toLowerCase().contains(studentFilter);
      final lectureMatch = lectureFilter.isEmpty ||
          lectureName.toLowerCase().contains(lectureFilter);
      final dateMatch = !date.isBefore(fromDate) && !date.isAfter(toDate);

      return studentMatch && lectureMatch && dateMatch;
    }).toList();

    _chartData.clear();
    for (var config in widget.seriesConfigs) {
      final entries = filteredData
          .map((data) {
            final record = data as dynamic;
            final date = record.date as DateTime?;
            if (date == null) return null;

            return ChartEntry(
              date,
              config.name,
              config.valueMapper(record),
            );
          })
          .whereType<ChartEntry>()
          .toList();

      entries.sort((a, b) => a.date.compareTo(b.date));
      _chartData.addAll(entries);
    }

    final allValues = filteredData
        .expand(
          (data) => widget.seriesConfigs.map(
            (config) => config.valueMapper(data as dynamic),
          ),
        )
        .toList();

    _configController.autoCalculateRange(allValues);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildFiltersWithActions(
          context,
          widget.tag,
          onSearch: () {
            _filterController.applyFilters();
            _filterData();
          },
          onReset: () {
            _filterController.resetFilters();
            _filterData();
          },
        ),
        const SizedBox(height: 24),
        Expanded(
          child: _isLoading
              ? buildLoadingIndicator()
              : Obx(() {
                  if (!_filterController.isFilterApplied.value) {
                    return buildEmptyState(
                      "يرجى تطبيق الفلاتر لعرض البيانات",
                    );
                  }
                  if (_chartData.isEmpty) {
                    return buildEmptyState("لا توجد بيانات للفلاتر المحددة");
                  }

                  final seriesData = <String, List<ChartEntry>>{};
                  for (var entry in _chartData) {
                    seriesData.putIfAbsent(entry.category, () => []).add(entry);
                  }

                  return buildChartContainer(
                    child: SfCartesianChart(
                      key: _chartKey,
                      primaryXAxis: widget.axisConfig.xAxis,
                      primaryYAxis: NumericAxis(
                        title: AxisTitle(text: widget.axisConfig.yAxisLabel),
                        minimum: _configController.yAxisMin.value,
                        maximum: _configController.yAxisMax.value,
                        interval: _configController.yAxisInterval.value,
                      ),
                      legend: Legend(
                        isVisible: true,
                        position: LegendPosition.top,
                        overflowMode: LegendItemOverflowMode.wrap,
                      ),
                      tooltipBehavior: TooltipBehavior(
                        enable: true,
                        format:
                            'point.x : point.y ${widget.axisConfig.yAxisLabel}',
                      ),
                      series: widget.seriesConfigs.map((config) {
                        return config.seriesBuilder(
                          seriesData[config.name] ?? [],
                          config.color,
                        );
                      }).toList(),
                    ),
                  );
                }),
        ),
        const SizedBox(height: 16),
        DownloadButton(
          onPressed: () {
            downloadChart(_chartKey, context);
          },
        ),
      ],
    );
  }
}

class ChartSeriesConfig {
  final String name;
  final Color color;
  final double Function(dynamic) valueMapper;
  final CartesianSeries<ChartEntry, dynamic> Function(List<ChartEntry>, Color)
      seriesBuilder;

  ChartSeriesConfig({
    required this.name,
    required this.color,
    required this.valueMapper,
    required this.seriesBuilder,
  });
}

class ChartAxisConfig {
  final ChartAxis xAxis;
  final String yAxisLabel;

  ChartAxisConfig({required this.xAxis, required this.yAxisLabel});
}
