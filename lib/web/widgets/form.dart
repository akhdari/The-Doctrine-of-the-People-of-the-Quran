import 'package:flutter/material.dart';
import 'package:dropdown_flutter/custom_dropdown.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../logic/validators.dart';
import 'custom_checkbox.dart';

class CustomFormWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const CustomFormWidget({super.key, required this.formKey});

  @override
  State<CustomFormWidget> createState() => _CustomFormWidgetState();
}

class _CustomFormWidgetState extends State<CustomFormWidget> {
  //TODO
  bool isAgree3 = false;

  late Validator formcontroller;
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
    //const int feildCount = 6;
    /*controllers = List.generate(feildCount, (index) => TextEditingController());
    focusNodes = List.generate(feildCount, (index) => FocusNode());*/
    Get.put(Validator(6), permanent: true, tag: "copyPage");
    super.initState();
  }

  /* @override
  void dispose() {
    controller.dispose();
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    formcontroller = Get.find<Validator>(tag: "copyPage");
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
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
                TextFormField(
                  controller: formcontroller.controllers[0],
                  focusNode: formcontroller.focusNodes[0],
                  keyboardType: TextInputType.name,
                  validator:
                      formcontroller.notEmptyValidator('يجب ادخال اسم المدرسة'),
                  onChanged: (value) {},
                  textAlign: TextAlign.right,
                ),

                //2
                LabeledText(text: 'البلد'),
                Obx(
                  () => DropdownFlutter<String>.search(
                    items: countries,
                    initialItem: formcontroller.selectedCountry.value,
                    onChanged: (country) {
                      if (country != null) {
                        formcontroller.selectedCountry.value =
                            country; // No need for setState
                      }
                    },
                  ),
                ),

                //3
                LabeledText(text: 'عنوان المدرسة'),
                TextFormField(
                  controller: formcontroller.controllers[1],
                  focusNode: formcontroller.focusNodes[1],
                  keyboardType: TextInputType.name,
                  validator:
                      formcontroller.notEmptyValidator('يجب ادخال اسم المدرسة'),
                  onChanged: (value) {},
                  textAlign: TextAlign.right,
                ),

                //4, 5
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          LabeledText(text: 'الكنية'),
                          TextFormField(
                            controller: formcontroller.controllers[3],
                            focusNode: formcontroller.focusNodes[3],
                            keyboardType: TextInputType.name,
                            validator: formcontroller
                                .notEmptyValidator('يجب ادخال اسم المدرسة'),
                            onChanged: (value) {},
                            textAlign: TextAlign.right,
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
                          TextFormField(
                            controller: formcontroller.controllers[2],
                            focusNode: formcontroller.focusNodes[2],
                            keyboardType: TextInputType.name,
                            validator: formcontroller
                                .notEmptyValidator('يجب ادخال اسم المدرسة'),
                            onChanged: (value) {},
                            textAlign: TextAlign.right,
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
                          TextFormField(
                            controller: formcontroller.controllers[5],
                            focusNode: formcontroller.focusNodes[5],
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              //prevent or allow certain input from being entered to the input feild
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (v) {
                              return formcontroller.isValidPhoneNumber(
                                  formcontroller.controllers[5].text);
                            },
                            textAlign: TextAlign.right,
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
                          TextFormField(
                            controller: formcontroller.controllers[4],
                            focusNode: formcontroller.focusNodes[4],
                            keyboardType: TextInputType.name,
                            validator: (v) {
                              return formcontroller.isValidEmail(
                                  formcontroller.controllers[4].text);
                            },
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                CustomCheckbox(
                  isAgree: formcontroller.isAgree1,
                  text: 'الشروط والاحكام',
                ),
                CustomCheckbox(
                  isAgree: formcontroller.isAgree2,
                  text: 'سياسة الخصوصية',
                ),
              ],
            ),
          ),
        ],
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
