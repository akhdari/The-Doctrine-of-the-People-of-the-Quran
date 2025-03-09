import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/subscription_information.dart';
import '../widgets/form.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TextButton(
          onPressed: () => Get.toNamed('/copy', arguments: {
            Get.put(SubscriptionInformationController()),
            Get.put(Controller()),
          }),
          child: Text('copy page'),
        ),
        TextButton(
          onPressed: () => Get.toNamed('/logIn',),
          child: Text('logIn page'),
        ),
        TextButton(
          onPressed: () => Get.toNamed('/test',),
          child: Text('new page'),
        ),

      ]),
    );
  }
}
