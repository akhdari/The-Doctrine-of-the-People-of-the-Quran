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
        if (response.isSuccess) {
          dev.log(response.toString());
          Get.back(); // Close the dialog
          Get.snackbar('Success', 'Form submitted successfully');
        } else {
          Get.snackbar(response.errorCode ?? 'Error', 'Failed to submit form');
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
