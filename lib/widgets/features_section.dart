import 'package:flutter/material.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({Key? key}) : super(key: key);

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
            'مزايا النظام',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Divider(color: Colors.green, thickness: 2, indent: 80, endIndent: 80),
          SizedBox(height: 10),

          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: MediaQuery.of(context).size.width > 1000 ? 3 : 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5,
            children: [
              _buildFeatureItem(Icons.group, 'إدارة الحلقات', 'تنظيم جميع الحلقات بسهولة.'),
              _buildFeatureItem(Icons.person, 'إدارة الطلاب', 'متابعة الطلاب والمعلمين.'),
              _buildFeatureItem(Icons.videocam, 'المقرأة الإلكترونية', 'حلقات افتراضية فعالة.'),
              _buildFeatureItem(Icons.article, 'التقارير', 'إحصائيات ومتابعات دقيقة.'),
              _buildFeatureItem(Icons.mic, 'متابعة الحفظ', 'تسجيل تقدم الطالب في الحفظ.'),
              _buildFeatureItem(Icons.wifi, 'إدارة الأخبار', 'نشر الإعلانات والتحديثات بسهولة.'),
            ],
          ),
        ],
      ),
    );
  }
}
