import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/support/data/models/ticket_model.dart';

class TicketItemWidget extends StatelessWidget {
  const TicketItemWidget({super.key, required this.ticket});

  final TicketModel? ticket;

  @override
  Widget build(BuildContext context) {
    final color = ticket?.status == 'open'
        ? AppColors.cSuccess
        : AppColors.cPrimary;
    return IntrinsicHeight(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(AppPadding.largePadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppBorderRadius.radius10),
              border: Border.all(color: AppColors.cFillBorderLight),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        ticket?.title ?? notSpecified + notSpecified,
                        style: AppStyles.title500,
                      ),
                    ),
                    AppPadding.smallPadding.sizedWidth,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.padding24,
                        vertical: AppPadding.padding6,
                      ),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(
                          AppBorderRadius.radius8,
                        ),
                      ),
                      child: Text(
                        ticket?.status ?? notSpecified,
                        style: AppStyles.title400.copyWith(
                          color: Colors.white,
                          fontSize: AppFontSize.f12,
                        ),
                      ).tr(),
                    ),
                  ],
                ),
                AppPadding.mediumPadding.sizedHeight,
                Row(
                  children: [
                    RowIconTextReports(
                      assetSvg: AssetImagesPath.messagesSVG,
                      text: ticket?.commentsCount.toString() ?? '00',
                      color: null,
                    ),
                    AppPadding.largePadding.sizedWidth,
                    RowIconTextReports(
                      assetSvg: AssetImagesPath.time2SVG,
                      text: ticket?.humanDiff ?? notSpecified,
                      color: null,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 6,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(AppBorderRadius.radius10),
                bottomEnd: Radius.circular(AppBorderRadius.radius10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RowIconTextReports extends StatelessWidget {
  const RowIconTextReports({
    super.key,
    required this.assetSvg,
    required this.text,
    this.color = AppColors.cPrimary,
  });

  final String assetSvg;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AssetSvgImage(assetSvg),
        AppPadding.smallPadding.sizedWidth,
        Text(
          text,
          style: AppStyles.title400.copyWith(
            color: color,
            fontSize: AppFontSize.f12,
          ),
        ),
      ],
    );
  }
}
