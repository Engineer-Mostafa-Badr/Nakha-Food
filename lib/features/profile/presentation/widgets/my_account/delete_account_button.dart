import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/screen_status/loading_widget.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/other_helpers.dart';
import 'package:nakha/features/auth/domain/entities/delete_account_params.dart';
import 'package:nakha/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:nakha/features/auth/presentation/pages/login_page.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/profile/presentation/widgets/my_account/my_account_list_tile.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginBloc>(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.deleteAccountRequestState == RequestState.loaded) {
            state.deleteAccountResponse.msg!.showTopSuccessToast;
            context.navigateToPageWithClearStack(const LoginPage());
          } else if (state.deleteAccountRequestState == RequestState.error) {
            state.deleteAccountResponse.msg!.showTopErrorToast;
          }
        },
        builder: (context, state) {
          return state.deleteAccountRequestState == RequestState.loading
              ? const LoadingWidget()
              : MyAccountListTile(
                  title: 'delete_account',
                  assetSvg: AssetImagesPath.userXMarkSVG,
                  onTap: () {
                    OtherHelper.showAlertDialogWithTwoMiddleButtons(
                      context: context,
                      title: 'delete_account',
                      content: Text(
                        'delete_account_confirmation',
                        textAlign: TextAlign.center,
                        style: AppStyles.title500,
                      ).tr(),
                      noText: 'back',
                      onPressedNo: () {},
                      onPressedOk: () {
                        LoginBloc.get(context).add(
                          const DeleteAccountButtonPressedEvent(
                            DeleteAccountParameters(),
                          ),
                        );
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
