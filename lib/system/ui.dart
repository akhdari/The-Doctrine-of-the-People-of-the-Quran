import 'dart:developer';

import 'package:flutter/material.dart';
import './widgets/containers.dart';
import './widgets/matrix/custom_matrix.dart';
import './widgets/input_field.dart';
import 'widgets/picker.dart';
import './widgets/end_drawer.dart';
import 'package:get/get.dart';
import './widgets/theme.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class SystemUI extends StatefulWidget {
  const SystemUI({
    super.key,
  });

  @override
  State<SystemUI> createState() => _SystemUIState();
}

class _SystemUIState extends State<SystemUI> {
  Picker picker = Picker();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isClicked = false;
  final ThemeController themeController = Get.find<ThemeController>();
  @override
  void initState() {
    super.initState();
    // final ThemeController themeController = Get.find<ThemeController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                //Scaffold.of(context)
                _scaffoldKey.currentState?.openEndDrawer();
              });
            },
          ),
        ],
      ),
      endDrawer: customEndDrawer(),
      //diallog with scrollable indecator
      body: Column(
        children: [
          IconButton(
              onPressed: () {
                isClicked = !isClicked;
                themeController.switchTheme();
                log("theme changed");
              },
              icon: Icon(Icons.nightlight_round)),
          Center(
            child: OutlinedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        ScrollController controller = ScrollController();
                        return ConstrainedBox(
                          //Dialog constraints
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                            maxHeight: MediaQuery.of(context).size.height * 0.8,
                          ),
                          child: Dialog(
                              shape: BeveledRectangleBorder(),
                              backgroundColor: Colors.white,
                              //the dialog should have a child for it to show
                              child: Scrollbar(
                                  /*
                                if not attached to the scrollable widget, will cause The Scrollbar's ScrollController has no ScrollPosition attached error.
                                To fix this, you need to create a ScrollController and attach it to both the Scrollbar
                                */
                                  controller: controller,
                                  child: Column(
                                    children: [
                                      Stack(children: [
                                        ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                              Colors.white, BlendMode.dstIn),
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            color: Color(0xFF0E9D6D),
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          child: ClipRRect(
                                            //borderRadius: BorderRadius.circular(5),
                                            child: Image.asset(
                                              "assets/back.png",
                                              fit: BoxFit
                                                  .cover, //prevent immage duplication in small CustomContainer
                                              //other options: cover, contain
                                            ),
                                          ),
                                        ),
                                      ]),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          controller: controller,
                                          //EdgeOverflow =>padding
                                          padding: EdgeInsets.all(20),
                                          child: Form(
                                            key: formKey,
                                            child: Column(
                                              children: [
                                                CustomContainer(
                                                  title: "session",
                                                  child: InputField(
                                                      inputTitle: "sessions:"),
                                                ),
                                                SizedBox(height: 10),
                                                CustomContainer(
                                                  title:
                                                      "Students' Personal Info",
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: const [
                                                      // Row 1
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 8.0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                                child: InputField(
                                                                    inputTitle:
                                                                        "First name in Arabic")),
                                                            SizedBox(width: 8),
                                                            Expanded(
                                                                child: InputField(
                                                                    inputTitle:
                                                                        "Last name in Arabic")),
                                                          ],
                                                        ),
                                                      ),
                                                      // Row 2
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 8.0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                                child: InputField(
                                                                    inputTitle:
                                                                        "First name in Latin")),
                                                            SizedBox(width: 8),
                                                            Expanded(
                                                                child: InputField(
                                                                    inputTitle:
                                                                        "Last name in Latin")),
                                                          ],
                                                        ),
                                                      ),
                                                      // Row 3
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 8.0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                                child: InputField(
                                                                    inputTitle:
                                                                        "Sex")),
                                                            SizedBox(width: 8),
                                                            Expanded(
                                                                child: InputField(
                                                                    inputTitle:
                                                                        "Date of Birth")),
                                                          ],
                                                        ),
                                                      ),
                                                      // Row 4
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: InputField(
                                                                  inputTitle:
                                                                      "Nationality")),
                                                          SizedBox(width: 8),
                                                          Expanded(
                                                              child: InputField(
                                                                  inputTitle:
                                                                      "Address")),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                CustomContainer(
                                                    title: "account info",
                                                    child: Row(
                                                      children: const [
                                                        Expanded(
                                                            child: InputField(
                                                                inputTitle:
                                                                    "username")),
                                                        SizedBox(width: 8),
                                                        Expanded(
                                                            child: InputField(
                                                                inputTitle:
                                                                    "password")),
                                                      ],
                                                    )),

                                                SizedBox(height: 10),
                                                CustomContainer(
                                                  title: "health info",
                                                  child: Row(
                                                    children: const [
                                                      Expanded(
                                                          child: InputField(
                                                              inputTitle:
                                                                  "blood type")),
                                                      SizedBox(width: 8),
                                                      Expanded(
                                                          child: InputField(
                                                              inputTitle:
                                                                  "has a desease?")),
                                                      SizedBox(width: 8),
                                                      Expanded(
                                                          child: InputField(
                                                              inputTitle:
                                                                  "desease causes"))
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10),

                                                CustomContainer(
                                                    title: "contact info",
                                                    child: Row(
                                                      children: const [
                                                        Expanded(
                                                            child: InputField(
                                                                inputTitle:
                                                                    "phone number")),
                                                        SizedBox(width: 8),
                                                        Expanded(
                                                            child: InputField(
                                                                inputTitle:
                                                                    "email address")),
                                                      ],
                                                    )),
                                                SizedBox(height: 10),
                                                CustomContainer(
                                                    title: "parents state",
                                                    child: Row(
                                                      children: const [
                                                        Expanded(
                                                            child: InputField(
                                                                inputTitle:
                                                                    "father's state")),
                                                        SizedBox(width: 8),
                                                        Expanded(
                                                            child: InputField(
                                                                inputTitle:
                                                                    "mother's state")),
                                                      ],
                                                    )),
                                                SizedBox(height: 10),
                                                CustomContainer(
                                                  title: "info about guardient",
                                                  child: InputField(
                                                      inputTitle:
                                                          "guardient's account"),
                                                ),
                                                SizedBox(height: 10),
                                                CustomContainer(
                                                  title: "add account image",
                                                  //inputFeild("add image"),
                                                  child: Picker(),
                                                ),
                                                SizedBox(height: 10),
                                                //DropdownButton
                                                DropdownButtonFormField<String>(
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  value: '1',
                                                  items: [
                                                    '1',
                                                    '2',
                                                    '3',
                                                    '4',
                                                    '5'
                                                  ].map((String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String? value) {},
                                                ),
                                                SizedBox(height: 10),
                                                CustomMatrix()
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: OutlinedButton(
                                            style: ButtonStyle(
                                              side: WidgetStateProperty
                                                  .all<BorderSide>(BorderSide(
                                                      width: 1,
                                                      color:
                                                          Color(0xff169b88))),
                                              shape: WidgetStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5))),
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                Color(0xff169b88),
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: Text("send")),
                                      ),
                                    ],
                                  ))),
                        );
                      });
                },
                child: Text("open dialog")),
          ),
        ],
      ),
    );
  }
}

/*Expanded vs Flexibale 
Flexibal = take the space u need
Expanded = take all the remaining space
both are used when Multiple widgets should share available space
*/

/*
add padding to a widget:
*wrap with padding widget
*/
/*
add both margin and padding to a widget:
wrap with container
*/
