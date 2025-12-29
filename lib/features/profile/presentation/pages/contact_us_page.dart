import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/components/appbar/shared_app_bar.dart';
import 'package:nakha/core/components/buttons/button_with_svg_icon.dart';
import 'package:nakha/core/components/textformfields/reused_textformfield.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/image_utils.dart';
import 'package:nakha/core/utils/validators.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/profile/domain/use_cases/contact_us_usecase.dart';
import 'package:nakha/features/profile/presentation/bloc/profile_bloc.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _messageController;
  String? filePath;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _messageController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _messageController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileBloc>(),
      child: Scaffold(
        appBar: const SharedAppBar(title: 'contact_us'),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.mediumPadding,
              vertical: AppPadding.mediumPadding,
            ),
            children: [
              if (!AppConst.isLogin) ...[
                // name
                ReusedTextFormField(
                  title: 'name',
                  hintText: 'enter_your_name',
                  validator: Validators.validateName,
                  keyboardType: TextInputType.name,
                  titleColor: AppColors.cPrimary,
                  controller: _nameController,
                ),
                AppPadding.largePadding.sizedHeight,
                // phone
                ReusedTextFormField(
                  controller: _phoneController,
                  title: 'phone_number',
                  hintText: '05xxxxxxxx',
                  titleColor: AppColors.cPrimary,

                  keyboardType: TextInputType.phone,
                  validator: Validators.validatePhone,
                ),
                AppPadding.largePadding.sizedHeight,
              ],

              // address
              ReusedTextFormField(
                title: 'address',
                hintText: 'enter_your_address',
                validator: Validators.requiredField,
                keyboardType: TextInputType.text,
                titleColor: AppColors.cPrimary,
                controller: _addressController,
              ),
              AppPadding.largePadding.sizedHeight,

              // message
              ReusedTextFormField(
                title: 'description',
                hintText: 'enter_your_message',
                validator: Validators.validateDescription,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                minLines: 3,
                titleColor: AppColors.cPrimary,
                controller: _messageController,
              ),
              AppPadding.largePadding.sizedHeight,
              // file attachment
              ReusedTextFormField(
                title: 'file_attachment',
                hintText: 'optional',
                keyboardType: TextInputType.text,
                titleColor: AppColors.cPrimary,
                controller: TextEditingController(
                  text: filePath != null ? 'file_selected'.tr() : '',
                ),
                readOnly: true,
                onTap: () async {
                  await sl<ImageUtils>().pickImagesFromGallery().then((images) {
                    if (images.isNotEmpty) {
                      setState(() {
                        filePath = images.first.path;
                      });
                    }
                  });
                },
                // dispose: true,
              ),
              40.sizedHeight,

              // submit button
              BlocConsumer<ProfileBloc, ProfileState>(
                buildWhen: (previous, current) =>
                    previous.contactUsState != current.contactUsState,
                listener: (context, state) {
                  if (state.contactUsState == RequestState.loaded) {
                    state.contactUsResponse.msg!.showTopSuccessToast;
                    Navigator.pop(context);
                  } else if (state.contactUsState == RequestState.error) {
                    state.contactUsResponse.msg!.showTopErrorToast;
                  }
                },
                builder: (context, state) {
                  return ButtonWithSvgIcon(
                    text: 'send',
                    isLoading: state.contactUsState == RequestState.loading,
                    svgEndIcon: AssetImagesPath.sendMessageSVG,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final contactUsParams = ContactUsParams(
                          address: _addressController.text,
                          content: _messageController.text,
                          filePath: filePath,
                          name: _nameController.text,
                          phone: _phoneController.text,
                        );
                        ProfileBloc.get(
                          context,
                        ).add(ContactUsEvent(contactUsParams));
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
