import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/generic_edit_controller.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/appreciation.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/api_client.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/dialogs/dialog.dart';

class AppreciationDialog extends GlobalDialog {
  const AppreciationDialog(
      {super.key, super.dialogHeader = "إضافة طالب", super.numberInputs = 14});

  @override
  State<GlobalDialog> createState() => _AppreciationDialogState();
}

class _AppreciationDialogState<GEC extends GenericEditController<Appreciation>>
    extends DialogState<GEC> {
  List<Appreciation>? entries;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    // Initialize entries with an empty list or fetch data as needed
    List<Appreciation> result = await ApiService.fetchList<Appreciation>(
        ApiEndpoints.getAccountInfos, Appreciation.fromJson);
    setState(() {
      entries = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("جدول التقديرات"),
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text("من")),
            DataColumn(label: Text("إلى")),
            DataColumn(label: Text("التقدير")),
            DataColumn(label: Icon(Icons.delete)),
          ],
          rows: List.generate(entries?.length ?? 0, (index) {
            final e = entries?[index];
            return DataRow(
              cells: [
                DataCell(
                  TextFormField(
                    initialValue: e?.pointMin.toString(),
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      final parsed = int.tryParse(val) ?? 0;
                      updateEntry(index, e!.copyWith(pointMin: parsed));
                    },
                  ),
                ),
                DataCell(
                  TextFormField(
                    initialValue: e?.pointMax.toString(),
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      final parsed = int.tryParse(val) ?? 0;
                      updateEntry(index, e!.copyWith(pointMax: parsed));
                    },
                  ),
                ),
                DataCell(
                  TextFormField(
                    initialValue: e?.note,
                    onChanged: (val) {
                      updateEntry(index, e!.copyWith(note: val));
                    },
                  ),
                )
              ],
            );
          }),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              entries?.add(Appreciation(note: '', pointMin: 0, pointMax: 0));
            });
          },
          child: const Text("إضافة صف"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, entries),
          child: const Text("حسناً"),
        ),
      ],
    );
  }

  void updateEntry(int index, Appreciation copyWith) {
    setState(() {
      entries?[index] = copyWith;
    });
  }

  @override
  Column formChild() {
    // TODO: implement formChild
    throw UnimplementedError();
  }

  @override
  Future<void> loadData() {
    // TODO: implement loadData
    throw UnimplementedError();
  }

  @override
  void setDefaultFieldsValue() {
    // TODO: implement setDefaultFieldsValue
  }

  @override
  Future<bool> submit() {
    // TODO: implement submit
    throw UnimplementedError();
  }
}
