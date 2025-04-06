import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import './widgets/containers.dart';
import './widgets/input_field.dart';
import 'widgets/picker.dart';
import './widgets/end_drawer.dart';
import 'package:get/get.dart';
import './widgets/theme.dart';
import 'dart:math';
import '../logic/validators.dart';
import '/web/widgets/snackbar.dart';

class Generate extends GetxController {
  //username generation
  String generateUsername(
      TextEditingController lastName, TextEditingController firstName) {
    if (firstName.text.isNotEmpty && lastName.text.isNotEmpty) {
      Random random = Random();

      String ln = lastName.text.trim();
      String fn = firstName.text.trim();

      String lnPart = ln.length >= 3 ? ln.substring(0, 3) : ln;
      String fnPart = fn.length >= 3 ? fn.substring(0, 3) : fn;

      String username =
          lnPart + fnPart + random.nextInt(10).toString(); // up to 999

      return username;
    } else {
      //TODO
      return "please enter your name";
    }
  }

//password generation
  String generatePassword() {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#%&*';
    const length = 10;
    final Random random = Random.secure();
    String password =
        //random.nextInt = generate a random index
        //(chars.length) = between 0 and the length of chars -1
        //join = list of string -> string
        List.generate(length, (index) => chars[random.nextInt(chars.length)])
            .join();

    return password;
  }
}

const List<String> sex = ["male", "female"];
const List<String> bloodType = [
  "A+",
  "A-",
  "B+",
  "B-",
  "AB+",
  "AB-",
  "O+",
  "O-"
];
const List<String> yesNo = ["yes", "no"];
const List<String> state = ["alive", "dead"];
//generation happens length times
List<TextEditingController> textcontrollers =
    List.generate(14, (index) => TextEditingController());
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
  TextEditingController userNameController = textcontrollers[8];
  TextEditingController passwordController = textcontrollers[9];
  TextEditingController firstNameController = textcontrollers[3];
  TextEditingController lastNameController = textcontrollers[4];
  final ThemeController themeController = Get.find<ThemeController>();
  final Generate generate = Get.find<Generate>();
  final Validator validator = Get.find<Validator>();
  @override
  void initState() {
    super.initState();
    Get.put(Generate());
    passwordController.text = generate.generatePassword();
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
                dev.log("theme changed");
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
                                                      inputTitle: "sessions:",
                                                      child: CustomTextField(
                                                        controller:
                                                            textcontrollers[0],
                                                      )),
                                                ),
                                                SizedBox(height: 10),
                                                CustomContainer(
                                                  title:
                                                      "Students' Personal Info",
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
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
                                                                      "First name in Arabic",
                                                                  child:
                                                                      CustomTextField(
                                                                    controller:
                                                                        textcontrollers[
                                                                            1],
                                                                    validator: validator
                                                                        .notEmptyValidator(
                                                                            "يجب ادخال الاسم"),
                                                                  )),
                                                            ),
                                                            SizedBox(width: 8),
                                                            Expanded(
                                                                child:
                                                                    InputField(
                                                                        inputTitle:
                                                                            "Last name in Arabic",
                                                                        child:
                                                                            CustomTextField(
                                                                          controller:
                                                                              textcontrollers[2],
                                                                          validator:
                                                                              validator.notEmptyValidator("يجب ادخال الاسم"),
                                                                        ))),
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
                                                                    "First name in Latin",
                                                                child:
                                                                    CustomTextField(
                                                                  controller:
                                                                      firstNameController,
                                                                  textDirection:
                                                                      TextDirection
                                                                          .ltr,
                                                                  onChanged:
                                                                      (_) {
                                                                    userNameController
                                                                            .text =
                                                                        generate.generateUsername(
                                                                            lastNameController,
                                                                            firstNameController);
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(width: 8),
                                                            Expanded(
                                                                child:
                                                                    InputField(
                                                              inputTitle:
                                                                  "Last name in Latin",
                                                              child:
                                                                  CustomTextField(
                                                                controller:
                                                                    lastNameController,
                                                                textDirection:
                                                                    TextDirection
                                                                        .ltr,
                                                                onChanged: (_) {
                                                                  userNameController
                                                                          .text =
                                                                      generate.generateUsername(
                                                                          lastNameController,
                                                                          firstNameController);
                                                                },
                                                              ),
                                                            )),
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
                                                                child:
                                                                    InputField(
                                                                        inputTitle:
                                                                            "Sex",
                                                                        child:
                                                                            dropDown(
                                                                          sex,
                                                                          sex[0],
                                                                        ))),
                                                            SizedBox(width: 8),
                                                            Expanded(
                                                              child: InputField(
                                                                inputTitle:
                                                                    "Date of Birth",
                                                                child:
                                                                    CustomTextField(
                                                                  controller:
                                                                      textcontrollers[
                                                                          5],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      // Row 4
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: InputField(
                                                            inputTitle:
                                                                "Nationality",
                                                            child:
                                                                CustomTextField(
                                                              controller:
                                                                  textcontrollers[
                                                                      6],
                                                            ),
                                                          )),
                                                          SizedBox(width: 8),
                                                          Expanded(
                                                              child: InputField(
                                                            inputTitle:
                                                                "Address",
                                                            child:
                                                                CustomTextField(
                                                              controller:
                                                                  textcontrollers[
                                                                      7],
                                                            ),
                                                          )),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                CustomContainer(
                                                    title: "account info",
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            child: InputField(
                                                          inputTitle:
                                                              "username",
                                                          child:
                                                              CustomTextField(
                                                            controller:
                                                                userNameController,
                                                          ),
                                                        )),
                                                        SizedBox(width: 8),
                                                        Expanded(
                                                            child: InputField(
                                                          inputTitle:
                                                              "password",
                                                          child:
                                                              CustomTextField(
                                                            controller:
                                                                passwordController,
                                                          ),
                                                        )),
                                                      ],
                                                    )),

                                                SizedBox(height: 10),
                                                CustomContainer(
                                                  title: "health info",
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          child: InputField(
                                                              inputTitle:
                                                                  "blood type",
                                                              child: dropDown(
                                                                  bloodType,
                                                                  bloodType[
                                                                      0]))),
                                                      SizedBox(width: 8),
                                                      Expanded(
                                                          child: InputField(
                                                              inputTitle:
                                                                  "has desease",
                                                              child: dropDown(
                                                                  yesNo,
                                                                  yesNo[1]))),
                                                      SizedBox(width: 8),
                                                      Expanded(
                                                          child: InputField(
                                                        inputTitle:
                                                            "desease causes",
                                                        child: CustomTextField(
                                                          controller:
                                                              textcontrollers[
                                                                  10],
                                                        ),
                                                      ))
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10),

                                                CustomContainer(
                                                    title: "contact info",
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            child: InputField(
                                                          inputTitle:
                                                              "phone number",
                                                          child:
                                                              CustomTextField(
                                                            controller:
                                                                textcontrollers[
                                                                    11],
                                                            validator: (String?
                                                                    value) =>
                                                                validator
                                                                    .isValidPhoneNumber(
                                                                        value),
                                                          ),
                                                        )),
                                                        SizedBox(width: 8),
                                                        Expanded(
                                                            child: InputField(
                                                          inputTitle:
                                                              "email address",
                                                          child:
                                                              CustomTextField(
                                                            controller:
                                                                textcontrollers[
                                                                    12],
                                                            validator: (String?
                                                                value) {
                                                              return validator
                                                                  .isValidEmail(
                                                                      value);
                                                            },
                                                          ),
                                                        )),
                                                      ],
                                                    )),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: CustomContainer(
                                                            title:
                                                                "fother state",
                                                            child: dropDown(
                                                                state,
                                                                state[0]))),
                                                    Expanded(
                                                        child: CustomContainer(
                                                            title:
                                                                "mother state",
                                                            child: dropDown(
                                                                state,
                                                                state[0]))),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                CustomContainer(
                                                  title: "info about guardient",
                                                  child: InputField(
                                                    inputTitle:
                                                        "guardient's account",
                                                    child: CustomTextField(
                                                      controller:
                                                          textcontrollers[13],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                CustomContainer(
                                                  title: "add account image",
                                                  //inputFeild("add image"),
                                                  child: Text("add image"),
                                                ),
                                                SizedBox(height: 10),
                                                //DropdownButton
                                                SizedBox(height: 10),
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
                                            onPressed: () {
                                              validator
                                                  .moveToTheFirstEmptyFeild(
                                                      formKey);
                                              showSnackBar(context, formKey);
                                            },
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

  DropdownButtonFormField<String> dropDown(
      List<String> items, String initialValue) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
          filled: false,
          hoverColor: null,
          fillColor: null,
          focusColor: null,
          border: OutlineInputBorder()),
      value: initialValue,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) {},
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
