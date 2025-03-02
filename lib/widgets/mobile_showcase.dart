import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MobileShowcase extends StatelessWidget {
  final List<String> imagePaths = List.generate(21, (index) => 'assets/images/img${index + 1}.png');

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Fond blanc
      padding: EdgeInsets.symmetric(vertical: 30), // Espacement vertical
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "صور من التطبيق",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20), // Espacement entre le titre et l'image
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/phone.png', // Image du téléphone (carcasse)
                  width: 680, // Ajuster la taille du téléphone
                ),
                Positioned(
                  top: 27, // Ajustement pour bien placer les images
                  child: SizedBox(
                    width: 400, // Largeur de la zone écran
                    height: 290, // Hauteur de la zone écran
                    child: CarouselSlider.builder(
                      itemCount: imagePaths.length,
                      options: CarouselOptions(
                        height: 290, // Hauteur des images
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        viewportFraction: 0.32, // Ajuster pour bien afficher 3 images
                        enableInfiniteScroll: true,
                        enlargeCenterPage: false, // Désactiver l'effet d'agrandissement
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.easeInOut,
                        scrollPhysics: BouncingScrollPhysics(),
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8), // Espace entre les images
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15), // Coins arrondis
                            child: Image.asset(
                              imagePaths[index],
                              width: 120, // Taille fixe pour toutes les images
                              height: 290, // Même hauteur
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
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
