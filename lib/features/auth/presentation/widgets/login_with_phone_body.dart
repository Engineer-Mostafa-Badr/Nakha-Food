import 'package:flutter/foundation.dart';
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

class LoginWithPhoneBody extends StatefulWidget {
  const LoginWithPhoneBody({super.key, this.startReturnScreen = false});

  final bool startReturnScreen;

  @override
  State<LoginWithPhoneBody> createState() => _LoginWithPhoneBodyState();
}

class _LoginWithPhoneBodyState extends State<LoginWithPhoneBody> {
  late final TextEditingController _phoneController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController()
      ..text = kDebugMode ? '0511111111' : '';
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          ReusedTextFormField(
            controller: _phoneController,
            title: 'phone_number',
            hintText: '05xxxxxxxx',
            keyboardType: TextInputType.phone,
            validator: Validators.validatePhone,
          ),
          AppPadding.padding30.sizedHeight,
          BlocConsumer<LoginBloc, LoginState>(
            buildWhen: (previous, current) {
              return previous.requestState != current.requestState;
            },
            listener: (context, state) {
              if (state.requestState == RequestState.loaded) {
                OtherHelper.showTopSuccessToast(state.response.msg!);
                context.navigateToPage(
                  VerificationCodePage(
                    phone: _phoneController.text,
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
                  // context.navigateToPageWithClearStack(const LandingPage());
                  if (_formKey.currentState!.validate()) {
                    loginBloc.add(
                      LoginButtonPressedEvent(
                        LoginParameters(phone: _phoneController.text),
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
