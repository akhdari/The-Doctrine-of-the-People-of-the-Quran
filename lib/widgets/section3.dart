import 'package:flutter/material.dart';

class Section3 extends StatelessWidget {
  const Section3({Key? key}) : super(key: key);

  Widget _buildFeatureItem(IconData icon, String title, String description) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4, spreadRadius: 1)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.teal),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black), textAlign: TextAlign.center),
          SizedBox(height: 5),
          Text(description, style: TextStyle(fontSize: 12, color: Colors.grey[700]), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'خصائص النظام',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Divider(color: Colors.green, thickness: 2, indent: 80, endIndent: 80),
          SizedBox(height: 10),

          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth > 1000
                  ? 3
                  : constraints.maxWidth > 600
                      ? 2
                      : 1;

              return GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.5,
                children: [
                  _buildFeatureItem(Icons.security, 'الأمن والحماية', 'تم تطوير النظام بأفضل الممارسات التقنية.'),
                  _buildFeatureItem(Icons.handshake, 'سهولة الاستخدام', 'لا يتطلب استخدام النظام أي مهارات خاصة.'),
                  _buildFeatureItem(Icons.smartphone, 'توافق مع الأجهزة', 'يعمل النظام على جميع الأنظمة والشاشات.'),
                  _buildFeatureItem(Icons.refresh, 'تحديث مستمر', 'تحديثات وتطويرات مستمرة على النظام.'),
                  _buildFeatureItem(Icons.cloud, 'نسخ احتياطي', 'نسخ احتياطي بشكل يومي لجميع البيانات.'),
                  _buildFeatureItem(Icons.notifications, 'نظام التنبيهات', 'نظام أوتوماتيكي للإشعارات الفورية.'),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
