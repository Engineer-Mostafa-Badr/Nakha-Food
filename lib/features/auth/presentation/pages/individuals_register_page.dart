import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/textformfields/cities_region_drop_down.dart';
import 'package:nakha/core/components/textformfields/city_drop_down.dart';
import 'package:nakha/core/components/textformfields/reused_textformfield.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/other_helpers.dart';
import 'package:nakha/core/utils/validators.dart';
import 'package:nakha/features/auth/domain/entities/register_params.dart';
import 'package:nakha/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:nakha/features/auth/presentation/pages/verification_code_page.dart';
import 'package:nakha/features/auth/presentation/widgets/auth_toggle_container.dart';
import 'package:nakha/features/auth/presentation/widgets/register_button_reuse.dart';
import 'package:nakha/features/auth/presentation/widgets/row_login_type_toggle.dart';
import 'package:nakha/features/injection_container.dart';

class IndividualsRegisterPage extends StatefulWidget {
  const IndividualsRegisterPage({super.key});

  @override
  State<IndividualsRegisterPage> createState() =>
      _IndividualsRegisterPageState();
}

class _IndividualsRegisterPageState extends State<IndividualsRegisterPage> {
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _nameController;
  late int? _countryId;
  late int? _districtId;
  late final GlobalKey<FormState> _formKey;
  late bool _isAgreeTerms;

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
    _nameController = TextEditingController();
    _countryId = null;
    _districtId = null;
    _formKey = GlobalKey<FormState>();
    _isAgreeTerms = false;
  }

  AuthToggleType authToggleType = AuthToggleType.client_registration;

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginBloc>(),
      child: Scaffold(
        // appBar: const SharedAppBar(title: 'register'),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(AppPadding.largePadding),
              children: [
                const MyAppLogo(size: 100),
                AppPadding.largePadding.sizedHeight,
                Text(
                  'register',
                  textAlign: TextAlign.center,
                  style: AppStyles.title800.copyWith(
                    fontSize: AppFontSize.f18,
                    color: AppColors.cSecondary,
                  ),
                ).tr(),
                AppPadding.padding40.sizedHeight,
                RowLoginTypeToggle(
                  onToggle: (value) {
                    setState(() {
                      authToggleType = value;
                    });
                  },
                ),
                AppPadding.padding40.sizedHeight,
                ReusedTextFormField(
                  controller: _nameController,
                  hintText: 'enter_full_name',
                  keyboardType: TextInputType.name,
                  validator: Validators.validateName,
                ),
                AppPadding.largePadding.sizedHeight,
                ReusedTextFormField(
                  controller: _phoneNumberController,
                  hintText: 'enter_phone_number',
                  keyboardType: TextInputType.phone,
                  validator: Validators.validatePhone,
                ),
                AppPadding.largePadding.sizedHeight,
                Row(
                  children: [
                    Expanded(
                      child: CityDropDown(
                        title: null,
                        initValue: _countryId,
                        onCitySelected: (value) {
                          setState(() {
                            _countryId = value;
                            _districtId =
                                null; // Reset district when country changes
                          });
                        },
                      ),
                    ),
                    AppPadding.smallPadding.sizedWidth,
                    Expanded(
                      child: DistrictDropDown(
                        title: null,
                        cityId: _countryId,
                        initValue: _districtId,
                        onCitySelected: (value) {
                          _districtId = value;
                        },
                      ),
                    ),
                  ],
                ),
                AppPadding.largePadding.sizedHeight,
                BlocConsumer<LoginBloc, LoginState>(
                  buildWhen: (previous, current) =>
                      previous.registerRequestState !=
                      current.registerRequestState,
                  listener: (context, state) {
                    if (state.registerRequestState == RequestState.loaded) {
                      OtherHelper.showTopSuccessToast(
                        state.registerResponse.msg!,
                      );
                      context.navigateToPage(
                        VerificationCodePage(
                          phone: _phoneNumberController.text,
                        ),
                      );
                    } else if (state.registerRequestState ==
                        RequestState.error) {
                      OtherHelper.showTopFailToast(state.registerResponse.msg);
                    }
                  },
                  builder: (context, state) {
                    return RegisterButtonReuse(
                      isLoading:
                          state.registerRequestState == RequestState.loading,
                      togglePolicy: (value) {
                        _isAgreeTerms = value;
                      },
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        if (!_isAgreeTerms) {
                          OtherHelper.showTopInfoToast(
                            'you_must_agree_to_terms',
                          );
                          return;
                        }
                        LoginBloc.get(context).add(
                          RegisterButtonPressedEvent(
                            RegisterParams(
                              name: _nameController.text,
                              phone: _phoneNumberController.text,
                              cityId: _countryId!,
                              districtId: _districtId!,
                              acceptTerms: _isAgreeTerms,
                              userType:
                                  authToggleType ==
                                      AuthToggleType.client_registration
                                  ? 'client'
                                  : 'vendor',
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
