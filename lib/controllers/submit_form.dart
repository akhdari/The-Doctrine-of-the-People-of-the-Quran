import 'dart:developer' as dev;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../system/services/connect.dart';
import '../system/models/post/abstract_class.dart';

Future<void> submitForm(GlobalKey<FormState> formKey, Connect connect,
    AbstractClass obj, String url, RxBool isComplete) async {
  if (formKey.currentState!.validate()) {
    formKey.currentState!.save();
    if (obj.isComplete) {
      try {
        dev.log('Submitting form to $url with obj: $obj');
        final ApiResult response = await connect.post(url, obj);
        dev.log('Response data: ${response.data}');
        dev.log('Response error: ${response.errorMessage}');
        dev.log('Response: $response');

        if (response.isSuccess &&
            response.data != null &&
            response.data['success'] == true) {
          Get.back(); // Close the dialog
          Get.snackbar('Success', 'Form submitted successfully');
        } else {
          final errorMessage = response.data?['message'] ??
              response.errorMessage ??
              'Failed to submit form';
          Get.snackbar('Error', errorMessage);
        }
      } catch (e) {
        dev.log("Error submitting form: $e");
        Get.snackbar('Error', 'Failed to submit form');
      } finally {
        isComplete.value = true;
      }
    } else {
      Get.snackbar('Error', 'Please complete all required fields');
    }
  }
}
