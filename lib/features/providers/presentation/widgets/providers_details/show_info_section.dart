import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/components/textformfields/reused_textformfield.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';

class ShowInfoSection extends StatelessWidget {
  const ShowInfoSection({super.key, required this.providersModel});

  final ProvidersModel providersModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 32,
      children: [
        Row(
          spacing: 26,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (providersModel.workingTime == 'morning' ||
                providersModel.workingTime == 'all')
              Expanded(
                child: ReusedTextFormField(
                  title: 'working_hours',
                  fillColor: const Color(0xFFF7F5ED),
                  readOnly: true,
                  // controller: TextEditingController(
                  //   text: providersModel.workingTime,
                  // ),
                  hintText: 'morning_shift',
                  titleColor: AppColors.grey54Color,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppBorderRadius.mediumRadius,
                    ),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            if (providersModel.workingTime == 'evening' ||
                providersModel.workingTime == 'all')
              Expanded(
                child: ReusedTextFormField(
                  fillColor: const Color(0xFFF7F5ED),
                  readOnly: true,
                  hintText: 'evening_shift',
                  titleColor: AppColors.grey54Color,
                  // controller: TextEditingController(
                  //   text: providersModel.workingTime,
                  // ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppBorderRadius.mediumRadius,
                    ),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
          ],
        ),
        ReusedTextFormField(
          title: 'brief_of_provider',
          fillColor: const Color(0xFFF7F5ED),
          readOnly: true,
          maxLines: 5,
          hintText: 'provider_brief'.tr(
            namedArgs: {'time': providersModel.preparationTime.toString()},
          ),
          titleColor: AppColors.grey54Color,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.mediumRadius),
            borderSide: BorderSide.none,
          ),
        ),
        // Row(
        //   children: [
        //     AssetSvgImage(
        //       providersModel.deliveryAvailable
        //           ? AssetImagesPath.tickCircleSVG
        //           : AssetImagesPath.closeCircleTickSVG,
        //     ),
        //     AppPadding.padding4.sizedWidth,
        //     Text(
        //       providersModel.deliveryAvailable
        //           ? 'avaliable_delivery'
        //           : 'not_avaliable_delivery',
        //       style: AppStyles.title400,
        //     ).tr(),
        //   ],
        // ),
      ],
    ).addPadding(all: AppPadding.padding32);
  }
}
