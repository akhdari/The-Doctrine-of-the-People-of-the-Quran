import 'package:flutter/material.dart';
import 'package:quran_projet/nav.dart';
import 'package:quran_projet/widgets/mobile_showcase.dart';
import 'package:quran_projet/widgets/user_card.dart';
import 'package:quran_projet/widgets/image_carousel.dart';



class Page1 extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF0E9D6D)),
              child: Text(
                'القائمة',
                style: TextStyle(
                    color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            _drawerItem('الرئيسية'),
            _drawerItem('الأسعار'),
            _drawerItem('المزايا'),
            _drawerItem('الدعم الفني'),
            _drawerItem('التسويق بالعمولة'),
            _drawerItem('تسجيل الدخول'),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(color: Color(0xFF0E9D6D)),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/back.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.2), BlendMode.dstIn),
              ),
            ),
          ),
          Column(
            children: [
              // Barre de navigation fixe
              Container(
                color: Color(0xFF0E9D6D),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: NavBar(scaffoldKey: _scaffoldKey),
              ),
              // Contenu avec espace pour éviter le chevauchement
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 120), // Ajuste l'espacement
                      LayoutBuilder(
                        builder: (context, constraints) {
                          bool isLargeScreen = constraints.maxWidth > 800;
                          return isLargeScreen
                              ? _largeScreenContent()
                              : _smallScreenContent();
                        },
                      ),
                      SizedBox(height: 80),
                      _featuresSection(context),
                      SizedBox(height: 50),
                      _usersSection(context),
                      SizedBox(height: 50),
                      _Section3(context),
                      SizedBox(height: 50),
                      _carouselSection(),
                      SizedBox(height: 50),
                      _mobileShowcaseSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

  Widget _largeScreenContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Image.asset('assets/homme.png', fit: BoxFit.contain, height: 350),
        ),
        SizedBox(width: 20),
        Expanded(child: _textContent()),
      ],
    );
  }

  Widget _smallScreenContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _textContent(),
        SizedBox(height: 40),
        Image.asset('assets/homme.png', fit: BoxFit.contain, height: 250),
      ],
    );
  }

  Widget _textContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('نظام أهل القرآن', style: TextStyle(fontSize: 52, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        Text('تسيير وتيسير التعليم القرآني', style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        SizedBox(height: 20),
        Text('.نظام أهل القرآن هو نظام سحابي متكامل .. يمكن بواسطته إنشاء بيئة رقمية', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
         Text(' تربط بين مشرفي الحلقات ومدرسيها وطلابها وأولياء الأمور ، وذلك بمنحهم الأدوات الحديثة للارتقاء بحلقات القرآن', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        SizedBox(height: 25),
        ElevatedButton(
          onPressed: () {},
          child: Text('طلب نسخة', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
  
  Widget _featuresSection(BuildContext context) {
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
            crossAxisCount: MediaQuery.of(context).size.width > 1000 ? 3 : 1, // 3 colonnes sur grand écran, 2 sur mobile
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5, // Ajuste la hauteur des cartes
            children: [
              _buildFeatureItem(Icons.group, 'إدارة شؤون الحلقات', 'تشمل كلّ ما يتعلّق بالحلقات من انشاء الحلقات و إضافة وإسناد الطّلاب والمعلّمين وغيرها من العمليّات التنظيمية.'),
              _buildFeatureItem(Icons.person, 'إدارة الطّلاب والمعلّمين,', 'تشمل كلّ ما يتعلق بالطالب والمعلّم، بداية من التسجيل في المدرسة.. مروراً بكافّة العمليات التّعليمية والإدارية.'),
              _buildFeatureItem(Icons.videocam, 'المقرأة الإلكترونية', 'يستطيع المعلّم بواسطة نظام أهل القرآن الاجتماع مع طلّابه من خلال المقرأة الإلكترونية على شكل حلقات افتراضية تختصر الجهد والوقت والمسافات.'),
              _buildFeatureItem(Icons.article, 'التقارير', 'تقارير كتابية وبيانية شاملة، حول الحلقات والحفظ والمراجعة والحضور والغياب، يستفيد منها المشرف والمعلّم وكذا الطالب ووليّ الأمر.'),
              _buildFeatureItem(Icons.mic,'متابعة الحفظ والمراجعةظ', 'وذلك بمتابعة الطّالب بشكل تفصيليّ، مع إمكانية تحديد أخطائه على المصحف ليستفيد منها في رحلة حفظه'),
              _buildFeatureItem(Icons.wifi, 'إدارة الأخبار والإعلانات,', 'يتميّز النظام بمنصّة لإدارة الأخبار المتعلّقة بالمدرسة، ليكون الطّالب ووليّ أمره على اطّلاع مستمر بكافّة أحداث وفعاليات المدرسة القرآنية.'),
            ],
          ),
        ],
      ),
    );
  }
   Widget _usersSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        children: [
          Text(
            "مستخدمو النظام",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            "يوفر النظام خدمات ومزايا عديدة لمختلف مستخدميه.",
            style: TextStyle(fontSize: 16, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width > 800 ? 4 : 1,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: [
              UserCard(imagePath: "assets/images1/parent.png", title: "ولي الأمر"),
              UserCard(imagePath: "assets/images1/student.png", title: "الطالب"),
              UserCard(imagePath: "assets/images1/teacher.png", title: "المعلم"),
              UserCard(imagePath: "assets/images1/admin.png", title: "المشرف"),
            ],
          ),
        ],
      ),
    );
  }
   Widget _Section3(BuildContext context) {
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
                  _buildFeatureItem(Icons.security, 'الأمن والحماية', 'تمّ تطوير النّظام باتّباع أفضل الممارسات التقنية وهذا لتوفير أفضل حماية ممكنة لبيانات مُستخدمينا وخصوصياتهم.'),
                  _buildFeatureItem(Icons.handshake, 'سهولة الاستخدام', 'لا يتطلّب استخدام النظام أي مهارات خاصة أو معلومات قبلية حول البرمجة وغيرها.'),
                  _buildFeatureItem(Icons.smartphone, 'توافق مع الأجهزة', 'يعمل النظام على جميع الأنظمة والمتصفّحات وشاشات اللمس، بالإضافة إلى تطبيق خاص بهواتف الأندرويد وآخر للأيفون'),
                  _buildFeatureItem(Icons.refresh, 'تحديث مستمر', 'تحديثات وتطويرات مستمرة على نظام أهل القرآن يستفيد منها المستخدمون بشكل دوريّ'),
                  _buildFeatureItem(Icons.cloud, 'نسخ احتياطي', 'نسخ احتياطي بشكل يوميّ لجميع البيانات المُدخلة.'),
                  _buildFeatureItem(Icons.notifications, 'نظام التنبيهات', 'نظام أوتوماتيكي للتنبيهات والإشعارات الآنية على الهواتف.'),
                ],
          );
            },
          ),
        ],
      ),
    );
  }
  Widget _carouselSection() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: ImageCarousel(),
  );
}
Widget _mobileShowcaseSection() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: MobileShowcase(), // Appelle le widget ici
  );
}



 Widget _buildFeatureItem(IconData icon, String title, String description) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white, // Fond blanc
      borderRadius: BorderRadius.circular(10), // Coins arrondis
    ),
    padding: const EdgeInsets.all(12.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 50, color: Colors.green),
        SizedBox(height: 10),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold, // ✅ Titre en gras
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold, 
            color: const Color.fromARGB(221, 43, 39, 39),
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}


  

  Widget _drawerItem(String title) {
    return ListTile(title: Text(title), onTap: () {});
  }

