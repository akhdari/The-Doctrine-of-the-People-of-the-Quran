import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/logic/validators.dart';
import '/logic/generate.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TextButton(
          onPressed: () {
            Get.put(Validator(6), tag: "copyPage");
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
            Get.put(Validator(16), tag: "studentPage");
            Get.put(Generate());
            Get.toNamed(
              '/add_student',
            );
          },
          child: Text('add student'),
        ),
        TextButton(
          onPressed: () {
            Get.put(Validator(10), tag: "guardianPage");
            Get.put(Generate());
            Get.toNamed(
              '/add_guardian',
            );
          },
          child: Text('add guardian'),
        ),
      ]),
    );
  }
}
