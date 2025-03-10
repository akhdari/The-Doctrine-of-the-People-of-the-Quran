import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:get/get.dart';

class SubscriptionInformationController extends GetxController {
  RxInt totalPrice = 0.obs;
  //RxInt studentNum = 20.obs; //TODO 20?
  TextEditingController studentNumController = TextEditingController();

  /* void updateStudentNum() {
    int? value = int.tryParse(studentNumController
        .text); //if conversion fails of input invalid return null
    //the diffrence between parse and try parse is that tryParse returns null Instead of craching
    if (value == null) {
      studentNum.value = 20; //return?
    } else {
      //input less then 20 wont be accepted
      studentNum.value = value;
    }
  }*/
  static const int minStudentNum = 20;
  static const int basePrice = 29900;
  static const int pricePerStudent = 150;

  void increment() {
    int currentValue = int.tryParse(studentNumController.text) ?? minStudentNum;
    studentNumController.text = (currentValue + 1).toString();
    //studentNum.value = currentValue + 1;
  }

  // Decrement student number
  void decrement() {
    int currentValue = int.tryParse(studentNumController.text) ?? minStudentNum;
    if (currentValue > minStudentNum) {
      studentNumController.text = (currentValue - 1).toString();
      //studentNum.value = currentValue - 1;
    }
  }

  int calculateTotalPrice() {
    int? studentNum = int.tryParse(studentNumController.text) ?? minStudentNum;
    return basePrice + totalPrice.value + (studentNum * pricePerStudent);
  }

  /*@override
  void onInit() {
    studentNumController.text = studentNum.toString();
    super.onInit();
  }
*/
  @override
  void onClose() {
    studentNumController.dispose();
    super.onClose();
  }
}

//TODO when to revert to minValue
class NumberLimitFormatter extends TextInputFormatter {
  final int minValue;
  NumberLimitFormatter({required this.minValue});
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    int? value = int.tryParse(newValue.text);
    if (newValue.text.isEmpty) {
      //allow empty input for flexibility, so that the textfeild doesnt always revert to the initial value(can be empty).
      return newValue;
    } else if (value == null || value < minValue) {
      //if new input doesnt min condition return old  value
      return oldValue; //oldValue = the previous input that matched requirements
    }
    //otherwise allow the new value
    return newValue;
  }
}

class SubscriptionInformation extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function onEmptyFeild;
  const SubscriptionInformation({
    super.key,
    required this.formKey,
    required this.onEmptyFeild,
  });
  @override
  State<SubscriptionInformation> createState() =>
      _SubscriptionInformationState();
}

class _SubscriptionInformationState extends State<SubscriptionInformation>
    with SingleTickerProviderStateMixin {
  Rx<double> y = 0.0.obs;
  late AnimationController _controller;
  late Animation<double> _animation;

  void showSnackBar() {
    if (widget.formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Valid form')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid form')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut))
      ..addListener(() {
        y.value = _animation.value;
      });

    //setState() should only be used when the widget is already built.
  }

  void toggleAnimation() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SubscriptionInformationController studentCountManagement =
        Get.find<SubscriptionInformationController>();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            'معلومات الاشتراك',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Center(
            child: Text(
              'أدخل عدد الطلاب',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          TextField(
            controller: studentCountManagement.studentNumController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              //inputFormatters are applied in order
              // FilteringTextInputFormatter is asubclass of TextInputFormatter
              FilteringTextInputFormatter.digitsOnly, //[0-9]
              //LengthLimitingTextInputFormatter(2),
              //NumberLimitFormatter(minValue: 20),
            ],
            /*onChanged: (value) {
                  studentCountManagement.updateStudentNum();
                },*/
            decoration: InputDecoration(
              hintText: ' عدد الطلاب (اقل من20 ) ',
              prefixIcon: IconButton(
                onPressed: () {
                  studentCountManagement.increment();
                },
                icon: Icon(Icons.add),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  studentCountManagement.decrement();
                },
                icon: Icon(Icons.remove),
              ),
              border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'إختر الخدمات الإضافية',
          ),
          SizedBox(
            height: 5,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: DottedBorderButton(
                  serviceName: 'الحلقات الالكترونية',
                  serviceIcone: Icons.camera_alt,
                  onTap: () {
                    studentCountManagement.totalPrice.value += 9900;
                  },
                  onTapUp: () {
                    studentCountManagement.totalPrice.value -= 9900;
                  },
                ),
              ),
              Expanded(
                child: DottedBorderButton(
                  serviceName: 'الشؤون المالية',
                  serviceIcone: Icons.data_exploration_sharp,
                  onTap: () {
                    studentCountManagement.totalPrice.value += 19900;
                  },
                  onTapUp: () {
                    studentCountManagement.totalPrice.value -= 19900;
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: DottedBorderButton(
                  serviceName: 'موقع تعريفي',
                  serviceIcone: Icons.computer,
                  onTap: () {
                    studentCountManagement.totalPrice.value += 19900;
                  },
                  onTapUp: () {
                    studentCountManagement.totalPrice.value -= 19900;
                  },
                ),
              ),
              Expanded(
                child: DottedBorderButton(
                  serviceName: 'الرسائل الخاصة',
                  serviceIcone: Icons.email,
                  onTap: () {
                    studentCountManagement.totalPrice.value += 9900;
                  },
                  onTapUp: () {
                    studentCountManagement.totalPrice.value -= 9900;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("التفاصيل"),
              //can student num be null? add validator
              Obx(() => Text(
                    "${studentCountManagement.calculateTotalPrice()}",
                  )),
              Text("المبلغ الاجمالي"),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          Text(
              'بعد تأكيد الطّلب ستصلك رسالة عبر البريد الإلكتروني بها طرق الدّفع الممكنة'),
          SizedBox(
            height: 10,
          ),
          //symmetric reveal animation
          //showSnackBar() + moveToTheFirstEmptyFeild()
          Obx(() => CustomButton(
                onPressFunction: () {
                  widget
                      .onEmptyFeild(); //widget.functionName = refers to the function itself, with () = function call
                  showSnackBar();
                },
                y: y.value,
                formKey: widget.formKey,
                toggleAnimation: toggleAnimation,
              )),
        ],
      ),
    );
  }
}

//Custom Button
class CustomButton extends StatefulWidget {
  final double y;
  final GlobalKey<FormState> formKey;
  final VoidCallback toggleAnimation;
  final VoidCallback onPressFunction;
  const CustomButton({
    super.key,
    required this.y,
    required this.formKey,
    required this.toggleAnimation,
    required this.onPressFunction,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => widget.toggleAnimation()),
      onExit: (event) => setState(() => widget.toggleAnimation()),
      child: Transform.translate(
        offset: Offset(0, -widget.y * 5),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ]),
          child: AnimatedButton(
            text: 'تأكيد الطلب',
            textOverflow: TextOverflow.visible,
            isReverse: true,
            onPress: widget.onPressFunction,
            transitionType: TransitionType.CENTER_LR_IN,
            //textStyle:,
            //width: ,
            //height: ,
            borderRadius: 5,
            backgroundColor: Color(0xffBD8A36),
            selectedBackgroundColor: Colors.blueAccent,
            selectedTextColor: Colors.white,
            animationDuration: Duration(seconds: 1),
            animatedOn: AnimatedOn.onHover,
          ),
        ),
      ),
    );
  }
}

// Dotted Border Button

class DottedBorderButton extends StatefulWidget {
  final VoidCallback onTap;
  final VoidCallback onTapUp;
  final String serviceName;
  final IconData serviceIcone;
  const DottedBorderButton({
    super.key,
    required this.onTap,
    required this.serviceName,
    required this.serviceIcone,
    required this.onTapUp,
  });

  @override
  State<DottedBorderButton> createState() => _DottedBorderButtonState();
}

class _DottedBorderButtonState extends State<DottedBorderButton> {
  bool isOn = false;

  void toggleSwitch() {
    setState(() {
      isOn = !isOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: GestureDetector(
        onTap: () {
          toggleSwitch();
          if (isOn) {
            widget.onTap();
          } else {
            widget.onTapUp();
          }
        },
        child: SizedBox(
          height: 100,
          width: 240,
          child: Stack(
            children: [
              // ColoredBox with the same dimensions and border radius as DottedBorder
              Positioned.fill(
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10), // Match DottedBorder's radius
                  child: ColoredBox(
                    color: isOn
                        ? Color(0xff1D6176)
                        //.withOpacity() to add transparency
                        : Colors.transparent,
                  ),
                ),
              ),
              // DottedBorder
              DottedBorder(
                color: Colors.greenAccent,
                radius: Radius.circular(10),
                borderType: BorderType.RRect,
                dashPattern: const [5, 2], // Dashed border pattern
                strokeWidth: 0.5,
                strokeCap: StrokeCap.round,
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.serviceName,
                        style: TextStyle(
                          color: isOn
                              ? Colors.white
                              : Colors.black, // Dynamic text color
                        ),
                      ),
                      SizedBox(height: 10),
                      Icon(
                        widget.serviceIcone,
                        color: isOn
                            ? Colors.white
                            : Colors.black, // Dynamic icon color
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






/*
GestureDetector(
              onTap: () {},
              child: MouseRegion(
                onEnter: (event) => setState(() {
                  progress = 1;
                }),
                onExit: (event) => setState(() {
                  progress = 0;
                }),
                cursor: SystemMouseCursors.click,
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: progress),
                  duration: Duration(milliseconds: 300),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, -value * 5),
                      child: Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 31, vertical: 13),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                          gradient: LinearGradient(
                            colors: const [
                              Colors.blue, // Blue starts at the edges
                              Color(0xffBD8A36), // Yellow in the center
                              Color(0xffBD8A36), // Yellow in the center
                              Colors.blue, // Blue at the edges
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [
                              (1 - value) / 2, // Moves blue inward
                              0.5 - (value / 2), // Expands yellow center
                              0.5 + (value / 2), // Expands yellow center
                              (1 + value) / 2, // Moves blue inward
                            ],
                          ),
                        ),
                        
                        child: Text(
                          "تأكيد الطلب",
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
*/
