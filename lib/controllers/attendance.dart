import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AttendanceStatus {
  present,
  absent,
  late,
  excused,
  none, // 'none' for the initial state before any selection
}

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

  StudentAttendance(
      {required this.student,
      AttendanceStatus initialStatus = AttendanceStatus.none}) {
    status = initialStatus.obs;
  }
}

class AttendanceController extends GetxController {
  final RxList<StudentAttendance> students = <StudentAttendance>[].obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final Rx<Lecture> selectedLecture =
      Lecture(id: '', name: '').obs; //TODO please select a lecture

  void _loadStudents() {
    //TODO
  }

  @override
  void onInit() {
    super.onInit();
    _loadStudents();
  }

  void updateStatus(int index, AttendanceStatus newStatus) {
    students[index].status.value = newStatus;
  }

  void updateDate(DateTime newDate) {
    selectedDate.value = newDate;
  }
  //TODO automatically save attendance
}

class Attendance extends StatelessWidget {
  //TODO put attendance controller
  const Attendance({super.key});

  @override
  Widget build(BuildContext context) {
    AttendanceController controller = Get.find<AttendanceController>();

    //TODO lecture selection and time picking
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.grey,
            child: Row(
              children: const [
                Expanded(
                  flex: 4,
                  child: Text('Student'),
                ),
                Expanded(
                  flex: 1,
                  child: Text('Present'),
                ),
                Expanded(
                  flex: 1,
                  child: Text('Late'),
                ),
                Expanded(
                  flex: 1,
                  child: Text('Excused'),
                ),
                Expanded(
                  flex: 1,
                  child: Text('Absent'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.students.length,
                itemBuilder: (context, index) {
                  final student = controller.students[index];
                  return Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(student.student.name),
                      ),
                      Expanded(
                        flex: 1,
                        child: Obx(() => Checkbox(
                              value: student.status.value ==
                                  AttendanceStatus.present,
                              onChanged: (value) {
                                controller.updateStatus(
                                    index, AttendanceStatus.present);
                              },
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: Obx(() => Checkbox(
                              value:
                                  student.status.value == AttendanceStatus.late,
                              onChanged: (value) {
                                controller.updateStatus(
                                    index, AttendanceStatus.late);
                              },
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: Obx(() => Checkbox(
                              value: student.status.value ==
                                  AttendanceStatus.excused,
                              onChanged: (value) {
                                controller.updateStatus(
                                    index, AttendanceStatus.excused);
                              },
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: Obx(() => Checkbox(
                              value: student.status.value ==
                                  AttendanceStatus.absent,
                              onChanged: (value) {
                                controller.updateStatus(
                                    index, AttendanceStatus.absent);
                              },
                            )),
                      )
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
