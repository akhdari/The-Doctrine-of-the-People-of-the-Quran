import 'dart:async';
import 'package:flutter/material.dart';

class PartnersSection extends StatefulWidget {
  @override
  _PartnersSection createState() => _PartnersSection();
}

class _PartnersSection extends State<PartnersSection> {
  final List<Map<String, String>> images = [
    {"image": "assets/partners/dz.jpg", "name": "الجزائر"},
    {"image": "assets/partners/maliz.jpg", "name": "ماليزيا"},
    {"image": "assets/partners/saud.jpg", "name": "السعودية"},
    {"image": "assets/partners/turq.jpg", "name": "تركيا"},
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
          int targetPage = (currentIndex / itemsPerPage).floor();
          if (targetPage < (images.length / itemsPerPage).ceil()) {
            _pageController.animateToPage(
              targetPage,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    itemsPerPage = screenWidth < 600 ? 1 : 4; // 1 carte sur mobile, 4 sur grand écran

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text(
            'شركاء النجاح',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          SizedBox(
            height: 300,
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
                    return _buildCard(context, data['image']!, data['name']!);
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String imagePath, String name) {
    return GestureDetector(
      onTap: () => _showFullScreenImage(context, imagePath),
      child: Column(
        children: [
          Container(
            width: 250, // Augmentation de la largeur de la carte
            height: 210, // Ajustement pour une meilleure proportion
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: 250, // Largeur égale à la carte
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
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
              name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
