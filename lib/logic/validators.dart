import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Validator extends GetxController {
  Rx<String> selectedCountry = 'الجزائر'.obs;
  final int feildCount;
  late List<TextEditingController> controllers = [];
  late List<FocusNode> focusNodes = [];
  RxBool isAgree1 = false.obs;
  RxBool isAgree2 = false.obs;

  Validator(this.feildCount) {
    controllers = List.generate(feildCount, (index) => TextEditingController());
    focusNodes = List.generate(feildCount, (index) => FocusNode());
  }
//When you create a TextEditingController, it's initialized with an empty string by default.
/*
The TextEditingController holds the text state.
The validator reacts to that state (empty or not).
*/
/*
What isEmpty Does in Dart/Flutter
---------------------------------
isEmpty is a property of the String class in Dart that:
Checks if the string has no characters (length = 0)
Returns a bool:
true → String is empty ("").
false → String has content (e.g., "abc").
*/
//TODO RFC 5322
  String? isValidEmail(String? value) {
    // Check empty first
    if (value == null || value.isEmpty) {
      return "يجب ادخال ايميل";
    }

    // Then check format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return "من فضلك ادخل ايميل صحيح";
    }

    return null;
  }

// Usage:

//TODO  international phone number
  String? isValidPhoneNumber(String? value) {
    final RegExp phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
    if (value == null || value.isEmpty) {
      return 'يجب ادخال رقم الواتساب';
    }
    if (!phoneRegex.hasMatch(value.trim())) {
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

  bool validateForm(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
