import 'package:flutter/material.dart';
import 'image.dart';

class CustomContainer extends StatefulWidget {
  final String headerText;
  final IconData headerIcon;
  final Widget child;
  final List<Widget>? headreActions;

  const CustomContainer({
    super.key,
    required this.headerText,
    required this.child,
    required this.headerIcon,
    this.headreActions,
  });

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
            height: 50,
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
                    //"assets/back.png"
                    child: CustomImage(
                      imagePath: "assets/back.png",
                      width: double.infinity,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        widget.headerIcon,
                        color: Colors.white,
                      ),
                      Text(
                        widget.headerText,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Spacer(),
                      if (widget.headreActions != null)
                        ...widget.headreActions!,
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
