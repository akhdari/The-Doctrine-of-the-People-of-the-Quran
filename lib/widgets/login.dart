import 'package:flutter/material.dart';

class ResponsiveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool showRightSide = constraints.maxWidth > 600;

          return Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.blue,
                  child: const Center(
                    child: MyWidget(),
                  ),
                ),
              ),
              if (showRightSide)
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        "Right Side",
                        style: TextStyle(color: Colors.lightBlue, fontSize: 20),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
             BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Center(
              child: Text(
                "تسجيل الدخول",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),
            const Text("اسم المستخدم"),
            Input(hintText: "ادخل اسم المستخدم",icon: const Icon(Icons.email_outlined),),
            const SizedBox(height: 16),
             const Text("كلمة المرور"),
             Input(hintText: "ادخل كلمة المرور", ispassword: true,icon: const Icon(Icons.password)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4A05E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
              ),
              child: const Text("تسجيل الدخول", style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class Input extends StatelessWidget {
  late bool ispassword;
  final String hintText;
  final Icon icon;
Input ({super.key, required this.hintText, this.ispassword=false, required this.icon});

  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: TextField(
        obscureText: ispassword,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          prefixIcon: Container(
            width: 50, // Set a fixed width for better styling
            height: 50, // Matches TextField height
            decoration: const BoxDecoration(
              color: Colors.blue, // Background color for icon
              borderRadius: BorderRadius.zero,
          
            ),
            child: icon,
          ),
          border: const OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide( width: 1)),
          focusedBorder: const OutlineInputBorder(borderRadius:BorderRadius.zero, borderSide: BorderSide(width: 1)),
          contentPadding: const EdgeInsets.symmetric(horizontal:12, vertical: 6),
          hintText: hintText,
        ),
      ),
    );
  }
}
