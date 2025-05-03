import 'package:flutter/material.dart';
import 'package:dropdown_flutter/custom_dropdown.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/validator.dart';
import 'custom_checkbox.dart';
import '/system/utils/const/form.dart';

class CustomFormWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const CustomFormWidget({super.key, required this.formKey});

  @override
  State<CustomFormWidget> createState() => _CustomFormWidgetState();
}

class _CustomFormWidgetState extends State<CustomFormWidget> {
  late Validator formcontroller;

  @override
  void initState() {
    super.initState();
    Get.put(Validator(6), permanent: true, tag: "copyPage");
  }

  @override
  Widget build(BuildContext context) {
    formcontroller = Get.find<Validator>(tag: "copyPage");
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text('معلومات المدرسة و المشرف'),
          Form(
            key: widget.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //1
                const LabeledText(text: 'اسم المدرسة'),
                TextFormField(
                  controller: formcontroller.controllers[0],
                  focusNode: formcontroller.focusNodes[0],
                  keyboardType: TextInputType.name,
                  validator:
                      formcontroller.notEmptyValidator('يجب ادخال اسم المدرسة'),
                  textAlign: TextAlign.right,
                ),

                //2
                const LabeledText(text: 'البلد'),
                Obx(
                  () => DropdownFlutter<String>.search(
                    items: countries,
                    initialItem: formcontroller.selectedCountry.value,
                    onChanged: (country) {
                      if (country != null) {
                        formcontroller.selectedCountry.value = country;
                      }
                    },
                  ),
                ),

                //3
                const LabeledText(text: 'عنوان المدرسة'),
                TextFormField(
                  controller: formcontroller.controllers[1],
                  focusNode: formcontroller.focusNodes[1],
                  keyboardType: TextInputType.name,
                  validator: formcontroller
                      .notEmptyValidator('يجب ادخال عنوان المدرسة'),
                  textAlign: TextAlign.right,
                ),

                //4, 5
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const LabeledText(text: 'الكنية'),
                          TextFormField(
                            controller: formcontroller.controllers[3],
                            focusNode: formcontroller.focusNodes[3],
                            keyboardType: TextInputType.name,
                            validator: formcontroller
                                .notEmptyValidator('يجب ادخال الكنية'),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: [
                          const LabeledText(text: 'اسم المشرف'),
                          TextFormField(
                            controller: formcontroller.controllers[2],
                            focusNode: formcontroller.focusNodes[2],
                            keyboardType: TextInputType.name,
                            validator: formcontroller
                                .notEmptyValidator('يجب ادخال اسم المشرف'),
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
                          const LabeledText(text: 'رقم الواتساب مع رمز الدولة'),
                          TextFormField(
                            controller: formcontroller.controllers[5],
                            focusNode: formcontroller.focusNodes[5],
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (v) => formcontroller.isValidPhoneNumber(
                                formcontroller.controllers[5].text),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: [
                          const LabeledText(text: 'البريد الالكتروني'),
                          TextFormField(
                            controller: formcontroller.controllers[4],
                            focusNode: formcontroller.focusNodes[4],
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) => formcontroller.isValidEmail(
                                formcontroller.controllers[4].text),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Checkboxes

                CheckboxFormField(
                  text: 'الشروط والاحكام',
                  errorText: 'يجب الموافقة على الشروط',
                ),

                CheckboxFormField(
                  text: 'سياسة الخصوصية',
                  errorText: 'يجب الموافقة على سياسة الخصوصية',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LabeledText extends StatelessWidget {
  final String text;
  const LabeledText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
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
