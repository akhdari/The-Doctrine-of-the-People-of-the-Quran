import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, GlobalKey<FormState> formKey) {
  if (formKey.currentState!.validate()) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Valid form')),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Invalid form')),
    );
  }
}
