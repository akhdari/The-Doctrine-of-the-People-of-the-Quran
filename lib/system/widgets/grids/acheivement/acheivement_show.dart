import 'package:flutter/material.dart';
import '../../../models/get/acheivement_class.dart';
import '../../../services/connect.dart';
import 'dart:developer' as dev;
import 'acheivement.dart';

const String partialUrl =
    "http://192.168.100.20/phpscript/acheivement_student_list.php?session_id=";

class AcheivementScreen extends StatelessWidget {
  final int id;
  const AcheivementScreen({super.key, required this.id});

  Future<List<Acheivement>> getData() async {
    final connect = Connect();
    final result = await connect.get("$partialUrl$id");
    dev.log(result.toString());
    if (result.isSuccess && result.data != null) {
      return result.data!.map((json) => Acheivement.fromJson(json)).toList();
    } else {
      throw Exception(result.errorMessage ?? 'Unknown error fetching students');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AcheivementGrid(
      dataFetcher: getData,
    );
  }
}
