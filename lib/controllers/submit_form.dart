import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/connect.dart';
import '../system/models/post/abstract_class.dart';

Future<bool> submitForm(
  GlobalKey<FormState> formKey,
  Connect connect,
  AbstractClass obj,
  String url,
) async {
  if (!formKey.currentState!.validate()) return false;

  formKey.currentState!.save();

  if (!obj.isComplete) {
    Get.snackbar('Error', 'Please complete all required fields');
    return false;
  }

  try {
    final response = await connect.post(url, obj);
    if (response.isSuccess && response.data?['success'] == true) {
      Get.snackbar('Success', 'Form submitted successfully');
      return true;
    } else {
      final errorMessage = response.data?['message'] ??
          response.errorMessage ??
          'Failed to submit form';
      Get.snackbar('Error', errorMessage);
      return false;
    }
  } catch (e) {
    Get.snackbar('Error', 'Failed to submit form');
    return false;
  }
}
//
