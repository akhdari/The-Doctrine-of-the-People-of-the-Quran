import 'package:flutter/material.dart';

class ZoomCard extends StatefulWidget {
  final String title;
  final String price;
  final String description;
  final IconData icon;

  ZoomCard({required this.title, required this.price, required this.description, required this.icon});

  @override
  _ZoomCardState createState() => _ZoomCardState();
}

class _ZoomCardState extends State<ZoomCard> {
  double _scale = 1.0; // Facteur de zoom initial

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _scale = 1.05), // Zoom léger
      onExit: (_) => setState(() => _scale = 1.0),
      child: SizedBox( // Définir la taille de la carte
        width: 100, // Largeur réduite
        height: 160, // Hauteur ajustée
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(_scale),
          decoration: BoxDecoration(
            color: Color(0xFF0E9D6D),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, size: 40, color: Colors.white), // Réduit la taille de l'icône
              SizedBox(height: 10),
              Text(widget.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 5),
              Text("DA ${widget.price}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 5),
              Text(widget.description, style: TextStyle(fontSize: 12, color: Colors.white), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
