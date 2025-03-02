import 'package:flutter/material.dart';
import 'package:quran_projet/widgets/user_card.dart';

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
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
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
            crossAxisCount: MediaQuery.of(context).size.width > 800 ? 4 : 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: [
              UserCard(imagePath: "assets/images/parent.png", title: "ولي الأمر"),
              UserCard(imagePath: "assets/images/student.png", title: "الطالب"),
              UserCard(imagePath: "assets/images/teacher.png", title: "المعلم"),
              UserCard(imagePath: "assets/images/admin.png", title: "المشرف"),
            ],
          ),
        ],
      ),
    );
  }
}
