import 'dart:developer' as dev;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '/system/connect/connect.dart';
import '/system/const/abstract_class.dart';

Future<void> submitForm(GlobalKey<FormState> formKey, Connect connect,
    AbstractClass obj, String url) async {
  if (formKey.currentState!.validate()) {
    formKey.currentState!.save();
    if (obj.isComplete) {
      try {
        dev.log('Submitting form to $url with obj: $obj');
        final response = await connect.post(url, obj);
        dev.log(response.toString());
        Get.back(); // Close the dialog
        Get.snackbar('Success', 'Form submitted successfully');
      } catch (e) {
        dev.log("Error submitting form: $e");
        Get.snackbar('Error', 'Failed to submit form');
      }
    } else {
      Get.snackbar('Error', 'Please complete all required fields');
    }
  }
}
//studentFormKey
