import 'package:budget/main/infoPage.dart';
import 'package:budget/main/pageMinus.dart';
import 'package:budget/main/pagePlus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'analyze/analyze.dart';
import 'main/body.dart';

// class AppRouter {
//   final GoRouter router = GoRouter(
//     routes: [
//       GoRoute(
//           path: '/',
//           name: 'home',
//           builder: (context, state) => body(),
//           routes: [
//             GoRoute(
//                 path: 'infoPage',
//                 name: 'infoPage',
//                 builder: (context, state) => const infoPage()),
//             GoRoute(
//                 path: 'pagePlus',
//                 name: 'pagePlus',
//                 builder: (context, state) => const pagePlus()),
//             GoRoute(
//                 path: 'pageMinus',
//                 name: 'pageMinus',
//                 builder: (context, state) => const pageMinus()),
//           ]),
//     ],
//   );
// }

Route getRoutes(RouteSettings settings) {
  late Widget pageToDisplay;

  switch (settings.name) {
    case "/":
      pageToDisplay = body();
      break;
    case "/infoPage":
      {
        pageToDisplay = infoPage(id: (settings.arguments as Map)["id"]);
      }
      break;
    case "/pagePlus":
      {
        pageToDisplay = const pagePlus();
      }
      break;
    case "/pageMinus":
      {
        pageToDisplay = const pageMinus();
      }
      break;
      case "/analyzePage":{
        pageToDisplay = const analyzePage();
      }break;
  }

  return MaterialPageRoute(builder: (BuildContext context) {
    return pageToDisplay;
  });
}


Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const pageMinus(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}