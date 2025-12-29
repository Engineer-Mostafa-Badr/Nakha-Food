import 'package:flutter/material.dart';
import 'package:nakha/core/components/appbar/shared_app_bar.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/storage/main_hive_box.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/auth/domain/entities/logout_params.dart';
import 'package:nakha/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:nakha/features/auth/presentation/pages/login_page.dart';
import 'package:nakha/features/favourite/presentation/pages/favourite_page.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/profile/presentation/pages/contact_us_page.dart';
import 'package:nakha/features/profile/presentation/pages/profile_page.dart';
import 'package:nakha/features/profile/presentation/widgets/contact_us/contact_us_bottom_sheet.dart';
import 'package:nakha/features/profile/presentation/widgets/my_account/delete_account_button.dart';
import 'package:nakha/features/profile/presentation/widgets/my_account/my_account_list_tile.dart';
import 'package:nakha/features/support/presentation/pages/tickets_page.dart';
import 'package:nakha/features/wallet/presentation/pages/wallet_page.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SharedAppBar(title: 'settings', showBackButton: false),
      // topWidget: const MyAccountImageTitle(),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.padding24),
        children: [
          // const MyAccountImageNamePhone(),
          // 0.sizedHeight,

          // const ProfileDivider(),
          // MyAccountListTile(
          //   title: 'favorites',
          //   assetSvg: AssetImagesPath.favoriteSVG,
          //   onTap: () {
          //     CheckLoginDelay.checkIfNeedLogin(onExecute: () {});
          //   },
          // ),
          // const ProfileDivider(),
          // MyAccountListTile(
          //   title: 'language',
          //   assetSvg: AssetImagesPath.languageSVG,
          //   subtitle: context.locale.languageCode.toLowerCase().tr(),
          //   onTap: () {},
          // ),
          // const ProfileDivider(),
          // MyAccountListTile(
          //   title: 'country',
          //   assetSvg: AssetImagesPath.countrySVG,
          //   subtitle: 'saudi_arabia',
          //   onTap: () {},
          // ),
          if (AppConst.isLogin) ...[
            MyAccountListTile(
              title: 'account_settings',
              assetSvg: AssetImagesPath.userGearSVG,
              onTap: () {
                context.navigateToPage(const ProfilePage());
              },
            ),
            const ProfileDivider(),
            MyAccountListTile(
              title: 'favorites',
              assetSvg: AssetImagesPath.favoriteSVG,
              color: Colors.black54,
              onTap: () {
                context.navigateToPage(const FavouritePage());
              },
            ),
            const ProfileDivider(),
            MyAccountListTile(
              title: 'wallet',
              assetSvg: AssetImagesPath.walletSVG,
              color: Colors.black54,
              onTap: () {
                context.navigateToPage(const WalletPage());
              },
            ),
          ],
          const ProfileDivider(),
          MyAccountListTile(
            title: 'contact_us',
            assetSvg: AssetImagesPath.handsBrainSVG,
            onTap: () {
              context.navigateToPage(const ContactUsPage());
            },
          ),
          if (AppConst.isLogin) ...[
            const ProfileDivider(),
            MyAccountListTile(
              title: 'help_center',
              assetSvg: AssetImagesPath.helpSVG,
              onTap: () {
                context.navigateToPage(const TicketsPage());
              },
            ),
          ],
          const ProfileDivider(),
          MyAccountListTile(
            title: 'contact_us_title',
            assetSvg: AssetImagesPath.contactSVG,
            iconSize: 18,
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) {
                  return const ContactUsBottomSheet();
                },
              );
            },
          ),
          if (AppConst.isLogin) ...[
            const ProfileDivider(),
            MyAccountListTile(
              title: 'logout',
              assetSvg: AssetImagesPath.userLogoutSVG,
              onTap: () {
                sl<LoginBloc>().add(
                  const LogoutButtonPressedEvent(LogoutParameters()),
                );
                sl<MainSecureStorage>().logout();
                context.navigateToPageWithClearStack(const LoginPage());
              },
            ),
            const ProfileDivider(),
            const DeleteAccountButton(),
          ],
        ],
      ),
    );
  }
}

class ProfileDivider extends StatelessWidget {
  const ProfileDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 0,
      endIndent: AppPadding.mediumPadding,
      indent: AppPadding.mediumPadding,
    );
  }
}
