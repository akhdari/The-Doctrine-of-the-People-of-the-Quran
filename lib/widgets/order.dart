import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class Order extends StatefulWidget {
  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> with SingleTickerProviderStateMixin {
  double y = 0;
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {
          y = _animation.value;
        });
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
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.add),
                suffixIcon: Icon(Icons.remove),
                hintText: ' عدد الطلاب (اقل من20 ) ',
                border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
              ),
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DottedBorderButton(
                  onTap: () {},
                  serviceName: 'الحلقات الالكترونية',
                  serviceIcone: Icon(Icons.camera_alt),
                ),
                DottedBorderButton(
                  onTap: () {},
                  serviceName: 'الشؤون المالية',
                  serviceIcone: Icon(Icons.data_exploration_sharp),
                ),
              ],
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DottedBorderButton(
                  onTap: () {},
                  serviceName: 'موقع تعريفي',
                  serviceIcone: Icon(Icons.computer),
                ),
                DottedBorderButton(
                  onTap: () {},
                  serviceName: 'الرسائل الخاصة',
                  serviceIcone: Icon(Icons.email),
                ),
              ],
            ),
            //TODO
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("التفاصيل"),
                Text(""),
                Text("المبلغ الاجمالي"),
              ],
            ),
            Divider(),
            Text(
                'بعد تأكيد الطّلب ستصلك رسالة عبر البريد الإلكتروني بها طرق الدّفع الممكنة'),
            SizedBox(
              height: 10,
            ),
            //symmetric reveal animation
            MouseRegion(
              onEnter: (event) => setState(() => toggleAnimation()),
              onExit: (event) => setState(() => toggleAnimation()),
              child: Transform.translate(
                offset: Offset(0, -y * 5),
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
                    onPress: () {},
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
                    //TODO textOverflow, selectedtext
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class DottedBorderButton extends StatelessWidget {
  final VoidCallback onTap;
  final String serviceName;
  final Icon serviceIcone;
  const DottedBorderButton({
    super.key,
    required this.onTap,
    required this.serviceName,
    required this.serviceIcone,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap;
      },
      child: SizedBox(
        height: 104,
        width: 193,
        child: DottedBorder(
          color: Colors.greenAccent,
          radius: Radius.circular(10),
          borderType: BorderType.RRect,
          dashPattern: const [
            5,
            2
          ], //list alternates between the length of the dash and the length of the gap.
          strokeWidth: 0.5,
          strokeCap: StrokeCap.round,
          padding: EdgeInsets.all(20),
          //borderPadding: EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(serviceName),
              SizedBox(height: 10),
              Icon(
                serviceIcone.icon,
              )
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