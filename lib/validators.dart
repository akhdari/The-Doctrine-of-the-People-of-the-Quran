import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Controller extends GetxController {
  Rx<String> selectedCountry = 'الجزائر'.obs;
  Rx<String>? emailAddress = ''.obs;
  Rx<String>? phoneNumber = ''.obs;
  late List<TextEditingController> controllers = [];
  late List<FocusNode> focusNodes = [];
  final int feildCount = 6;
  RxBool isAgree1 = false.obs;
  RxBool isAgree2 = false.obs;
  // TODO

  Controller() {
    controllers = List.generate(feildCount, (index) => TextEditingController());
    focusNodes = List.generate(feildCount, (index) => FocusNode());
  }

//TODO RFC 5322
  String? isValidEmail(String? emailAddress) {
    /*It removes spaces from the beginning and end of the string.
If the string contains only spaces, trim() will return an empty string ("")*/
    if (emailAddress == null || emailAddress.trim().isEmpty) {
      return "يجب ادخال ايميل";
    }
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(emailAddress.trim())) {
      return "من فضلك ادخل ايميل صحيح";
    }

    return null; // Valid email
  }

//TODO  international phone number
  String? isValidPhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.trim().isEmpty) {
      return "يجب ادخال رقم هاتف";
    }

    final RegExp phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');

    if (!phoneRegex.hasMatch(phoneNumber.trim())) {
      return "من فضلك ادخل رقم هاتف صحيح";
    }

    return null; // Valid phone number
  }

//we presize the error msg in the validator
//TODO

  String? Function(String?) notEmptyValidator(String errorText) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return errorText;
      }
      return null;
    };
  }

/*  String? notEmptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }*/

  void moveToTheFirstEmptyFeild(GlobalKey<FormState> formKey) {
    if (!formKey.currentState!.validate()) {
      for (int i = 0; i < controllers.length; i++) {
        if (controllers[i].text.isEmpty) {
          focusNodes[i].requestFocus();
          return;
        }
      }
    }
  }
}
