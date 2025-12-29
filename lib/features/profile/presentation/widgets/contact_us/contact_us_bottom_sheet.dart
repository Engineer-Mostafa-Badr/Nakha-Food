import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/profile/presentation/widgets/contact_us/contact_us_list_tile.dart';

class ContactUsBottomSheet extends StatelessWidget {
  const ContactUsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppPadding.largePadding.sizedHeight,
          Text(
            'contact_us_title',
            style: AppStyles.title700.copyWith(fontSize: AppFontSize.f18),
          ).tr(),
          AppPadding.smallPadding.sizedHeight,
          ContactUsListTile(
            assetSvg: AssetImagesPath.phoneSVG,
            value: 'phone_number',
            url: 'tel:${AppConst.homeModel?.phoneNumber ?? ''}',
          ),
          ContactUsListTile(
            assetSvg: AssetImagesPath.whatsappSVG,
            value: 'whatsapp_number',
            url: 'https://wa.me/${AppConst.homeModel?.whatsappNumber ?? ''}',
          ),
          ContactUsListTile(
            assetSvg: AssetImagesPath.emailSVG,
            value: 'email_address',
            url: 'mailto:${AppConst.homeModel?.email ?? ''}',
          ),
          ContactUsListTile(
            assetSvg: AssetImagesPath.mapSVG,
            value: 'address_on_map',
            url: AppConst.homeModel?.location ?? '',
          ),
          AppPadding.largePadding.sizedHeight,
        ],
      ),
    );
  }
}
