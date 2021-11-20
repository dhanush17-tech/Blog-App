import 'package:blog_app/app/router/route_constants.dart';
import 'package:blog_app/meta/views/blog._page.dart';
import 'package:blog_app/meta/views/homescreen.dart';
import 'package:blog_app/meta/views/signup.dart';
import 'package:blog_app/meta/views/undefined.dart';

import 'package:flutter/material.dart';

class RoutePage {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstant.ROOT:
        return PageRouteBuilder<dynamic>(
            settings: settings,
            pageBuilder: (_, __, ___) => HomeScreen(),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      // case RouteConstant.ADD_POST:
      //   return PageRouteBuilder<dynamic>(
      //       settings: settings,
      //       pageBuilder: (_, __, ___) => AddPost(),
      //       transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
      //           FadeTransition(opacity: a, child: c));

      // case RouteConstant.PROFILE:
      //   return PageRouteBuilder<dynamic>(
      //       settings: settings,
      //       pageBuilder: (_, __, ___) => Profile(),
      //       transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
      //           FadeTransition(opacity: a, child: c));

      case RouteConstant.VIEW_POST:
        return PageRouteBuilder<dynamic>(
            settings: settings,
            pageBuilder: (_, __, ___) => BlogPage("dwdwdw"),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));
      case RouteConstant.SIGNUP:
        return PageRouteBuilder<dynamic>(
            settings: settings,
            pageBuilder: (_, __, ___) => Signup(),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));
      default:
        return PageRouteBuilder<dynamic>(
            settings: settings,
            pageBuilder: (_, __, ___) => UndefinedView(
                  routeName: settings.name!,
                ),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));
    }
  }
}
