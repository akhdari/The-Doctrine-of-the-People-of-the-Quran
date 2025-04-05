import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'timer.dart';
import 'dart:developer' as dev;

class TimeCellController extends GetxController {
  //for switches
  final Map<String, RxBool> weekDays = {
    'الجمعة': false.obs,
    'السبت': false.obs,
    'الأحد': false.obs,
    'الإثنين': false.obs,
    'الثلاثاء': false.obs,
    'الأربعاء': false.obs,
    'الخميس': false.obs,
  };
  //for time selection
  //nasted map
  final Map<String, Map<String, RxString>> dayTimes = {
    'الجمعة': {'from': ''.obs, 'to': ''.obs},
    'السبت': {'from': ''.obs, 'to': ''.obs},
    'الأحد': {'from': ''.obs, 'to': ''.obs},
    'الإثنين': {'from': ''.obs, 'to': ''.obs},
    'الثلاثاء': {'from': ''.obs, 'to': ''.obs},
    'الأربعاء': {'from': ''.obs, 'to': ''.obs},
    'الخميس': {'from': ''.obs, 'to': ''.obs},
  };

  void toggleSwitch(String day) => weekDays[day]!.toggle();
  //map acess map_name[key]
  /*why use null aware operator ?
  /because the map may not contain the key*/

  void clearTime(String day, String type) => dayTimes[day]![type]!.value = '';

  void setTime(String day, String type, String newTime) =>
      dayTimes[day]![type]!.value = newTime;
}

class CustomMatrix extends StatelessWidget {
  const CustomMatrix({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TimeCellController());

    return Table(
      border: TableBorder.all(color: Colors.grey),
      //column width
      columnWidths: const {
        //index: flex
        //index should be ordered and starts from 0
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
      },
      //rows
      children: <TableRow>[
        //row 1
        TableRow(
          decoration: const BoxDecoration(color: Colors.teal),
          children: [
            _buildHeaderCell('اليوم'),
            _buildHeaderCell('الحالة'),
            _buildHeaderCell('من'),
            _buildHeaderCell('إلى'),
          ],
        ),
        //data rows
        ...controller.weekDays.entries.map((entry) {
          String day = entry.key;
          return TableRow(
            children: [
              _buildDataCell(day),
              _buildSwitchCell(day),
              TimeCell(day: day, isFrom: true),
              TimeCell(day: day, isFrom: false),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDataCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildSwitchCell(String day) {
    final controller = Get.find<TimeCellController>();
    return Obx(() => Center(
          child: Switch(
            value: controller.weekDays[day]!.value,
            onChanged: (value) {
              controller.toggleSwitch(day);
              if (!value) {
                controller.clearTime(day, 'from');
                controller.clearTime(day, 'to');
              }
            },
          ),
        ));
  }
}

class TimeCell extends StatelessWidget {
  final String day;
  final bool isFrom;

  const TimeCell({
    super.key,
    required this.day,
    required this.isFrom,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TimeCellController>();
    final timeType = isFrom ? 'from' : 'to';

    return Obx(() {
      final isSelected = controller.weekDays[day]!.value;
      final timeValue = controller.dayTimes[day]![timeType]!.value;

      return TextButton(
        onPressed: () async {
          if (isSelected) {
            dev.log('$day ${isFrom ? "from" : "to"} time selected');
            final value = await timer(context);
            controller.setTime(day, timeType, value);
            dev.log('Selected time for $day $timeType: $value');
          } else {
            dev.log('$day is not selected');
            if (timeValue.isNotEmpty) {
              controller.clearTime(day, timeType);
            }
          }
        },
        child: Text(timeValue),
      );
    });
  }
}
