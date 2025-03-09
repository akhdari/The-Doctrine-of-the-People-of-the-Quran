import 'package:flutter/material.dart';
import '../responsive_screen.dart';
import '../widgets/subscription_information.dart';
import '../widgets/form.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';

class CopyPage extends StatefulWidget {
  const CopyPage({super.key});

  @override
  State<CopyPage> createState() => _CopyPageState();
}

class _CopyPageState extends State<CopyPage> {
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     Controller controller = Get.find<Controller>();
      
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(width: 1, color: Colors.black))),
          child: Column(
            children: const [
              InfoLinksWithImages(
                text: ' تريد التعرف على النظام أكثر ؟',
              ),
              InfoLinksWithImages(
                text: ' تريد التعرف على العروض والأسعار ؟',
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Expanded(
          child: ResponsiveFollowUp(
            rightChild: CustomFormWidget(
              
              formKey: formKey,
            ),
            leftChild: SubscriptionInformation(
              onEmptyFeild: () => controller.moveToTheFirstEmptyFeild(formKey),
              formKey: formKey,
            ),
          ),
        ),
      ],
    );
  }
}

class InfoLinksWithImages extends StatefulWidget {
  final String text;

  const InfoLinksWithImages({
    super.key,
    required this.text,
  });

  @override
  State<InfoLinksWithImages> createState() => _InfoLinksWithImagesState();
}

class _InfoLinksWithImagesState extends State<InfoLinksWithImages> {
  Color hoverColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.right,
      //TextSpan and widgetSpan render text dependently inside richText,
      //WidgetSpan behaves like a separate block
      //Use Only TextSpan for consistency
      text: TextSpan(
        children: [
          //WidgetSpan(child: Image.asset('.../assets/1.png,')),
          TextSpan(
            text: widget.text,
          ),
          TextSpan(
            text: 'اضغط هنا',
            style: TextStyle(color: hoverColor),
            onEnter: (event) => setState(() {
              hoverColor = Colors.yellow;
            }),
            onExit: (event) => setState(() {
              hoverColor = Colors.black;
            }),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                setState(() {
                  //path
                });
              },
          ),
        ],
      ),
    );
  }
}