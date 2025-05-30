import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_screens.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TextButton(
          onPressed: () {
            Get.toNamed(Routes.copy);
          },
          child: Text('copy page'),
        ),
        TextButton(
          onPressed: () => Get.toNamed(Routes.logIn),
          child: Text('logIn page'),
        ),
        TextButton(
          onPressed: () {
            Get.toNamed(Routes.addStudent);
          },
          child: Text('student managment'),
        ),
        TextButton(
          onPressed: () {
            Get.toNamed(Routes.addGuardian);
          },
          child: Text('guardian managment'),
        ),
        TextButton(
          onPressed: () {
            Get.toNamed(Routes.addLecture);
          },
          child: Text('lecture managment'),
        ),
        TextButton(
          onPressed: () {
            Get.toNamed(Routes.addAcheivement);
          },
          child: Text('acheivement management'),
        ),
        TextButton(
          onPressed: () {
            Get.toNamed(Routes.Attendance);
          },
          child: Text('attendance management'),
        ),
      ]),
    );
  }
}
