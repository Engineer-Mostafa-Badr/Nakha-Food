import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/screen_status/loading_widget.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class LoadMoreButton extends StatelessWidget {
  const LoadMoreButton({
    super.key,
    this.isLastPage = false,
    this.isLoading = false,
    this.onPressed,
  });

  final bool isLastPage;
  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LoadingWidget(),
              AppPadding.mediumPadding.sizedHeight,
              Text(
                'loading_more',
                textAlign: TextAlign.center,
                style: AppStyles.subtitle600,
              ).tr(),
            ],
          )
        : TextButton.icon(
            onPressed: isLastPage || isLoading ? null : onPressed,
            icon: Icon(
              isLastPage ? Icons.arrow_upward : Icons.arrow_downward,
              color: AppColors.cTextSubtitleLight,
            ),
            label: Text(
              isLastPage ? 'no_more' : 'load_more',
              style: AppStyles.subtitle600,
            ).tr(),
          );
  }
}
