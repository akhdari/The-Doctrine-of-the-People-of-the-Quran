import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_screens.dart'; // Make sure this file exists and exports 'Routes'

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Navigation')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // === From TestApp1 ===
          ElevatedButton(
            onPressed: () => Get.toNamed('/attendance'),
            child: const Text('Go to AttendanceScreen'),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed('/report1'),
            child: const Text('Go to ReportScreen1'),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed('/report2'),
            child: const Text('Go to ReportScreen2'),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed('/report3'),
            child: const Text('Go to ReportScreen3'),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed('/report4'),
            child: const Text('Go to ReportScreen4'),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed('/card'),
            child: const Text('Go to StudentSelectionPage'),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed('/stat1'),
            child: const Text('Go to Stat1Screen'),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed('/stat2'),
            child: const Text('Go to Stat2Screen'),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed('/stat3'),
            child: const Text('Go to Stat3Screen'),
          ),

          const Divider(),

          // === From TestApp2 ===
          ElevatedButton(
            onPressed: () => Get.toNamed(Routes.copy),
            child: const Text('Go to Copy Page'),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed(Routes.logIn),
            child: const Text('Go to Login Page'),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed(Routes.addStudent),
            child: const Text('Go to Student Management'),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed(Routes.addGuardian),
            child: const Text('Go to Guardian Management'),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed(Routes.addLecture),
            child: const Text('Go to Lecture Management'),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed(Routes.addAcheivement),
            child: const Text('Go to Achievement Management'),
          ),
        ],
      ),
    );
  }
}
