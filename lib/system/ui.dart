import 'package:flutter/material.dart';
import './widgets/timer.dart';
import './widgets/containers.dart';
import './widgets/matrix/custom_matrix.dart';
import './widgets/input_field.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class SystemUI extends StatefulWidget {
  const SystemUI({
    super.key,
  });

  @override
  State<SystemUI> createState() => _SystemUIState();
}

class _SystemUIState extends State<SystemUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                //Scaffold.of(context)
                _scaffoldKey.currentState?.openEndDrawer();
              });
            },
          ),
        ],
      ),
      endDrawer: Drawer(
          //top level widget
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF0E9D6D)),
            child: Text(
              "hello",
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
          ListTile(
            title: Text(
              "لوجه القيادة",
              style: TextStyle(color: Color(0xFF0E9D6D)),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text("الرسائل"),
            onTap: () {},
          ),
          ListTile(
            title: Text(" الوعودات"),
            onTap: () {},
          ),
          ListTile(
            title: Text("الشؤون الإدارية"),
            onTap: () {},
          ),
          ListTile(
            title: Text("الطلاب"),
            onTap: () {},
          ),
          ListTile(
            title: Text("الأساتذة"),
            onTap: () {},
          ),
          ListTile(
            title: Text(" الحصص"),
            onTap: () {},
          ),
        ],
      )),
      //diallog with scrollable indecator
      body: Center(
        child: OutlinedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    ScrollController controller = ScrollController();
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                        maxHeight: MediaQuery.of(context).size.height * 0.8,
                      ),
                      child: Dialog(
                          shape: BeveledRectangleBorder(),
                          backgroundColor: Colors.white,
                          //the dialog should have a child for it to show
                          child: Scrollbar(
                              /*
                            if not attached to the scrollable widget, will cause The Scrollbar's ScrollController has no ScrollPosition attached error.
                            To fix this, you need to create a ScrollController and attach it to both the Scrollbar
                            */
                              controller: controller,
                              child: Column(
                                children: [
                                  Stack(children: [
                                    ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                          Colors.white, BlendMode.dstIn),
                                      child: Container(
                                        width: double.infinity,
                                        height: 50,
                                        color: Color(0xFF0E9D6D),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: ClipRRect(
                                        //borderRadius: BorderRadius.circular(5),
                                        child: Image.asset(
                                          "assets/back.png",
                                          fit: BoxFit
                                              .cover, //prevent immage duplication in small containers
                                          //other options: cover, contain
                                        ),
                                      ),
                                    ),
                                  ]),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      controller: controller,
                                      //EdgeOverflow =>padding
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          containers("hello", [inputFeild()]),
                                          SizedBox(height: 10),
                                          containers("hello", [inputFeild()]),
                                          // Expanded(child: containers(inputFeild())),
                                          SizedBox(height: 10),
                                          containers("hello", [inputFeild()]),
                                          SizedBox(height: 10),
                                          containers("hello", [inputFeild()]),
                                          SizedBox(height: 10),
                                          //DropdownButton
                                          DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder()),
                                            value: '1',
                                            items: ['1', '2', '3', '4', '5']
                                                .map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (String? value) {},
                                          ),
                                          SizedBox(height: 10),
                                          ElevatedButton(
                                              onPressed: () {
                                                timer(context);
                                              },
                                              child: Text("select time")),
                                          SizedBox(height: 10),
                                          CustomMatrix()
                                        ],
                                      ),
                                    ),
                                  ),
                                  OutlinedButton(
                                      onPressed: () {}, child: Text("send")),
                                ],
                              ))),
                    );
                  });
            },
            child: Text("open dialog")),
      ),
    );
  }
}

/*Expanded vs Flexibale 
Flexibal = take the space u need
Expanded = take all the remaining space
both are used when Multiple widgets should share available space
*/

/*
add padding to a widget:
*wrap with padding widget
*/
/*
add both margin and padding to a widget:
wrap with container
*/
