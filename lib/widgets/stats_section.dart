import 'package:flutter/material.dart';

class StatsSection extends StatelessWidget {
  final List<Map<String, dynamic>> stats = [
    {"icon": Icons.school, "label": "عدد المدارس", "value": "+200"},
    {"icon": Icons.group, "label": "عدد الطلاب", "value": "+20000"},
    {"icon": Icons.person, "label": "عدد المعلمين", "value": "+1000"},
    {"icon": Icons.tv, "label": "عدد الحلقات", "value": "+1200"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      color: Color(0xFF0E9D6D),
      child: Column(
        children: [
          Text(
            "أرقام حول النظام",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: stats.map((stat) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: StatCard(stat: stat, width: 250),
                  )).toList(),
                );
              } else {
                return Column(
                  children: stats.map((stat) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: StatCard(stat: stat, width: 250),
                  )).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatefulWidget {
  final Map<String, dynamic> stat;
  final double width;

  const StatCard({required this.stat, this.width = 200});

  @override
  _StatCardState createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        transform: isHovered 
            ? (Matrix4.identity()..translate(0, -5))  // Monte de 5 pixels vers le haut
            : Matrix4.identity(),
        width: widget.width,
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: isHovered ? 12 : 8)],
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: isHovered ? Colors.orange : Colors.white,
              child: Icon(widget.stat["icon"], size: 36, color: isHovered ? Colors.white : Colors.orange),
            ),
            SizedBox(height: 12),
            Text(widget.stat["label"], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text(widget.stat["value"], style: TextStyle(fontSize: 22, color: Colors.teal, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
