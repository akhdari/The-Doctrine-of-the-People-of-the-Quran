import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;

enum AttendanceStatus { present, absent, late, excused, none }

class Student {
  final String id;
  final String name;
  Student({required this.id, required this.name});
}

class Lecture {
  final String id;
  final String name;
  Lecture({required this.id, required this.name});
}

class StudentAttendance {
  final Student student;
  late Rx<AttendanceStatus> status;

  StudentAttendance({
    required this.student,
    AttendanceStatus initialStatus = AttendanceStatus.none,
  }) {
    status = initialStatus.obs;
  }
}

class AttendanceController extends GetxController {
  final RxList<StudentAttendance> students = <StudentAttendance>[].obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final Rx<Lecture> selectedLecture =
      Lecture(id: 'L001', name: 'حلقة الشيخ رمضان بدري').obs;
  //select all
  final RxBool selectAllPresent = false.obs;
  final RxBool selectAllAbsent = false.obs;
  final RxBool selectAllLate = false.obs;
  final RxBool selectAllExcused = false.obs;
//TODO Use a class bcs class name and students = obj
  final List<Student> dummyStudents = [
    Student(id: 'S001', name: 'أسامة الغناني'),
    Student(id: 'S002', name: 'جمال صحراوي'),
    Student(id: 'S003', name: 'سيف الدين فيصلي'),
    Student(id: 'S004', name: 'عاصم بدري'),
    Student(id: 'S005', name: 'عبد الهادي تبغيت'),
    Student(id: 'S006', name: 'محمد سهير'),
    Student(id: 'S007', name: 'هارون العناني'),
    Student(id: 'S008', name: 'عبد الرحمن عوض'),
    Student(id: 'S009', name: 'عبد الله عوض'),
    Student(id: 'S010', name: 'عبد الله محمد'),
  ];

  final List<Lecture> dummyLectures = [
    Lecture(id: 'L001', name: 'حلقة الشيخ رمضان بدري'),
    Lecture(id: 'L002', name: 'فقه المعاملات'),
    Lecture(id: 'L003', name: 'تفسير القرآن'),
  ];

  @override
  void onInit() {
    super.onInit();
    _loadStudents();
    if (dummyLectures.isNotEmpty) {
      selectedLecture.value = dummyLectures.first;
    }
    ever(students, (_) => _updateAllHeaderCheckboxes());
  }

  void _loadStudents() {
    students.clear();
    students.addAll(dummyStudents.map((s) => StudentAttendance(student: s)));
    // After loading, update the header checkboxes based on the new data
    _updateAllHeaderCheckboxes();
  }

  void updateStatus(int index, AttendanceStatus newStatus) {
    if (index >= 0 && index < students.length) {
      // Toggle logic: If the same status is clicked, set to none
      if (students[index].status.value == newStatus) {
        students[index].status.value = AttendanceStatus.none;
      } else {
        students[index].status.value = newStatus;
      }
      // Update all header checkboxes after an individual student's status changes
      _updateAllHeaderCheckboxes();
      _saveAttendanceAutomatically();
    }
  }

  void updateLecture(Lecture newLecture) {
    selectedLecture.value = newLecture;
    _loadStudents(); // Reload students (and implicitly attendance) for the new lecture
    _updateAllHeaderCheckboxes();
  }

  void updateDate(DateTime newDate) {
    selectedDate.value = newDate;
    _loadStudents(); // Reload students (and implicitly attendance) for the new date
    _updateAllHeaderCheckboxes();
  }

  // New: Method to handle toggling of header checkboxes
  void toggleHeaderCheckbox(AttendanceStatus status, bool? isChecked) {
    final bool checked = isChecked ?? false;

    // First, set the specific header checkbox state
    switch (status) {
      case AttendanceStatus.present:
        selectAllPresent.value = checked;
        break;
      case AttendanceStatus.absent:
        selectAllAbsent.value = checked;
        break;
      case AttendanceStatus.late:
        selectAllLate.value = checked;
        break;
      case AttendanceStatus.excused:
        selectAllExcused.value = checked;
        break;
      default:
        break; // Should not happen with where clause in UI
    }

    // Now, apply the status to all students
    for (var record in students) {
      if (checked) {
        record.status.value = status; // Set all students to the selected status
      } else {
        // If the header checkbox is unchecked, set all students to 'none'
        // ONLY IF they were previously set to THIS status.
        // This prevents unchecking "Present" from also unchecking "Absent" etc.
        if (record.status.value == status) {
          record.status.value = AttendanceStatus.none;
        }
      }
    }

    // Reset other header checkboxes if one is checked (since only one can be "select all" at a time)
    if (checked) {
      if (status != AttendanceStatus.present) selectAllPresent.value = false;
      if (status != AttendanceStatus.absent) selectAllAbsent.value = false;
      if (status != AttendanceStatus.late) selectAllLate.value = false;
      if (status != AttendanceStatus.excused) selectAllExcused.value = false;
    }

    _saveAttendanceAutomatically();
  }

  // New: Internal method to update the state of all header checkboxes
  // based on the current individual student statuses.
  void _updateAllHeaderCheckboxes() {
    // Check if ALL students are currently marked with a specific status
    bool allPresent = students.every(
      (s) => s.status.value == AttendanceStatus.present,
    );
    bool allAbsent = students.every(
      (s) => s.status.value == AttendanceStatus.absent,
    );
    bool allLate = students.every(
      (s) => s.status.value == AttendanceStatus.late,
    );
    bool allExcused = students.every(
      (s) => s.status.value == AttendanceStatus.excused,
    );

    // Update the RxBool variables, but only if they actually need to change
    // This avoids unnecessary rebuilds
    if (selectAllPresent.value != allPresent) {
      selectAllPresent.value = allPresent;
    }
    if (selectAllAbsent.value != allAbsent) selectAllAbsent.value = allAbsent;
    if (selectAllLate.value != allLate) selectAllLate.value = allLate;
    if (selectAllExcused.value != allExcused) {
      selectAllExcused.value = allExcused;
    }
  }

  void _saveAttendanceAutomatically() {
    dev.log('Saving attendance...');
    dev.log('Date: ${selectedDate.value.toIso8601String().split('T').first}');
    dev.log('Lecture: ${selectedLecture.value.name}');
    for (var record in students) {
      dev.log(
        'Student: ${record.student.name}, Status: ${record.status.value.name}',
      );
    }
    //TODO send this data to your backend
  }
}

class AttendanceScreen extends StatelessWidget {
  final AttendanceController controller = Get.put(AttendanceController());

  AttendanceScreen({super.key});

  // Helper function to get Arabic labels for status
  String _statusLabel(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.present:
        return 'حضور';
      case AttendanceStatus.absent:
        return 'غياب';
      case AttendanceStatus.late:
        return 'تأخر';
      case AttendanceStatus.excused:
        return 'عذر';
      default:
        return '';
    }
  }

  // Helper function to get the correct RxBool for the header checkbox
  RxBool _getHeaderCheckboxRx(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.present:
        return controller.selectAllPresent;
      case AttendanceStatus.absent:
        return controller.selectAllAbsent;
      case AttendanceStatus.late:
        return controller.selectAllLate;
      case AttendanceStatus.excused:
        return controller.selectAllExcused;
      default:
        throw Exception('Invalid status for header checkbox');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Essential for Arabic UI
      child: Scaffold(
        appBar: AppBar(
          title: Obx(
            () => Text(
              'حضور ${controller.selectedLecture.value.name}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.date_range),
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: controller.selectedDate.value,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: Theme.of(context).colorScheme,
                        dialogBackgroundColor:
                            Theme.of(context).colorScheme.surface,
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null) {
                  controller.updateDate(picked);
                }
              },
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Center(
                  child: Text(
                    '${controller.selectedDate.value.day}-${controller.selectedDate.value.month}-${controller.selectedDate.value.year}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            // Lecture Selection Dropdown
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => DropdownButtonFormField<Lecture>(
                  value: controller.selectedLecture.value,
                  decoration: InputDecoration(
                    labelText: 'اختر الحلقة',
                    border: Theme.of(context).inputDecorationTheme.border,
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                  ),
                  items: controller.dummyLectures.map((lecture) {
                    return DropdownMenuItem<Lecture>(
                      value: lecture,
                      child: Text(lecture.name),
                    );
                  }).toList(),
                  onChanged: (Lecture? newValue) {
                    if (newValue != null) {
                      controller.updateLecture(newValue);
                    }
                  },
                ),
              ),
            ),

            // Header Row with Select All Checkboxes
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              color: Theme.of(context).colorScheme.primary,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: Text(
                        'الطالب',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ),
                  ),
                  // Loop through relevant AttendanceStatus values to create header checkboxes
                  ...AttendanceStatus.values
                      .where((s) => s != AttendanceStatus.none)
                      .map((status) {
                    return Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Obx(
                            () => Checkbox(
                              value: _getHeaderCheckboxRx(status).value,
                              onChanged: (bool? newValue) {
                                controller.toggleHeaderCheckbox(
                                    status, newValue);
                              },
                              fillColor: WidgetStateProperty.resolveWith<Color>(
                                (Set<WidgetState> states) {
                                  if (states.contains(WidgetState.selected)) {
                                    return Theme.of(context)
                                        .colorScheme
                                        .onPrimary;
                                  }
                                  return Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      .withOpacity(0.5);
                                },
                              ),
                              checkColor: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Text(
                            _statusLabel(status),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 12,
                                ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Student List
            Expanded(
              child: ListView.builder(
                itemCount: controller.students.length,
                itemBuilder: (context, index) {
                  final student = controller.students[index];
                  return Container(
                    key: ValueKey(student.student.id), // Add key here
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    color: index % 2 == 0
                        ? Theme.of(context).colorScheme.surfaceContainerLow
                        : Theme.of(context).colorScheme.surface,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Center(
                            child: Text(
                              student.student.name,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                        ...AttendanceStatus.values
                            .where((s) => s != AttendanceStatus.none)
                            .map((status) {
                          return Expanded(
                            flex: 1,
                            child: Obx(() => Radio<AttendanceStatus>(
                                  value: status,
                                  groupValue: student.status.value,
                                  onChanged: (newValue) {
                                    if (newValue != null) {
                                      controller.updateStatus(index, newValue);
                                    }
                                  },
                                  activeColor:
                                      Theme.of(context).colorScheme.primary,
                                )),
                          );
                        }),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
