import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/abstract_class.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/api_client.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/utils/snackbar_helper.dart';

Future<bool> submitForm<T extends AbstractClass>(
  GlobalKey<FormState> formKey,
  T obj,
  String url,
  T Function(Map<String, dynamic>) fromJson,
) async {
  if (!formKey.currentState!.validate()) return false;

  formKey.currentState!.save();

  if (!obj.isComplete) {
    showErrorSnackbar(Get.context!, 'يرجى إكمال جميع الحقول المطلوبة');
    return false;
  }

  try {
    await ApiService.post<T>(url, obj.toMap(), fromJson);
    showSuccessSnackbar(Get.context!, 'تم إرسال النموذج بنجاح');
    return true;
  } catch (e) {
    showErrorSnackbar(Get.context!, 'فشل إرسال النموذج - ${e.toString()}');
    return false;
  }
}

Future<bool> submitEditDataForm<T extends AbstractClass>(
  GlobalKey<FormState> formKey,
  T obj,
  String url,
  T Function(Map<String, dynamic>) fromJson,
) async {
  if (!formKey.currentState!.validate()) return false;

  formKey.currentState!.save();

  if (!obj.isComplete) {
    showErrorSnackbar(Get.context!, 'يرجى إكمال جميع الحقول المطلوبة');
    return false;
  }

  try {
    await ApiService.put<T>(url, obj.toMap(), fromJson);
    showSuccessSnackbar(Get.context!, 'تم تعديل النموذج بنجاح');
    return true;
  } catch (e) {
    showErrorSnackbar(Get.context!, 'فشل تعديل النموذج - ${e.toString()}');
    return false;
  }
}
