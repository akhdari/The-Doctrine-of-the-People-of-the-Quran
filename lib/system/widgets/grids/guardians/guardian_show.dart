import 'package:flutter/material.dart';
import 'guardian.dart'; // path to your GuardianGrid
import '../../../models/get/guardian_class.dart'; // contains Guardian model
import '../../../services/connect.dart';
import '../../../models/delete/guardian.dart'; // contains your Connect class
import 'package:get/get.dart';

const String fetchUrl = 'http://192.168.100.20/phpscript/guardian.php';
const String deleteUrl = 'http://192.168.100.20/phpscript/delete_guardian.php';

class GuardianScreen extends StatelessWidget {
  const GuardianScreen({super.key});

  Future<List<Guardian>> getData() async {
    final connect = Connect();
    final result = await connect.get(fetchUrl);

    if (result.isSuccess && result.data != null) {
      return result.data!.map((json) => Guardian.fromJson(json)).toList();
    } else {
      throw Exception(
          result.errorMessage ?? 'Unknown error fetching guardians');
    }
  }

  Future<void> postDelete(int id) async {
    final connect = Connect();
    final request = GuardianDeleteRequest(id);
    final result = await connect.post(deleteUrl, request);

    if (result.isSuccess) {
      Get.snackbar('Success', 'Guardian deleted successfully');
    } else {
      Get.snackbar('Error', 'Failed to delete guardian ${result.errorCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GuardianGrid(
      dataFetcher: getData,
      onDelete: postDelete,
    );
  }
}
