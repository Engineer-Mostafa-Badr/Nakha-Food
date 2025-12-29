import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/components/utils/container_for_bottom_nav_buttons.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/core/storage/main_hive_box.dart';
import 'package:nakha/features/auth/data/models/user_model.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/profile/domain/entities/update_profile_params.dart';
import 'package:nakha/features/profile/presentation/bloc/profile_bloc.dart';

class ProfileFormActions extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool hasChanges;
  final UserModel? lastProfile;

  final int? cityId;
  final int? districtId;
  final bool deliveryAvailable;

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController deliveryPriceController;
  final TextEditingController workingTimeController;
  final TextEditingController preparationTimeController;

  final void Function(UserModel profile, {bool fromUpdate}) onProfileLoaded;

  const ProfileFormActions({
    super.key,
    required this.formKey,
    required this.hasChanges,
    required this.lastProfile,
    required this.cityId,
    required this.districtId,
    required this.deliveryAvailable,
    required this.nameController,
    required this.phoneController,
    required this.deliveryPriceController,
    required this.workingTimeController,
    required this.preparationTimeController,
    required this.onProfileLoaded,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerForBottomNavButtons(
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.getProfileState == RequestState.loaded &&
              state.getProfileResponse.data != null) {
            onProfileLoaded(state.getProfileResponse.data!);
          } else if (state.updateProfileState == RequestState.loaded &&
              state.updateProfileResponse.data != null) {
            state.updateProfileResponse.msg!.showTopSuccessToast;
            sl<MainSecureStorage>().saveUserData(
              state.updateProfileResponse.data!,
            );
            onProfileLoaded(
              state.updateProfileResponse.data!,
              fromUpdate: true,
            );
            ProfileBloc.get(context).add(const GetProfileEvent());
          } else if (state.updateProfileState == RequestState.error) {
            state.updateProfileResponse.msg!.showTopErrorToast;
          }
        },
        builder: (context, state) {
          final enabled =
              lastProfile != null &&
              hasChanges &&
              state.updateProfileState != RequestState.loading;

          return AbsorbPointer(
            absorbing: !enabled,
            child: Opacity(
              opacity: enabled ? 1 : 0.6,
              child: ReusedRoundedButton(
                text: 'save_settings',
                isLoading: state.updateProfileState == RequestState.loading,
                onPressed: () {
                  if (!formKey.currentState!.validate() || !enabled) return;

                  ProfileBloc.get(context).add(
                    UpdateProfileEvent(
                      UpdateProfileParams(
                        name: nameController.text.trim(),
                        phone: phoneController.text.trim(),
                        cityId: cityId ?? lastProfile!.city.id,
                        districtId: districtId ?? lastProfile!.region?.id ?? 0,
                        deliveryPrice: deliveryPriceController.text.trim(),
                        workingTime: workingTimeController.text.trim(),
                        preparationTime:
                            int.tryParse(preparationTimeController.text) ?? 0,
                        deliveryAvailable: deliveryAvailable,
                        coverImage: '',
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
