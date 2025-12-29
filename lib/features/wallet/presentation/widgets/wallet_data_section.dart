import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:nakha/features/wallet/presentation/widgets/wallet_container.dart';

class WalletDataSection extends StatelessWidget {
  const WalletDataSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      buildWhen: (previous, current) =>
          previous.getWalletResponse.data?.balance !=
              current.getWalletResponse.data?.balance ||
          previous.getWalletResponse.data?.totalOrders !=
              current.getWalletResponse.data?.totalOrders ||
          previous.getWalletResponse.data?.totalPurchases !=
              current.getWalletResponse.data?.totalPurchases,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppPadding.mediumPadding,
          children: [
            WalletContainer(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'currency_balance',
                          style: AppStyles.title400.copyWith(
                            color: AppColors.grey54Color,
                            fontSize: AppFontSize.f16,
                          ),
                        ).tr(),
                        AppPadding.smallPadding.sizedHeight,
                        Row(
                          children: [
                            Text(
                              '${state.getWalletResponse.data?.balance ?? 0}',
                              style: AppStyles.title900.copyWith(
                                color: AppColors.grey54Color,
                                fontSize: AppFontSize.f32,
                              ),
                            ),
                            AppPadding.padding4.sizedWidth,
                            Text(
                              'r.s',
                              style: AppStyles.title400.copyWith(
                                color: AppColors.cPrimary,
                                fontSize: AppFontSize.f16,
                              ),
                            ).tr(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // const AssetSvgImage(AssetImagesPath.plusSVG),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: WalletContainer(
                    child: Column(
                      children: [
                        Text(
                          '${state.getWalletResponse.data?.totalOrders ?? 0}',
                          style: AppStyles.title900.copyWith(
                            color: AppColors.grey54Color,
                            fontSize: AppFontSize.f20,
                          ),
                        ),
                        AppPadding.smallPadding.sizedHeight,
                        Text(
                          'orders_number',
                          style: AppStyles.title400.copyWith(
                            color: AppColors.grey54Color,
                            fontSize: AppFontSize.f12,
                          ),
                        ).tr(),
                      ],
                    ),
                  ),
                ),
                AppPadding.mediumPadding.sizedWidth,
                Expanded(
                  child: WalletContainer(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${state.getWalletResponse.data?.totalPurchases.toStringAsFixed(2) ?? 0}',
                              textAlign: TextAlign.center,
                              style: AppStyles.title900.copyWith(
                                color: AppColors.grey54Color,
                                fontSize: AppFontSize.f20,
                              ),
                            ),
                            AppPadding.padding4.sizedWidth,
                            Text(
                              'r.s',
                              style: AppStyles.title400.copyWith(
                                color: AppColors.grey54Color,
                                fontSize: AppFontSize.f16,
                              ),
                            ).tr(),
                          ],
                        ),
                        AppPadding.smallPadding.sizedHeight,
                        Text(
                          'total_buys',
                          style: AppStyles.title400.copyWith(
                            color: AppColors.grey54Color,
                            fontSize: AppFontSize.f12,
                          ),
                        ).tr(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            AppPadding.padding2.sizedHeight,
            Text(
              'previous_transactions',
              style: AppStyles.title500.copyWith(
                color: AppColors.grey54Color,
                fontSize: AppFontSize.f16,
              ),
            ).tr(),
          ],
        );
      },
    ).addPadding(all: AppPadding.largePadding);
  }
}
