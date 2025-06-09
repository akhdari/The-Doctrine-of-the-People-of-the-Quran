import 'dart:developer' as dev;

import 'package:flutter/widgets.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/abstract_class.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/api_client.dart';

Future<bool> submitForm<T extends AbstractClass>(
  GlobalKey<FormState> formKey,
  T obj,
  String url,
  T Function(Map<String, dynamic>) fromJson,
) async {
  if (!formKey.currentState!.validate()) return false;

  formKey.currentState!.save();

  if (!obj.isComplete) {
    dev.log('يرجى إكمال جميع الحقول المطلوبة');
    return false;
  }

  try {
    await ApiService.post<T>(url, obj.toJson(), fromJson);
    dev.log('تم إرسال النموذج بنجاح');
    return true;
  } catch (e) {
    dev.log('فشل إرسال النموذج - ${e.toString()}');
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
    dev.log('يرجى إكمال جميع الحقول المطلوبة');
    return false;
  }

  try {
    await ApiService.put<T>(url, obj.toJson(), fromJson);
    dev.log('تم تعديل النموذج بنجاح');
    return true;
  } catch (e) {
    dev.log('فشل تعديل النموذج - ${e.toString()}');
    return false;
  }
}
