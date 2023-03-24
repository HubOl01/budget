import 'package:flutter/material.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Colors.green[800],
              ),
              child: Text("Мой бюджет"),
            ),
            ListTile(
              leading: Icon(Icons.money),
              title: Text("Главная"),
              onTap: () {
                // Navigator.pop(context);
                Navigator.popAndPushNamed(context, '/');
              },
            ),
            ListTile(
              leading: Icon(Icons.analytics_outlined),
              title: Text("Анализ"),
              onTap: () {
                Navigator.pushNamed(context, "/analyzePage");
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Настройки"),
              onTap: () {
                Navigator.pushNamed(context, "/pagePlus");
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("О программе"),
              onTap: () {},
            ),
          ]),
    );
  }
}