import 'package:flutter/material.dart';

class CustomContainer extends StatefulWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final Widget? addButton;
  final Widget? deleteButton;

  const CustomContainer(
      {super.key,
      required this.title,
      required this.child,
      required this.icon,
      this.addButton,
      this.deleteButton});

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xff169b88), width: 0.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //1
          SizedBox(
            height: 40,
            child: Stack(
                //textDirection: TextDirection.rtl,
                children: [
                  ColorFiltered(
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.dstIn),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      color: Color(0xFF0E9D6D),
                    ),
                  ),
                  ClipRRect(
                    //borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      width: double.infinity,
                      "assets/back.png",
                      fit: BoxFit
                          .cover, //prevent immage duplication in small containers
                      //other options: cover, contain
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        widget.icon,
                        color: Colors.white,
                      ),
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Spacer(),
                      if (widget.addButton != null) widget.addButton!,
                    ],
                  )
                ]),
          ),
          //2
          /// Only use Expanded for parts that need to fill space
          /// Expanded must have a single child
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: widget.child,
          )
        ],
      ),
    );
  }
}
