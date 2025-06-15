import 'package:flutter/material.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({Key? key}) : super(key: key);

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
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Divider(color: Colors.green, thickness: 2, indent: 80, endIndent: 80),
          SizedBox(height: 10),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: MediaQuery.of(context).size.width > 1000 ? 3 : 1, 
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5,
            children: [
              FeatureItem(Icons.group, 'إدارة شؤون الحلقات', 'تشمل كلّ ما يتعلّق بالحلقات من انشاء الحلقات و إضافة وإسناد الطّلاب والمعلّمين وغيرها من العمليّات التنظيمية.'),
              FeatureItem(Icons.person, 'إدارة الطّلاب والمعلّمين', 'تشمل كلّ ما يتعلق بالطالب والمعلّم، بداية من التسجيل في المدرسة.. مروراً بكافّة العمليات التّعليمية والإدارية.'),
              FeatureItem(Icons.videocam, 'المقرأة الإلكترونية', 'يستطيع المعلّم بواسطة نظام أهل القرآن الاجتماع مع طلّابه من خلال المقرأة الإلكترونية على شكل حلقات افتراضية تختصر الجهد والوقت والمسافات.'),
              FeatureItem(Icons.article, 'التقارير', 'تقارير كتابية وبيانية شاملة، حول الحلقات والحفظ والمراجعة والحضور والغياب، يستفيد منها المشرف والمعلّم وكذا الطالب ووليّ الأمر.'),
              FeatureItem(Icons.mic, 'متابعة الحفظ والمراجعة', 'وذلك بمتابعة الطّالب بشكل تفصيليّ، مع إمكانية تحديد أخطائه على المصحف ليستفيد منها في رحلة حفظه.'),
              FeatureItem(Icons.wifi, 'إدارة الأخبار والإعلانات', 'يتميّز النظام بمنصّة لإدارة الأخبار المتعلّقة بالمدرسة، ليكون الطّالب ووليّ أمره على اطّلاع مستمر بكافّة أحداث وفعاليات المدرسة القرآنية.'),
            ],
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
  bool _isHovered = false; // Pour gérer l'animation

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
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: Icon(
                widget.icon,
                key: ValueKey<bool>(_isHovered),
                size: 50,
                color: _isHovered ? Colors.orange :  Color(0xFF0E9D6D), // Vert par défaut, Marron en hover
              ),
            ),
            SizedBox(height: 10),
            Text(widget.title, textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(widget.description, textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
