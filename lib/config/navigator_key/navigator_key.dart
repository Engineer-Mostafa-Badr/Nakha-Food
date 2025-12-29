import 'package:flutter/material.dart';

class NavigatorKey {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context =>
      navigatorKey.currentState!.overlay!.context;

  static NavigatorState get navigator => navigatorKey.currentState!;
}
