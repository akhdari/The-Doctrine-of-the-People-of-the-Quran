import 'package:flutter/material.dart';

import '../widgets/user_card.dart'; // Assure-toi que ce fichier existe et est bien structuré

class UsersSection extends StatelessWidget {
  const UsersSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              HoverUserCard(imagePath: "assets/images1/parent.png", title: "ولي الأمر"),
              HoverUserCard(imagePath: "assets/images1/student.png", title: "الطالب"),
              HoverUserCard(imagePath: "assets/images1/teacher.png", title: "المعلم"),
              HoverUserCard(imagePath: "assets/images1/admin.png", title: "المشرف"),
            ],
          ),
        ],
      ),
    );
  }
}

class HoverUserCard extends StatefulWidget {
  final String imagePath;
  final String title;

  const HoverUserCard({Key? key, required this.imagePath, required this.title}) : super(key: key);

  @override
  _HoverUserCardState createState() => _HoverUserCardState();
}

class _HoverUserCardState extends State<HoverUserCard> {
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
          borderRadius: BorderRadius.circular(10),
          boxShadow: _isHovered
              ? [BoxShadow(color: Colors.black26, blurRadius: 8, spreadRadius: 2, offset: Offset(0, 4))]
              : [],
        ),
        child: UserCard(imagePath: widget.imagePath, title: widget.title),
      ),
    );
  }
}
