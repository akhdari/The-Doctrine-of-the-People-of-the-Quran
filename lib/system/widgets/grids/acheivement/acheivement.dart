import 'package:flutter/material.dart';
import '../../../models/grid/generic_data_grid.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../models/get/acheivement_class.dart';
import 'package:get/get.dart';
import '/system/widgets/dialogs/acheivement.dart';

class AcheivementGrid extends StatelessWidget {
  final List<Acheivement> data;
  final Future<void> Function() onRefresh;

  const AcheivementGrid({
    super.key,
    required this.data,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return GenericDataGrid<Acheivement>(
      data: data,
      onRefresh: onRefresh,
      onDelete: null,
      selectionMode: SelectionMode.none,
      screenTitle: 'Acheivements List',
      detailsTitle: 'Acheivement Details',
      rowsPerPage: 10,
      showCheckBoxColumn: false,
      idExtractor: (row) => row.getCells()[0].value.toString(),
      rowBuilder: (acheivement) => DataGridRow(cells: [
        DataGridCell<String>(
            columnName: 'student_id', value: acheivement.studentID),
        DataGridCell<String>(
            columnName: 'full_name', value: acheivement.studentName),
        DataGridCell<String>(columnName: 'acheivement', value: null),
        DataGridCell<String>(columnName: 'attendance', value: null),
      ]),
      cellBuilder: (cell) {
        if (cell.columnName == 'acheivement') {
          return GestureDetector(
            onTap: () {
              Get.dialog(AcheivemtDialog());
            },
            child: const Icon(Icons.emoji_events),
          );
        }
        if (cell.columnName == 'attendance') {
          return GestureDetector(
            onTap: () {
              Get.dialog(AttendanceDialog(
                data: data,
              ));
            },
            child: const Icon(Icons.calendar_today),
          );
        } else {
          return null;
        }
      },
      columns: [
        GridColumn(columnName: 'student_id', label: _buildHeader('Student ID')),
        GridColumn(
            columnName: 'student_name', label: _buildHeader('Student Name')),
        GridColumn(
            columnName: 'acheivement', label: _buildHeader('Acheivement')),
        GridColumn(columnName: 'attendance', label: _buildHeader('Attendance')),
      ],
    );
  }

  Widget _buildHeader(String title) {
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(title, overflow: TextOverflow.ellipsis),
    );
  }
}

class AttendanceDialog extends StatelessWidget {
  final List<Acheivement> data;
  final AttendanceController controller = Get.put(AttendanceController());

  AttendanceDialog({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: Get.width * 0.7,
        maxHeight: Get.height * 0.8,
        minHeight: 400,
        minWidth: 300,
      ),
      child: Dialog(
        child: Table(
          children: [
            TableRow(
              children: const [
                Padding(padding: EdgeInsets.all(8), child: Text('Student')),
                Padding(padding: EdgeInsets.all(8), child: Text('Present')),
                Padding(padding: EdgeInsets.all(8), child: Text('Absent')),
                Padding(padding: EdgeInsets.all(8), child: Text('Late')),
                Padding(padding: EdgeInsets.all(8), child: Text('Excuse')),
              ],
            ),
            ...data.map((student) => _buildStudentRow(student, controller)),
          ],
        ),
      ),
    );
  }
}

TableRow _buildTableRow(String name, bool column1, bool column2, bool column3) {
  return TableRow(
    children: [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(name),
      ),
      Center(child: _buildCircle(column1)),
      Center(child: _buildCircle(column2)),
      Center(child: _buildCircle(column3)),
    ],
  );
}

Widget _buildCircle(bool isFilled) {
  return Container(
    width: 20,
    height: 20,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(),
      color: isFilled ? Colors.black : Colors.transparent,
    ),
  );
}

TableRow _buildStudentRow(
    Acheivement student, AttendanceController controller) {
  controller.studentAttendance.putIfAbsent(
      student.studentID,
      () => {
            'present': false.obs,
            'absent': false.obs,
            'late': false.obs,
            'excuse': false.obs,
          });

  final studentAttendance = controller.studentAttendance[student.studentID]!;

  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(student.studentName),
      ),
      // Present
      Center(
        child: Obx(() => GestureDetector(
              onTap: () {
                // Unselect others when selecting present
                studentAttendance['present']!.value = true;
                studentAttendance['absent']!.value = false;
                studentAttendance['late']!.value = false;
                studentAttendance['excuse']!.value = false;
              },
              child: _buildCircle(studentAttendance['present']!.value),
            )),
      ),
      // Absent
      Center(
        child: Obx(() => GestureDetector(
              onTap: () {
                studentAttendance['present']!.value = false;
                studentAttendance['absent']!.value = true;
                studentAttendance['late']!.value = false;
                studentAttendance['excuse']!.value = false;
              },
              child: _buildCircle(studentAttendance['absent']!.value),
            )),
      ),
      // Late
      Center(
        child: Obx(() => GestureDetector(
              onTap: () {
                studentAttendance['present']!.value = false;
                studentAttendance['absent']!.value = false;
                studentAttendance['late']!.value = true;
                studentAttendance['excuse']!.value = false;
              },
              child: _buildCircle(studentAttendance['late']!.value),
            )),
      ),
      // Excuse
      Center(
        child: Obx(() => GestureDetector(
              onTap: () {
                studentAttendance['present']!.value = false;
                studentAttendance['absent']!.value = false;
                studentAttendance['late']!.value = false;
                studentAttendance['excuse']!.value = true;
              },
              child: _buildCircle(studentAttendance['excuse']!.value),
            )),
      ),
    ],
  );
}

// Update your AttendanceController
class AttendanceController extends GetxController {
  final Map<String, Map<String, RxBool>> studentAttendance = {};

  @override
  void onClose() {
    studentAttendance.clear();
    super.onClose();
  }
}
//for each student in list add a table row with student name and attendance
