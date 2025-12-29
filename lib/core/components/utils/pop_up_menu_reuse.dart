import 'package:flutter/material.dart';

class PopUpMenuReuse extends StatelessWidget {
  const PopUpMenuReuse({
    super.key,
    required this.child,
    required this.items,
    required this.onSelected,
  });

  final Widget child;
  final List<PopupMenuItem> items;
  final Function(dynamic) onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      // offset under the button
      offset: const Offset(0, 50),
      itemBuilder: (BuildContext context) => items,
      onSelected: onSelected,
      child: child,
    );
  }
}
