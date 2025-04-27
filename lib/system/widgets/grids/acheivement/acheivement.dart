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

class AttendanceController extends GetxController {
  final RxMap<String, String?> studentAttendance = <String, String?>{}.obs;

  void selectAttendance(String studentID, String type) {
    if (studentAttendance[studentID] == type) {
      studentAttendance[studentID] = null;
    } else {
      studentAttendance[studentID] = type;
    }
  }

  void toggleAllForType(String type, bool shouldSelect) {
    if (shouldSelect) {
      studentAttendance.updateAll((key, value) => type);
    } else {
      studentAttendance.updateAll((key, value) => value == type ? null : value);
    }
  }

  bool isAllSelectedForType(String type) {
    if (studentAttendance.isEmpty) return false;
    return studentAttendance.values.every((value) => value == type);
  }

  bool isAnySelectedForType(String type) {
    return studentAttendance.values.any((value) => value == type);
  }

  @override
  void onClose() {
    studentAttendance.clear();
    super.onClose();
  }
}

class AttendanceDialog extends StatelessWidget {
  final List<Acheivement> data;
  final AttendanceController controller = Get.put(AttendanceController());
  final ScrollController scrollController = ScrollController();

  AttendanceDialog({super.key, required this.data}) {
    for (var student in data) {
      controller.studentAttendance[student.studentID] = null;
    }
  }

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            controller: scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.close),
                      ),
                      Text(
                        "Attendance",
                      ),
                    ],
                  ),
                ),
                Divider(),
                SizedBox(height: 10),
                Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Student',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        _buildTableHeader('Present'),
                        _buildTableHeader('Absent'),
                        _buildTableHeader('Late'),
                        _buildTableHeader('Excuse'),
                      ],
                    ),
                    ...data.map((student) => _buildStudentRow(student)),
                  ],
                ),
                SizedBox(height: 10),
                TextButton(onPressed: () => Get.back(), child: Text("close"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTableHeader(String label) {
    final type = label.toLowerCase();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [Text(label), _buildSelectAllCheckbox(type)],
      ),
    );
  }

  TableRow _buildStudentRow(Acheivement student) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(student.studentName),
        ),
        _buildAttendanceCell(student.studentID, 'present'),
        _buildAttendanceCell(student.studentID, 'absent'),
        _buildAttendanceCell(student.studentID, 'late'),
        _buildAttendanceCell(student.studentID, 'excuse'),
      ],
    );
  }

  Widget _buildAttendanceCell(String studentID, String type) {
    return Center(
      child: GestureDetector(
        onTap: () => controller.selectAttendance(studentID, type),
        child: Obx(() {
          final isSelected = controller.studentAttendance[studentID] == type;
          return Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(),
              color: isSelected ? Colors.black : Colors.transparent,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSelectAllCheckbox(String type) {
    return Obx(() {
      final allSelected = controller.isAllSelectedForType(type);
      final anySelected = controller.isAnySelectedForType(type);

      return Checkbox(
        value: allSelected ? true : (anySelected ? null : false),
        tristate: true,
        onChanged: (value) {
          controller.toggleAllForType(type, value ?? false);
        },
      );
    });
  }
}
