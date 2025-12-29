import 'package:flutter/material.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/auth/presentation/widgets/auth_toggle_container.dart';

class RowLoginTypeToggle extends StatefulWidget {
  const RowLoginTypeToggle({super.key, this.onToggle});

  final Function(AuthToggleType)? onToggle;

  @override
  State<RowLoginTypeToggle> createState() => _RowLoginTypeToggleState();
}

class _RowLoginTypeToggleState extends State<RowLoginTypeToggle> {
  AuthToggleType selectedType = AuthToggleType.client_registration;

  void _toggleType(AuthToggleType type) {
    setState(() {
      selectedType = type;
      widget.onToggle?.call(type);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AuthToggleContainer(
          title: AuthToggleType.client_registration.name,
          isSelected: selectedType == AuthToggleType.client_registration,
          onToggle: () => _toggleType(AuthToggleType.client_registration),
        ),
        AppPadding.smallPadding.sizedWidth,
        AuthToggleContainer(
          title: AuthToggleType.productive_family_registration.name,
          isSelected:
              selectedType == AuthToggleType.productive_family_registration,
          onToggle: () =>
              _toggleType(AuthToggleType.productive_family_registration),
        ),
      ],
    );
  }
}
