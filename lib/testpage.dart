import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/validator.dart';
import 'controllers/generate.dart';
import 'web/widgets/subscription_information.dart';
import 'controllers/achievement.dart';
import 'controllers/guardian.dart';
import 'controllers/student.dart';
import 'controllers/lecture.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TextButton(
          onPressed: () {
            Get.put(Validator(6), tag: "copyPage");
            Get.put(SubscriptionInformationController());
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
          onPressed: () {
            Get.put(StudentController());
            Get.toNamed(
              '/add_student',
            );
          },
          child: Text('student managment'),
        ),
        TextButton(
          onPressed: () {
            Get.put(
              Validator(10),
              tag: "guardianPage",
            );
            Get.put(Generate());
            Get.put(GuardianController());

            Get.toNamed(
              '/add_guardian',
            );
          },
          child: Text('guardian managment'),
        ),
        TextButton(
          onPressed: () {
            Get.put(Validator(2), tag: "lecturePage");
            Get.put(LectureController());
            Get.toNamed(
              '/add_lecture',
            );
          },
          child: Text('lecture managment'),
        ),
        TextButton(
          onPressed: () {
            Get.put(AchievementController());
            Get.toNamed(
              '/add_acheivement',
            );
          },
          child: Text('acheivement management'),
        ),
      ]),
    );
  }
}
