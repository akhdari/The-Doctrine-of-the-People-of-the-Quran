import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/logic/validators.dart';
import '/system/ui.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TextButton(
          onPressed: () {
            Get.put(Validator(6), permanent: true, tag: "copyPage");
            Get.put(Generate());
            Get.toNamed(
              '/copy',
            );
          },
          child: Text('copy page'),
        ),
        TextButton(
          onPressed: () => Get.toNamed(
            '/logIn',
          ),
          child: Text('logIn page'),
        ),
        TextButton(
          onPressed: () => Get.toNamed(
            '/test',
          ),
          child: Text('new page'),
        ),
        TextButton(
          onPressed: () => Get.toNamed(
            '/student',
          ),
          child: Text('student page'),
        ),
        TextButton(
          onPressed: () => Get.toNamed(
            '/lecture',
          ),
          child: Text('lecture page'),
        ),
        TextButton(
          onPressed: () => Get.toNamed(
            '/guardian',
          ),
          child: Text('guardian page'),
        ),
        TextButton(
          onPressed: () {
            Get.put(Validator(14), permanent: true, tag: "uiPage");
            Get.toNamed(
              '/ui',
            );
          },
          child: Text('ui page'),
        ),
        TextButton(
          onPressed: () => Get.toNamed(
            '/multiselect',
          ),
          child: Text('multiselect page'),
        ),
      ]),
    );
  }
}
