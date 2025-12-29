import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/components/textformfields/reused_textformfield.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/validators.dart';

class CancelBottomSheet extends StatefulWidget {
  const CancelBottomSheet({super.key, required this.onCancel});

  final Function(String) onCancel;

  @override
  State<CancelBottomSheet> createState() => _CancelBottomSheetState();
}

class _CancelBottomSheetState extends State<CancelBottomSheet> {
  late final TextEditingController _reasonController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _reasonController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppPadding.largePadding),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppPadding.mediumPadding,
          children: [
            AppPadding.mediumPadding.sizedHeight,
            ReusedTextFormField(
              title: 'cancel_order_reason',
              controller: _reasonController,
              maxLines: 3,
              hintText: 'cancel_order_reason_hint',
              textInputAction: TextInputAction.done,
              validator: Validators.requiredField,
            ),
            20.sizedHeight,
            ReusedRoundedButton(
              text: 'cancel_order',
              color: AppColors.cError,
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  widget.onCancel(_reasonController.text);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
