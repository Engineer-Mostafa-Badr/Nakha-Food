import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/components/textformfields/cities_region_drop_down.dart';
import 'package:nakha/core/components/textformfields/city_drop_down.dart';
import 'package:nakha/core/components/textformfields/custom_dropdown.dart';
import 'package:nakha/core/components/textformfields/reused_textformfield.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/validators.dart';
import 'package:nakha/features/profile/presentation/widgets/profile_page/pick_cover_image.dart';

class VendorProfileSection extends StatelessWidget {
  final TextEditingController deliveryPriceController;
  final TextEditingController workingTimeController;
  final TextEditingController preparationTimeController;

  final int? cityId;
  final int? districtId;
  final bool deliveryAvailable;
  final String imageUrl;

  final ValueChanged<int?> onCityChanged;
  final ValueChanged<int?> onDistrictChanged;
  final ValueChanged<bool> onAvailabilityChanged;
  final ValueChanged<String> onCoverChanged;

  const VendorProfileSection({
    super.key,
    required this.deliveryPriceController,
    required this.workingTimeController,
    required this.preparationTimeController,
    required this.cityId,
    required this.districtId,
    required this.deliveryAvailable,
    required this.imageUrl,
    required this.onCityChanged,
    required this.onDistrictChanged,
    required this.onAvailabilityChanged,
    required this.onCoverChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReusedTextFormField(
          controller: deliveryPriceController,
          hintText: 'enter_delivery_price',
          keyboardType: TextInputType.number,
          validator: Validators.validatePrice,
        ),
        AppPadding.smallPadding.sizedHeight,
        ReusedTextFormField(
          controller: workingTimeController,
          hintText: 'working_time',
          validator: Validators.requiredField,
        ),
        AppPadding.smallPadding.sizedHeight,
        ReusedTextFormField(
          controller: preparationTimeController,
          hintText: 'preparation_time',
          keyboardType: TextInputType.number,
          validator: Validators.requiredField,
        ),
        AppPadding.smallPadding.sizedHeight,
        CustomDropdownMenu(
          items: DeliveryAvailabilityEnum.values.map((e) => e.name).toList(),
          value: deliveryAvailable
              ? DeliveryAvailabilityEnum.delivery_open.name
              : DeliveryAvailabilityEnum.delivery_closed.name,
          onChanged: (v) {
            if (v == null) return;
            onAvailabilityChanged(
              v == DeliveryAvailabilityEnum.delivery_open.name,
            );
          },
          fillColor: AppColors.cFillTextFieldLight,
        ),
        AppPadding.smallPadding.sizedHeight,
        Row(
          children: [
            Expanded(
              child: CityDropDown(
                title: null,
                initValue: cityId,
                fillColor: AppColors.cFillTextFieldLight,
                onCitySelected: onCityChanged,
              ),
            ),
            AppPadding.smallPadding.sizedWidth,
            Expanded(
              child: DistrictDropDown(
                title: null,
                cityId: cityId,
                initValue: districtId,
                fillColor: AppColors.cFillTextFieldLight,
                onCitySelected: onDistrictChanged,
              ),
            ),
          ],
        ),
        AppPadding.smallPadding.sizedHeight,
        PickCoverImage(imageUrl: imageUrl, onImageChanged: onCoverChanged),
      ],
    );
  }
}
