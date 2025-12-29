import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/components/textformfields/reused_textformfield.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/other_helpers.dart';
import 'package:nakha/core/utils/validators.dart';
import 'package:nakha/features/auth/domain/entities/login_params.dart';
import 'package:nakha/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:nakha/features/auth/presentation/pages/verification_code_page.dart';

class LoginWithEmailBody extends StatefulWidget {
  const LoginWithEmailBody({super.key, this.startReturnScreen = false});

  final bool startReturnScreen;

  @override
  State<LoginWithEmailBody> createState() => _LoginWithEmailBodyState();
}

class _LoginWithEmailBodyState extends State<LoginWithEmailBody> {
  late final TextEditingController _emailAddressController;
  late final GlobalKey<FormState> _formKey;

  // late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailAddressController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    // _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailAddressController.dispose();
    _formKey.currentState?.dispose();
    // _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ReusedTextFormField(
            controller: _emailAddressController,
            title: 'email',
            hintText: 'info@gmail.com',
            validator: Validators.validateEmail,
          ),
          // AppPadding.largePadding.sizedHeight,
          // ReusedTextFormField(
          //   controller: _passwordController,
          //   title: 'password',
          //   hintText: 'password',
          //   dispose: false,
          // ),
          AppPadding.padding10.sizedHeight,
          // Text(
          //   'forgot_password',
          //   textAlign: TextAlign.end,
          //   style: AppStyles.title500.copyWith(
          //     fontSize: AppFontSize.f12,
          //   ),
          // ).tr().addAction(
          //   onTap: () {
          //     context.navigateToPage(const ChangePasswordPage());
          //   },
          // ),
          AppPadding.padding18.sizedHeight,
          BlocConsumer<LoginBloc, LoginState>(
            buildWhen: (previous, current) {
              return previous.requestState != current.requestState;
            },
            listener: (context, state) {
              if (state.requestState == RequestState.loaded) {
                OtherHelper.showTopSuccessToast(state.response.msg!);
                context.navigateToPage(
                  VerificationCodePage(
                    phone: _emailAddressController.text,
                    startReturnScreen: widget.startReturnScreen,
                  ),
                );
              } else if (state.requestState == RequestState.error) {
                OtherHelper.showTopFailToast(state.response.msg);
              }
            },
            builder: (context, state) {
              final loginBloc = LoginBloc.get(context);
              return ReusedRoundedButton(
                text: 'login',
                isLoading: state.requestState == RequestState.loading,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    loginBloc.add(
                      LoginButtonPressedEvent(
                        LoginParameters(
                          email: _emailAddressController.text,
                          loginType: 'email',
                        ),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
