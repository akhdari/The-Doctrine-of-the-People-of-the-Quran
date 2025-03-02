import 'package:flutter/material.dart';

class Section3 extends StatelessWidget {
  const Section3({Key? key}) : super(key: key);

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
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black),
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
                  FeatureItem(Icons.security, 'الأمن والحماية', 'تمّ تطوير النّظام باتّباع أفضل الممارسات التقنية وهذا لتوفير أفضل حماية ممكنة لبيانات مُستخدمينا وخصوصياتهم.'),
                  FeatureItem(Icons.handshake, 'سهولة الاستخدام', 'لا يتطلّب استخدام النظام أي مهارات خاصة أو معلومات قبلية حول البرمجة وغيرها.'),
                  FeatureItem(Icons.smartphone, 'توافق مع الأجهزة', 'يعمل النظام على جميع الأنظمة والمتصفّحات وشاشات اللمس، بالإضافة إلى تطبيق خاص بهواتف الأندرويد وآخر للأيفون'),
                  FeatureItem(Icons.refresh, 'تحديث مستمر', 'تحديثات وتطويرات مستمرة على نظام أهل القرآن يستفيد منها المستخدمون بشكل دوريّ'),
                  FeatureItem(Icons.cloud, 'نسخ احتياطي', 'نسخ احتياطي بشكل يوميّ لجميع البيانات المُدخلة.'),
                  FeatureItem(Icons.notifications, 'نظام التنبيهات', 'نظام أوتوماتيكي للتنبيهات والإشعارات الآنية على الهواتف.'),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class FeatureItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureItem(this.icon, this.title, this.description, {Key? key}) : super(key: key);

  @override
  _FeatureItemState createState() => _FeatureItemState();
}

class _FeatureItemState extends State<FeatureItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        transform: _isHovered ? Matrix4.translationValues(0, -5, 0) : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centre verticalement
          crossAxisAlignment: CrossAxisAlignment.center, // Centre horizontalement
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: Icon(
                widget.icon,
                key: ValueKey<bool>(_isHovered),
                size: 40,
                color: _isHovered ? Colors.orange :  Color(0xFF0E9D6D),
              ),
            ),
            SizedBox(height: 15),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              widget.description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
