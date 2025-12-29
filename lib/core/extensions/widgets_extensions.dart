import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension EmptySizedBox on num {
  SizedBox get sizedHeight => SizedBox(height: toDouble().h);

  SizedBox get sizedWidth => SizedBox(width: toDouble().w);
}

// replaceWhere
extension ListExtension<T> on List<T> {
  void replaceWhere(bool Function(T) test, T item) {
    final index = indexWhere(test);
    if (index != -1) {
      this[index] = item;
    }
  }
}

// add animation to list of widgets and add delay between each widget
extension ListOfWidgetsExtension on List<Widget> {
  List<Widget> fadeInUpList() {
    final List<Widget> animatedWidgets = [];
    for (final widget in this) {
      // ignore size box widgets
      if (widget is SizedBox) {
        animatedWidgets.add(widget);
      } else {
        animatedWidgets.add(
          FadeInUp(
            duration: Duration(
              milliseconds:
                  500 * (indexOf(widget) + 1 > 5 ? 5 : indexOf(widget) + 1),
            ),
            child: widget,
          ),
        );
      }
    }
    return animatedWidgets;
  }
}

extension WidetsX on Widget {
  Widget addAction({
    Function? onTap,
    Key? mKey,
    Function? onLongPress,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    Alignment? alignment,
    double borderRadius = 0,
  }) {
    final child = Container(
      color: Colors.transparent,
      alignment: alignment,
      padding: padding,
      child: this,
    );
    if (onTap != null || onLongPress != null) {
      return InkWell(
        key: mKey,
        borderRadius: BorderRadius.circular(borderRadius.r),
        onTap: () => onTap?.call(),
        onLongPress: () => onLongPress?.call(),
        child: child,
      );
    }
    return this;
  }
}
