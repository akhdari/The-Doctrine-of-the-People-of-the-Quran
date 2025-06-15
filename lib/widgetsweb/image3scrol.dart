import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarousel3 extends StatelessWidget {
  final List<String> imagePaths = List.generate(13, (index) => 'assets/image${index + 1}.png');

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Fond blanc pour toute la section
      padding: EdgeInsets.symmetric(vertical: 20), // Ajoute de l'espace autour
      child: Column(
        children: [
          Text(
            "هيئات تستعمل النظام",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          CarouselSlider(
            options: CarouselOptions(
              height: 200, // Ajuste selon tes besoins
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              viewportFraction: 0.2, // 5 images visibles à la fois (1/5 = 0.2)
              enableInfiniteScroll: true,
              enlargeCenterPage: false,
            ),
            items: imagePaths.map((path) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white, // Fond blanc pour chaque image
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(path, fit: BoxFit.cover),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
