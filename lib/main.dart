// ignore_for_file: camel_case_types, prefer_const_constructors, duplicate_ignore, unnecessary_string_interpolations

import 'package:budget/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: "/",
        onGenerateRoute: getRoutes,
        // routes: {
        //   '/': (context) => body(),
        //   '/pageMinus': (context) => pageMinus(),
        //   '/pagePlus': (context) => pagePlus(),
          
        // },
        debugShowCheckedModeBanner: false,
        // home: body(),
        // routerConfig: AppRouter().router,
        // routeInformationParser: AppRouter().router.routeInformationParser,
        // routerDelegate: AppRouter().router.routerDelegate,
    );
  }
}
