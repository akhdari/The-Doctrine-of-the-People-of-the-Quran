import 'package:flutter/material.dart';

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
      body: Column(children: const []),
    );
  }
}
