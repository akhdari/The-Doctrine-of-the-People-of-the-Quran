import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'system_ui.dart';
import '../widgets/typehead.dart';
import '../widgets/grids/acheivement/acheivement_show.dart';
import 'dart:developer' as dev;

const String partialUrl =
    "http://192.168.100.20/phpscript/acheivement_student_list.php?session_id=";

class AddAcheivement extends StatefulWidget {
  const AddAcheivement({super.key});

  @override
  State<AddAcheivement> createState() => _AddAcheivementState();
}

class _AddAcheivementState extends State<AddAcheivement> {
  final GlobalKey _anchorKey = GlobalKey();
  OverlayEntry? overlayEntry;
  int? id;
  DateTime? selectedDate;

  void showDatePickerOverlay() {
    // Remove any existing overlay first
    removeOverlay();
    //It finds where the widget is on screen and how big it is.
    final RenderBox renderBox =
        _anchorKey.currentContext?.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: removeOverlay, // Tap outside to dismiss
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
                      showNavigationArrow: true,
                      navigationMode: DateRangePickerNavigationMode.scroll,
                      selectionMode: DateRangePickerSelectionMode.single,
                      initialSelectedDate: selectedDate ?? DateTime.now(),
                      todayHighlightColor: const Color(0xff169b88),
                      initialDisplayDate: selectedDate ?? DateTime.now(),
                      showTodayButton: true,
                      showActionButtons: true,
                      maxDate: DateTime.now(),
                      viewSpacing: 5,
                      selectionColor: Color(0xff169b88),
                      selectionShape: DateRangePickerSelectionShape.rectangle,
                      onSelectionChanged:
                          (DateRangePickerSelectionChangedArgs args) {
                        if (args.value is DateTime) {
                          setState(() {
                            selectedDate = args.value as DateTime;
                          });
                          removeOverlay();
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
  void dispose() {
    removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SystemUI(
        title: "Achievement Management",
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: SearchFeild(
                  selectedSession: (p0) {
                    setState(() {
                      id = p0;
                      dev.log("id in acheivement: $id");
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextButton(
                  key: _anchorKey,
                  onPressed: showDatePickerOverlay,
                  child: Text(
                    selectedDate != null
                        ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                        : "Select Date",
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          if (id != null)
            Expanded(
              child: AcheivementScreen(
                id: id!,
              ),
            ),
        ]),
      ),
    );
  }
}
/*
SfDateRangePicker(
                              view: DateRangePickerView.month,
                              monthViewSettings:
                                  DateRangePickerMonthViewSettings(
                                firstDayOfWeek: 1,
                              ),
                              showNavigationArrow: true,
                              navigationMode:
                                  DateRangePickerNavigationMode.scroll,
                              selectionMode:
                                  DateRangePickerSelectionMode.single,
                              initialSelectedDate: DateTime.now(),
                              todayHighlightColor: Color(0xff169b88),
                              initialDisplayDate: DateTime.now(),
                              showTodayButton: true,
                              showActionButtons: true,
                            ),
*/
