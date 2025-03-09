import 'package:flutter/material.dart';

class NutifForm extends StatefulWidget {
  @override
  _NutifFormState createState() => _NutifFormState();
}

class _NutifFormState extends State<NutifForm> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isHovered = false; // État pour détecter le survol du bouton

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Color(0xFF0E9D6D),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'اشترك في قائمتنا البريدية',
            style: TextStyle(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'لمتابعة جديد التحديثات والحصول على الأخبار، اشترك الآن!',
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          SizedBox(height: 40),
          Form(
            key: formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MouseRegion(
                  onEnter: (_) => setState(() => isHovered = true),
                  onExit: (_) => setState(() => isHovered = false),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isHovered ? Colors.teal : Colors.orange,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                'تم تسجيل بريدك في قائمتنا',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 26, // Texte agrandi
                                  fontWeight: FontWeight.bold, // Texte en gras
                                ),
                              ),
                              content: Text(
                                'من الآن وصاعدًا ستصلك أخبار وتحديثات النظام',
                                textAlign: TextAlign.center, // Centrer le texte
                              ),
                              actions: [
                                Align(
                                  alignment: Alignment.center, // Centrer le bouton
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF0E9D6D), // Fond vert
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 8),
                                        child: Text(
                                          'OK',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: Text(
                        'اشتراك',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'الرجاء إدخال البريد الإلكتروني',
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 18, horizontal: 12), // Augmente la hauteur
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'يجب إدخال بريد إلكتروني صحيح';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
