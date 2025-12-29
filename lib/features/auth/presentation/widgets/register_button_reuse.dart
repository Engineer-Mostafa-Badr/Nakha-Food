import 'package:flutter/material.dart';
import 'package:nakha/core/components/buttons/ritch_text_button_.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/auth/presentation/pages/login_page.dart';
import 'package:nakha/features/auth/presentation/widgets/accept_policy_row.dart';

class RegisterButtonReuse extends StatelessWidget {
  const RegisterButtonReuse({
    super.key,
    required this.onPressed,
    required this.togglePolicy,
    this.isLoading = false,
  });

  final bool isLoading;
  final Function() onPressed;
  final Function(bool) togglePolicy;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AcceptPolicyRow(onChanged: togglePolicy),
        AppPadding.padding24.sizedHeight,
        ReusedRoundedButton(
          text: 'next',
          isLoading: isLoading,
          onPressed: onPressed,
        ),
        AppPadding.mediumPadding.sizedHeight,
        Center(
          child: RichTextButton(
            text1: 'you_have_account',
            text2: 'login_here',
            onPressed2: () {
              context.navigateToPageWithReplacement(const LoginPage());
            },
          ),
        ),
        37.sizedHeight,
      ],
    );
  }
}
