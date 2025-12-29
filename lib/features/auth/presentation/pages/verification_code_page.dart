import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/components/textformfields/pin_textformfield.dart';
import 'package:nakha/core/components/utils/resend_rich_button.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/other_helpers.dart';
import 'package:nakha/features/auth/domain/entities/login_params.dart';
import 'package:nakha/features/auth/domain/use_cases/verify_use_case.dart';
import 'package:nakha/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/landing/presentation/pages/landing_page.dart';

class VerificationCodePage extends StatefulWidget {
  const VerificationCodePage({
    super.key,
    this.phone = '',
    this.email = '',
    this.startReturnScreen = false,
  });

  final bool startReturnScreen;
  final String phone;
  final String email;

  @override
  State<VerificationCodePage> createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  late final TextEditingController _codeController;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController()..text = kDebugMode ? '9999' : '';
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.verifyRequestState == RequestState.loaded) {
                OtherHelper.showTopSuccessToast(state.verifyResponse.msg!);
                if (widget.startReturnScreen) {
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pop(true);
                } else {
                  context.navigateToPageWithClearStack(const LandingPage());
                }
              } else if (state.verifyRequestState == RequestState.error) {
                OtherHelper.showTopFailToast(state.verifyResponse.msg);
              }

              if (state.resendRequestState == RequestState.loaded) {
                OtherHelper.showTopSuccessToast(state.resendResponse.msg!);
              } else if (state.resendRequestState == RequestState.error) {
                OtherHelper.showTopFailToast(state.resendResponse.msg);
              }
            },
            builder: (context, state) {
              final loginBloc = LoginBloc.get(context);
              return ListView(
                padding: const EdgeInsets.all(AppPadding.padding32),
                children: [
                  Text(
                    'enter_verification_code',
                    textAlign: TextAlign.center,
                    style: AppStyles.title500.copyWith(
                      fontSize: AppFontSize.f16,
                      color: AppColors.cPrimary,
                    ),
                  ).tr(),
                  44.sizedHeight,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.largePadding,
                      vertical: AppPadding.padding40,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.cFillBorderLight),
                      borderRadius: BorderRadius.circular(
                        AppBorderRadius.radius30,
                      ),
                    ),
                    child: Column(
                      children: [
                        const AssetSvgImage(AssetImagesPath.mailBoxSVG),
                        50.sizedHeight,
                        PinTextFormField(
                          controller: _codeController,
                          onChanged: (value) {},
                          onComplete: (value) {
                            loginBloc.add(
                              VerifyButtonPressedEvent(
                                VerifyParams(
                                  phone: widget.phone,
                                  email: widget.email,
                                  code: _codeController.text,
                                ),
                              ),
                            );
                          },
                        ),
                        50.sizedHeight,
                        ResendRichButton(
                          onPressed: () {
                            loginBloc.add(
                              ResendCodeButtonPressedEvent(
                                LoginParameters(
                                  phone: widget.phone,
                                  email: widget.email,
                                  loginType: widget.email.isEmpty
                                      ? 'phone'
                                      : 'email',
                                ),
                              ),
                            );
                          },
                        ),
                        50.sizedHeight,
                        ReusedRoundedButton(
                          text: 'check',
                          isLoading:
                              state.verifyRequestState == RequestState.loading,
                          onPressed: () {
                            if (_codeController.text.isEmpty) {
                              OtherHelper.showTopInfoToast(
                                'please_enter_verification_code',
                              );
                              return;
                            }
                            loginBloc.add(
                              VerifyButtonPressedEvent(
                                VerifyParams(
                                  phone: widget.phone,
                                  email: widget.email,
                                  code: _codeController.text,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
