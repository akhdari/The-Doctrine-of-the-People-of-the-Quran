import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/weekly_schedule.dart';
import './time_picker.dart';

class TimeCellController extends GetxController {
  final Map<String, RxBool> weekDays = {
    'Friday': false.obs,
    'Saturday': false.obs,
    'Sunday': false.obs,
    'Monday': false.obs,
    'Tuesday': false.obs,
    'Wednesday': false.obs,
    'Thursday': false.obs,
  };

  final Map<String, Map<String, RxString>> dayTimes = {
    'Friday': {'from': ''.obs, 'to': ''.obs},
    'Saturday': {'from': ''.obs, 'to': ''.obs},
    'Sunday': {'from': ''.obs, 'to': ''.obs},
    'Monday': {'from': ''.obs, 'to': ''.obs},
    'Tuesday': {'from': ''.obs, 'to': ''.obs},
    'Wednesday': {'from': ''.obs, 'to': ''.obs},
    'Thursday': {'from': ''.obs, 'to': ''.obs},
  };

  void toggleSwitch(String day) => weekDays[day]!.toggle();

  void clearTime(String day, String type) => dayTimes[day]![type]!.value = '';

  void setTime(String day, String type, String newTime) {
    if (!_isValidTime(newTime)) {
      Get.snackbar(
        'Format Error',
        'Please enter time in HH:MM format',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Theme.of(Get.context!).colorScheme.error,
        colorText: Theme.of(Get.context!).colorScheme.onError,
      );
      return;
    }

    final otherType = type == 'from' ? 'to' : 'from';
    final otherTime = dayTimes[day]![otherType]!.value;

    if (otherTime.isNotEmpty) {
      if (type == 'from' && !_isFromBeforeTo(newTime, otherTime)) {
        Get.snackbar(
          'Time Error',
          'Start time must be before end time',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Theme.of(Get.context!).colorScheme.error,
          colorText: Theme.of(Get.context!).colorScheme.onError,
        );
        return;
      }
      if (type == 'to' &&
          !_isFromBeforeTo(dayTimes[day]!['from']!.value, newTime)) {
        Get.snackbar(
          'Time Error',
          'End time must be after start time',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Theme.of(Get.context!).colorScheme.error,
          colorText: Theme.of(Get.context!).colorScheme.onError,
        );
        return;
      }
    }

    dayTimes[day]![type]!.value = newTime;
  }

  bool _isValidTime(String time) {
    final parts = time.split(':');
    if (parts.length != 2) return false;
    final hours = int.tryParse(parts[0]);
    final minutes = int.tryParse(parts[1]);
    return hours != null &&
        minutes != null &&
        hours >= 0 &&
        hours <= 23 &&
        minutes >= 0 &&
        minutes <= 59;
  }

  bool _isFromBeforeTo(String from, String to) {
    final fromMinutes = _timeToMinutes(from);
    final toMinutes = _timeToMinutes(to);
    if (fromMinutes == toMinutes) return false;
    return true;
  }

  int _timeToMinutes(String time) {
    final parts = time.split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    return hours * 60 + minutes;
  }

  List<WeeklySchedule> getSelectedDays() {
    final List<WeeklySchedule> result = [];

    for (var entry in weekDays.entries) {
      if (entry.value.value) {
        final day = entry.key;
        final fromTime = dayTimes[day]!['from']!.value;
        final toTime = dayTimes[day]!['to']!.value;

        if (fromTime.isEmpty || toTime.isEmpty) {
          Get.snackbar(
            'Error',
            'Please specify both start and end time for $day',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Theme.of(Get.context!).colorScheme.error,
            colorText: Theme.of(Get.context!).colorScheme.onError,
          );
          continue;
        }

        result.add(WeeklySchedule(
          weeklyScheduleId: 0,
          dayOfWeek: day,
          startTime: fromTime,
          endTime: toTime,
          lectureId: 0,
        ));
      }
    }

    return result;
  }
}

class CustomMatrix extends StatelessWidget {
  final TimeCellController controller;

  const CustomMatrix({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Theme.of(context).dividerColor),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
      },
      children: <TableRow>[
        TableRow(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.primary),
          children: [
            _buildHeaderCell(context, 'Day'),
            _buildHeaderCell(context, 'Status'),
            _buildHeaderCell(context, 'From'),
            _buildHeaderCell(context, 'To'),
          ],
        ),
        ...controller.weekDays.entries.map((entry) {
          String day = entry.key;
          return TableRow(
            children: [
              _buildDataCell(context, day),
              _buildSwitchCell(controller, day),
              TimeCell(controller: controller, day: day, isFrom: true),
              TimeCell(controller: controller, day: day, isFrom: false),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildHeaderCell(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildDataCell(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
    );
  }

  Widget _buildSwitchCell(TimeCellController controller, String day) {
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
  final TimeCellController controller;
  final String day;
  final bool isFrom;

  const TimeCell({
    super.key,
    required this.controller,
    required this.day,
    required this.isFrom,
  });

  @override
  Widget build(BuildContext context) {
    final timeType = isFrom ? 'from' : 'to';

    return Obx(() {
      final isSelected = controller.weekDays[day]!.value;
      final timeValue = controller.dayTimes[day]![timeType]!.value;

      return TextButton(
        onPressed: () async {
          if (isSelected) {
            final picked = await showCustomTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (picked != null) {
              final formattedTime =
                  '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
              controller.setTime(day, timeType, formattedTime);
            }
          }
        },
        child: Text(
          timeValue.isEmpty ? (isFrom ? 'Start' : 'End') : timeValue,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: timeValue.isEmpty
                    ? Theme.of(context).hintColor
                    : Theme.of(context).colorScheme.onSurface,
              ),
        ),
      );
    });
  }
}
