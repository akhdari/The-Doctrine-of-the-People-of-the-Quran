import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/helpers/image.dart';
import '../controllers/subscription_information.dart';
import '../widgets/form.dart';
import 'package:flutter/gestures.dart';
import '../../system/widgets/footer.dart';
import '../../system/widgets/drawer.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/helpers/nav.dart';
import '../../controllers/form_controller.dart' as form;

class CopyPage extends StatefulWidget {
  const CopyPage({super.key});
  @override
  State<CopyPage> createState() => _CopyPageState();
}

class _CopyPageState extends State<CopyPage> {
  final copyPageFormKey = GlobalKey<FormState>();
  final copyPageScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final scaffoldBackgroundColor = theme.scaffoldBackgroundColor;
    form.FormController formController =
        Get.find<form.FormController>(tag: "copyPage");
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: copyPageScaffoldKey,
      backgroundColor: scaffoldBackgroundColor,
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Container(color: theme.appBarTheme.backgroundColor),
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
                    scaffoldKey: copyPageScaffoldKey,
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
                        onEmptyFeild: () => formController
                            .moveToFirstEmptyField(copyPageFormKey),
                        subscriptionFormKey: copyPageFormKey,
                      ),
                      SizedBox(height: 20), // Add spacing for small screens
                      CustomFormWidget(formKey: copyPageFormKey),
                    ],
                  );
                } else {
                  return Row(
                    children: [
                      Expanded(
                        child: SubscriptionInformation(
                          onEmptyFeild: () => formController
                              .moveToFirstEmptyField(copyPageFormKey),
                          subscriptionFormKey: copyPageFormKey,
                        ),
                      ),
                      Expanded(
                          child: CustomFormWidget(formKey: copyPageFormKey)),
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
            WidgetSpan(child: CustomAssetImage(assetPath: 'page.png')),
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
                    //TODO: Add  path
                  });
                },
            ),
          ],
        ),
      ),
    );
  }
}
