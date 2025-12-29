import 'package:flutter/material.dart';
import 'package:nakha/core/components/textformfields/reused_textformfield.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/validators.dart';

class ProfileBasicInfoSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;

  const ProfileBasicInfoSection({
    super.key,
    required this.nameController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReusedTextFormField(
          controller: nameController,
          hintText: 'enter_full_name',
          keyboardType: TextInputType.name,
          validator: Validators.validateName,
        ),
        AppPadding.smallPadding.sizedHeight,
        ReusedTextFormField(
          controller: phoneController,
          hintText: 'enter_phone_number',
          keyboardType: TextInputType.phone,
          validator: Validators.validatePhone,
        ),
      ],
    );
  }
}
