import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/subscription_information.dart';
import '../widgets/form.dart';
import 'package:flutter/gestures.dart';
import '../widgets/footer.dart';
import '../widgets/drawer.dart';
import '../widgets/nav.dart';

class CopyPage extends StatefulWidget {
  const CopyPage({super.key});

  @override
  State<CopyPage> createState() => _CopyPageState();
}

class _CopyPageState extends State<CopyPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Controller controller = Get.find<Controller>();
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Container(color: Color(0xFF0E9D6D)),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/back.png'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.white.withValues(alpha: 0.2),
                            BlendMode.dstIn),
                      ),
                    ),
                  ),
                  NavBar(
                    scaffoldKey: scaffoldKey,
                  )
                ],
              ),
            ),
            learnMoreSection(screenSize),
            SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                // Check screen width, use Column for small screens
                if (constraints.maxWidth < 1000) {
                  // Adjust threshold as needed
                  return Column(
                    children: [
                      SubscriptionInformation(
                        onEmptyFeild: () =>
                            controller.moveToTheFirstEmptyFeild(formKey),
                        formKey: formKey,
                      ),
                      SizedBox(height: 20), // Add spacing for small screens
                      CustomFormWidget(formKey: formKey),
                    ],
                  );
                } else {
                  return Row(
                    children: [
                      Expanded(
                        child: SubscriptionInformation(
                          onEmptyFeild: () =>
                              controller.moveToTheFirstEmptyFeild(formKey),
                          formKey: formKey,
                        ),
                      ),
                      Expanded(child: CustomFormWidget(formKey: formKey)),
                    ],
                  );
                }
              },
            ),
            SizedBox(height: 80),
            FooterSection(),
          ],
        ),
      ),
    );
  }

  Container learnMoreSection(Size screenSize) {
    return Container(
      height: screenSize.height * 0.2,
      width: screenSize.width * 0.9,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: const [
          InfoLinksWithImages(text: ' تريد التعرف على النظام أكثر ؟'),
          InfoLinksWithImages(text: 'تريد التعرف على العروض والأسعار ؟')
        ],
      ),
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: RichText(
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
      ),
    );
  }
}
