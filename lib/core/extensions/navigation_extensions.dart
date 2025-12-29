import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

extension NavigationExtension on BuildContext {
  Future navigateToPage(
    Widget widget, {
    PageTransitionType pageTransitionType = PageTransitionType.fade,
  }) async {
    return Navigator.of(this).push(
      PageTransition(
        child: widget,
        type: pageTransitionType,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  void navigateToPageWithReplacement(
    Widget page, {
    PageTransitionType pageTransitionType = PageTransitionType.fade,
  }) {
    Navigator.of(this).pushReplacement(
      PageTransition(
        child: page,
        type: pageTransitionType,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  void navigateToPageWithClearStack(
    Widget page, {
    PageTransitionType pageTransitionType = PageTransitionType.fade,
  }) {
    Navigator.of(this).pushAndRemoveUntil(
      PageTransition(
        child: page,
        type: pageTransitionType,
        duration: const Duration(milliseconds: 500),
      ),
      (route) => false,
    );
  }
}
