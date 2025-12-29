import 'package:flutter/material.dart';
import 'package:nakha/core/components/appbar/shared_app_bar.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/auth/data/models/user_model.dart';
import 'package:nakha/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:nakha/features/profile/presentation/widgets/my_account/my_account_image_title.dart';
import 'package:nakha/features/profile/presentation/widgets/profile_page/profile_basic_info_section.dart';
import 'package:nakha/features/profile/presentation/widgets/profile_page/vendor_profile_section.dart';
import 'package:nakha/features/profile/presentation/widgets/profile_page/profile_form_actions.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _deliveryPriceController;
  late final TextEditingController _preparationTimeController;
  late final TextEditingController _workingTimeController;

  late final GlobalKey<FormState> _formKey;

  int? _cityId;
  int? _districtId;
  String? _coverImagePath;

  bool _deliveryAvailable = true;
  bool _hasChanges = false;
  bool _ignoreFieldChanges = false;

  UserModel? _lastSavedProfile;

  bool get _isVendor =>
      _lastSavedProfile?.isVendor ?? AppConst.user?.isVendor ?? false;

  @override
  void initState() {
    super.initState();
    ProfileBloc.get(context).add(const GetProfileEvent());

    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _deliveryPriceController = TextEditingController();
    _preparationTimeController = TextEditingController();
    _workingTimeController = TextEditingController();
    _formKey = GlobalKey<FormState>();

    _addListeners();
  }

  @override
  void dispose() {
    _removeListeners();
    _nameController.dispose();
    _phoneController.dispose();
    _deliveryPriceController.dispose();
    _preparationTimeController.dispose();
    _workingTimeController.dispose();
    super.dispose();
  }

  void _addListeners() {
    _nameController.addListener(_updateHasChanges);
    _phoneController.addListener(_updateHasChanges);
    _deliveryPriceController.addListener(_updateHasChanges);
    _preparationTimeController.addListener(_updateHasChanges);
    _workingTimeController.addListener(_updateHasChanges);
  }

  void _removeListeners() {
    _nameController.removeListener(_updateHasChanges);
    _phoneController.removeListener(_updateHasChanges);
    _deliveryPriceController.removeListener(_updateHasChanges);
    _preparationTimeController.removeListener(_updateHasChanges);
    _workingTimeController.removeListener(_updateHasChanges);
  }

  void _populate(UserModel profile, {bool fromUpdate = false}) {
    _ignoreFieldChanges = true;
    _lastSavedProfile = profile;

    _nameController.text = profile.name;
    _phoneController.text = profile.phone;
    _deliveryPriceController.text = profile.deliveryPrice > 0
        ? profile.deliveryPrice.toString()
        : '';
    if (!fromUpdate || profile.preparationTime > 0) {
      _preparationTimeController.text = profile.preparationTime > 0
          ? profile.preparationTime.toString()
          : '';
    }
    if (!fromUpdate || profile.workingTime.isNotEmpty) {
      _workingTimeController.text = profile.workingTime;
    }

    _cityId = profile.city.id;
    _districtId = profile.region?.id;
    if (!fromUpdate) {
      _deliveryAvailable = profile.deliveryAvailable;
    }
    _coverImagePath = null;

    _hasChanges = false;
    _ignoreFieldChanges = false;
  }

  void _updateHasChanges() {
    if (_ignoreFieldChanges || _lastSavedProfile == null) return;
    final p = _lastSavedProfile!;

    final changed =
        _nameController.text.trim() != p.name ||
        _phoneController.text.trim() != p.phone ||
        (_cityId ?? p.city.id) != p.city.id ||
        (_districtId ?? p.region?.id) != p.region?.id ||
        (int.tryParse(_deliveryPriceController.text) ?? 0) != p.deliveryPrice ||
        _workingTimeController.text.trim() != p.workingTime ||
        (int.tryParse(_preparationTimeController.text) ?? 0) !=
            p.preparationTime ||
        _deliveryAvailable != p.deliveryAvailable ||
        (_coverImagePath?.isNotEmpty ?? false);

    if (changed != _hasChanges) {
      setState(() => _hasChanges = changed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SharedAppBar(title: 'account_settings'),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: AppPadding.largePadding,
            horizontal: AppPadding.mediumPadding,
          ),
          children: [
            const MyAccountImageTitle(),
            ProfileBasicInfoSection(
              nameController: _nameController,
              phoneController: _phoneController,
            ),
            if (_isVendor)
              VendorProfileSection(
                deliveryPriceController: _deliveryPriceController,
                workingTimeController: _workingTimeController,
                preparationTimeController: _preparationTimeController,
                cityId: _cityId,
                districtId: _districtId,
                deliveryAvailable: _deliveryAvailable,
                imageUrl:
                    _lastSavedProfile?.coverImage ??
                    AppConst.user?.coverImage ??
                    '',
                onCityChanged: (v) {
                  setState(() {
                    _cityId = v;
                    _districtId = null;
                  });
                  _updateHasChanges();
                },
                onDistrictChanged: (v) {
                  setState(() => _districtId = v);
                  _updateHasChanges();
                },
                onAvailabilityChanged: (v) {
                  setState(() => _deliveryAvailable = v);
                  _updateHasChanges();
                },
                onCoverChanged: (v) {
                  setState(() => _coverImagePath = v);
                  _updateHasChanges();
                },
              ),
          ].paddingDirectional(bottom: AppPadding.largePadding),
        ),
      ),
      bottomNavigationBar: ProfileFormActions(
        formKey: _formKey,
        hasChanges: _hasChanges,
        lastProfile: _lastSavedProfile,
        cityId: _cityId,
        districtId: _districtId,
        deliveryAvailable: _deliveryAvailable,
        nameController: _nameController,
        phoneController: _phoneController,
        deliveryPriceController: _deliveryPriceController,
        workingTimeController: _workingTimeController,
        preparationTimeController: _preparationTimeController,
        onProfileLoaded: (profile, {bool fromUpdate = false}) {
          setState(() {
            _populate(profile, fromUpdate: fromUpdate);
          });
        },
      ),
    );
  }
}
