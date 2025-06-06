import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'base_layout.dart';
import '../widgets/typehead.dart';
import '../widgets/grids/acheivement/acheivement_show.dart';
import '../../controllers/achievement.dart';
import 'dart:developer' as dev;

class AddAcheivement extends StatefulWidget {
  const AddAcheivement({super.key});

  @override
  State<AddAcheivement> createState() => _AddAcheivementState();
}

class _AddAcheivementState extends State<AddAcheivement> {
  final GlobalKey _anchorKey = GlobalKey();
  OverlayEntry? overlayEntry;
  RxnInt id = RxnInt();
  TextEditingController controller = TextEditingController();
  DateTime? selectedDate;
  late AchievementController achievementController;

  @override
  void initState() {
    super.initState();
    achievementController = Get.find<AchievementController>();
    final now = DateTime.now();
    controller.text = formatDate(now);
    achievementController.setDate(formatDate(now));
  }

  @override
  void dispose() {
    removeOverlay();
    controller.dispose();
    super.dispose();
  }

  String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void showDatePickerOverlay() {
    removeOverlay();
    final RenderBox renderBox =
        _anchorKey.currentContext?.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: removeOverlay,
        behavior: HitTestBehavior.translucent,
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: offset.dy + size.height + 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: 400,
                    height: 400,
                    child: SfDateRangePicker(
                      view: DateRangePickerView.month,
                      monthViewSettings: DateRangePickerMonthViewSettings(
                        firstDayOfWeek: 1,
                      ),
                      minDate: DateTime(DateTime.now().year, 1, 1),
                      maxDate: DateTime.now(),
                      showNavigationArrow: true,
                      navigationMode: DateRangePickerNavigationMode.none,
                      selectionMode: DateRangePickerSelectionMode.single,
                      initialSelectedDate: selectedDate ?? DateTime.now(),
                      initialDisplayDate: selectedDate ?? DateTime.now(),
                      todayHighlightColor: const Color(0xff169b88),
                      showTodayButton: true,
                      showActionButtons: true,
                      enableMultiView: false,
                      viewSpacing: 5,
                      selectionColor: Color(0xff169b88),
                      selectionShape: DateRangePickerSelectionShape.rectangle,
                      onSelectionChanged:
                          (DateRangePickerSelectionChangedArgs args) {
                        if (args.value is DateTime) {
                          setState(() {
                            selectedDate = args.value as DateTime;
                            final formattedDate = formatDate(selectedDate!);
                            controller.text = formattedDate;
                            achievementController.setDate(formattedDate);
                          });
                        }
                      },
                      onSubmit: (Object? value) {
                        removeOverlay();
                      },
                      onCancel: () {
                        removeOverlay();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final scaffoldBackgroundColor = theme.scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: BaseLayout(
        title: "Achievement Management",
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: SearchFeild(
                  selectedSession: (p0) {
                    setState(() {
                      id.value = p0;
                      dev.log("id in acheivement: $id");
                      achievementController.setLectureId(p0);
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: controller,
                  key: _anchorKey,
                  readOnly: true,
                  onTap: showDatePickerOverlay,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date',
                    suffixIcon: Icon(Icons.calendar_today,
                        color: theme.iconTheme.color),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          Expanded(
            child: AcheivementScreen(
              id: id,
              date: controller.text,
            ),
          ),
        ]),
      ),
    );
  }
}
