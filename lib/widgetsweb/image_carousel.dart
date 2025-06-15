import 'dart:async';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final List<Map<String, String>> images = [
    {'image': 'assets/images/img1.png', 'title': 'تقرير الحلقة'},
    {'image': 'assets/images/img2.png', 'title': 'إحصاء المواظبة'},
    {'image': 'assets/images/img3.png', 'title': 'تقويم الأداء'},
    {'image': 'assets/images/img4.png', 'title': 'المهام اليومية'},
    {'image': 'assets/images/img5.png', 'title': 'جدول الحصص'},
    {'image': 'assets/images/img6.png', 'title': 'الأنشطة الطلابية'},
    {'image': 'assets/images/img7.png', 'title': 'التقارير الإدارية'},
    {'image': 'assets/images/img8.png', 'title': 'المواد الدراسية'},
    {'image': 'assets/images/img9.png', 'title': 'الخطة الدراسية'},
    {'image': 'assets/images/img10.png', 'title': 'متابعة المعلمين'},
    {'image': 'assets/images/img11.png', 'title': 'نتائج الطلاب'},
    {'image': 'assets/images/img12.png', 'title': 'أرشيف المستندات'},
    {'image': 'assets/images/img13.png', 'title': 'إدارة المكتبة'},
    {'image': 'assets/images/img14.png', 'title': 'الاختبارات الإلكترونية'},
    {'image': 'assets/images/img15.png', 'title': 'الإعلانات المدرسية'},
    {'image': 'assets/images/img16.png', 'title': 'اللقاءات التربوية'},
    {'image': 'assets/images/img17.png', 'title': 'التسجيل في الأنشطة'},
    {'image': 'assets/images/img18.png', 'title': 'إدارة الفصول'},
    {'image': 'assets/images/img19.png', 'title': 'تحليل البيانات'},
    {'image': 'assets/images/img20.png', 'title': 'سجل الإنجازات'},
    {'image': 'assets/images/img21.png', 'title': 'نظام الدردشة'},
    {'image': 'assets/images/img22.png', 'title': 'التغذية المدرسية'},
    {'image': 'assets/images/img23.png', 'title': 'أخبار المدرسة'},
    {'image': 'assets/images/img24.png', 'title': 'التقييم الذاتي'},
    {'image': 'assets/images/img25.png', 'title': 'التواصل مع الإدارة'},
    {'image': 'assets/images/img26.png', 'title': 'إدارة الحضور'},
    {'image': 'assets/images/img27.png', 'title': 'تقارير الأداء'},
    {'image': 'assets/images/img28.png', 'title': 'الملف الشخصي'},
  ];

  final PageController _pageController = PageController();
  int currentIndex = 0;
  int itemsPerPage = 4; // Par défaut, 4 cartes par page

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          currentIndex = (currentIndex + itemsPerPage) % images.length;
          _pageController.animateToPage(
            currentIndex ~/ itemsPerPage,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    itemsPerPage = screenWidth < 600 ? 2 : 4; // 2 cartes sur mobile, 4 sur grand écran

    return Column(
      children: [
        Text(
          'صور من المنصة',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40),
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _pageController,
            itemCount: (images.length / itemsPerPage).ceil(),
            itemBuilder: (context, pageIndex) {
              int startIndex = pageIndex * itemsPerPage;
              int endIndex = (startIndex + itemsPerPage).clamp(0, images.length);
              List<Map<String, String>> displayedImages =
                  images.sublist(startIndex, endIndex);

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: displayedImages.map((data) {
                  return _buildCard(context, data['image']!, data['title']!);
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }

 Widget _buildCard(BuildContext context, String imagePath, String title) {
  return GestureDetector(
    onTap: () => _showFullScreenImage(context, imagePath),
    child: Column(
      children: [
        Container(
          width: 150,
          height: 180, // Ajusté pour laisser de la place au titre
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity),
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: 150,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 3,
                offset: Offset(1, 1),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}


  void _showFullScreenImage(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: InteractiveViewer(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
