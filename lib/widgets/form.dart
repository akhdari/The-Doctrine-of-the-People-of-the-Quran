import 'package:flutter/material.dart';
import 'package:dropdown_flutter/custom_dropdown.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  Rx<String> selectedCountry = 'الجزائر'.obs;
  Rx<String>? emailAddress = ''.obs;
  Rx<String>? phoneNumber = ''.obs;
  late List<TextEditingController> controllers = [];
  late List<FocusNode> focusNodes = [];
  final int feildCount = 6;
  RxBool isAgree1 = false.obs;
  RxBool isAgree2 = false.obs;
  // TODO

  Controller() {
    controllers = List.generate(feildCount, (index) => TextEditingController());
    focusNodes = List.generate(feildCount, (index) => FocusNode());
  }

//TODO RFC 5322
  String? isValidEmail(String? emailAddress) {
    /*It removes spaces from the beginning and end of the string.
If the string contains only spaces, trim() will return an empty string ("")*/
    if (emailAddress == null || emailAddress.trim().isEmpty) {
      return "يجب ادخال ايميل";
    }
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(emailAddress.trim())) {
      return "من فضلك ادخل ايميل صحيح";
    }

    return null; // Valid email
  }

//TODO  international phone number
  String? isValidPhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.trim().isEmpty) {
      return "يجب ادخال رقم هاتف";
    }

    final RegExp phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');

    if (!phoneRegex.hasMatch(phoneNumber.trim())) {
      return "من فضلك ادخل رقم هاتف صحيح";
    }

    return null; // Valid phone number
  }

//we presize the error msg in the validator
//TODO

  String? Function(String?) notEmptyValidator(String errorText) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return errorText;
      }
      return null;
    };
  }

/*  String? notEmptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }*/

  void moveToTheFirstEmptyFeild(GlobalKey<FormState> formKey) {
    if (!formKey.currentState!.validate()) {
      for (int i = 0; i < controllers.length; i++) {
        if (controllers[i].text.isEmpty) {
          focusNodes[i].requestFocus();
          return;
        }
      }
    }
  }
}

class CustomFormWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const CustomFormWidget({super.key, required this.formKey});

  @override
  State<CustomFormWidget> createState() => _CustomFormWidgetState();
}

class _CustomFormWidgetState extends State<CustomFormWidget> {
  //TODO
  bool isAgree3 = false;

  late Controller controller;
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  final List<String> countries = [
    "أفغانستان",
    "الجزائر",
    "البحرين",
    "بنغلاديش",
    "بنين",
    "بروناي",
    "بوركينا فاسو",
    "تشاد",
    "جزر القمر",
    "مصر",
    "جيبوتي",
    "إندونيسيا",
    "إيران",
    "العراق",
    "الأردن",
    "كازاخستان",
    "الكويت",
    "قرغيزستان",
    "لبنان",
    "ليبيا",
    "مالي",
    "موريتانيا",
    "المغرب",
    "عمان",
    "باكستان",
    "فلسطين",
    "قطر",
    "المملكة العربية السعودية",
    "السنغال",
    "سيراليون",
    "الصومال",
    "السودان",
    "سوريا",
    "طاجيكستان",
    "تنزانيا",
    "تونس",
    "تركيا",
    "تركمانستان",
    "الإمارات العربية المتحدة",
    "أوزبكستان",
    "اليمن"
  ];

  @override
  void initState() {
    //Use Get.find when you need to access the same controller instance in a different widget or when lazy initialization
    const int feildCount = 6;
    controllers = List.generate(feildCount, (index) => TextEditingController());
    focusNodes = List.generate(feildCount, (index) => FocusNode());

    controller = Get.find<Controller>();
    controller.controllers = controllers;
    controller.focusNodes = focusNodes;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller = Get.find<Controller>();
    return Scaffold(
      body: Column(
        children: [
          Text('معلومات المدرسة و المشرف'),
          Form(
            key: widget.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //1
                LabeledText(text: 'اسم المدرسة'),
                CummonTextFormFeild(
                  textEditingController: controllers[0],
                  focusNodeFunction: focusNodes[0],
                  textInputType: TextInputType.name,
                  validatorFunction:
                      controller.notEmptyValidator('يجب ادخال اسم المدرسة'),
                  onChangedFunction: (value) {},
                ),

                //2
                LabeledText(text: 'البلد'),
                Obx(
                  () => DropdownFlutter<String>.search(
                    items: countries,
                    initialItem: controller.selectedCountry.value,
                    onChanged: (country) {
                      if (country != null) {
                        controller.selectedCountry.value =
                            country; // No need for setState
                      }
                    },
                  ),
                ),

                //3
                LabeledText(text: 'عنوان المدرسة'),
                CummonTextFormFeild(
                  textEditingController: controllers[1],
                  focusNodeFunction: focusNodes[1],
                  textInputType: TextInputType.name,
                  validatorFunction:
                      controller.notEmptyValidator('يجب ادخال عنوان المدرسة'),
                  onChangedFunction: (value) {},
                ),

                //4, 5
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          LabeledText(text: 'الكنية'),
                          CummonTextFormFeild(
                            textEditingController: controllers[3],
                            focusNodeFunction: focusNodes[3],
                            textInputType: TextInputType.name,
                            validatorFunction: controller
                                .notEmptyValidator('يجب ادخال الكنية'),
                            onChangedFunction: (value) {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          LabeledText(text: 'اسم المشرف'),
                          CummonTextFormFeild(
                            textEditingController: controllers[2],
                            focusNodeFunction: focusNodes[2],
                            textInputType: TextInputType.name,
                            validatorFunction: controller
                                .notEmptyValidator('يجب ادخال اسم المشرف'),
                            onChangedFunction: (value) {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                //6, 7
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          LabeledText(text: 'رقم الواتساب مع رمز الدولة'),
                          CummonTextFormFeild(
                            textEditingController: controllers[5],
                            focusNodeFunction: focusNodes[5],
                            textInputType: TextInputType.number,
                            validatorFunction: controller.isValidPhoneNumber,
                            onChangedFunction: (value) {
                              controller.phoneNumber?.value = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          LabeledText(text: 'البريد الالكتروني'),
                          CummonTextFormFeild(
                            textEditingController: controllers[4],
                            focusNodeFunction: focusNodes[4],
                            textInputType: TextInputType.emailAddress,
                            validatorFunction: controller.isValidEmail,
                            onChangedFunction: (value) {
                              controller.emailAddress?.value = value;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                CustomCheckbox(isAgree: controller.isAgree1, text: 'الشروط والاحكام',),
                CustomCheckbox(isAgree: controller.isAgree2, text: 'سياسة الخصوصية',),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class CustomCheckbox extends StatelessWidget {
  final RxBool isAgree; //the reference to the Rx variable itself cannot change, but the value inside it can still be updated.
  final String text;

  CustomCheckbox({super.key, required this.isAgree, required this.text});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: RichText(
        textAlign: TextAlign.right,
      
        text: TextSpan(
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Obx(() => Checkbox(
                    value: isAgree.value, 
                    onChanged: (bool? value) {
                      isAgree.value = value ?? false; 
                    },
                  )),
            ),
            const TextSpan(
              text: 'اوافق على ',
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: text,
              style: const TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}


/*Obx(()=>Checkbox(
      value: isAgree.value,
      tristate: false, // allows only true or false, and set default to false
      onChanged: (newValue) => isAgree
          .toggle(), //method for toggling Rx boolean value between true and false
    ),);*/
class CummonTextFormFeild extends StatelessWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNodeFunction;
  final TextInputType textInputType;
  final FormFieldValidator<String> validatorFunction;
  final ValueChanged<String> onChangedFunction;
  const CummonTextFormFeild({
    super.key,
    this.textInputType = TextInputType.text,
    required this.validatorFunction,
    required this.onChangedFunction,
    required this.focusNodeFunction,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      focusNode: focusNodeFunction,
      textAlign: TextAlign.right,
      keyboardType: textInputType,
      validator: validatorFunction,
      onChanged: onChangedFunction,
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
  }
}

/*DropdownButtonFormField(
                      items: countries
                          .map((String e) =>
                              DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {},
                    ), */
/*showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('اختر البلد'),
                            content: DropdownButtonFormField(
                              items: countries
                                  .map(
                                    (String e) => DropdownMenuItem(
                                      onTap: () {},
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {},
                            ),
                          );
                        },
                      );*/
class LabeledText extends StatelessWidget {
  final String text;
  const LabeledText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    //text alignement(parent widget)
    return Align(
      alignment: Alignment.centerRight,
      child: Text.rich(
        textAlign: TextAlign.left,
        textDirection: TextDirection.rtl,
        TextSpan(text: text, children: const [
          TextSpan(
              text: '*',
              style: TextStyle(
                color: Colors.red,
              )),
        ]),
      ),
    );
  }
}
