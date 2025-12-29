import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/components/textformfields/cities_region_drop_down.dart';
import 'package:nakha/core/components/textformfields/city_drop_down.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/providers/domain/use_cases/get_providers_usecase.dart';

class AllProvidersBottomSheet extends StatefulWidget {
  const AllProvidersBottomSheet({
    super.key,
    required this.parameters,
    this.onFilterApplied,
    this.providersCount = 0,
  });

  final ProvidersParameters parameters;
  final Function(ProvidersParameters parameters)? onFilterApplied;
  final int providersCount;

  @override
  State<AllProvidersBottomSheet> createState() =>
      _AllProvidersBottomSheetState();
}

class _AllProvidersBottomSheetState extends State<AllProvidersBottomSheet> {
  late ProvidersParameters _parameters;

  @override
  void initState() {
    super.initState();
    _parameters = widget.parameters;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppPadding.largePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 30.h,
        children: [
          CityDropDown(
            title: 'select_city',
            initValue: _parameters.cityId,
            onCitySelected: (city) {
              setState(() {
                _parameters = ProvidersParameters(cityId: city);
              });
            },
          ),
          DistrictDropDown(
            cityId: _parameters.cityId,
            initValue: _parameters.regionId,
            title: 'select_district',
            onCitySelected: (district) {
              _parameters = _parameters.copyWith(regionId: district);
            },
          ),
          ReusedRoundedButton(
            text:
                '${'filter'.tr()} (${widget.providersCount} ${'provider_'.tr()})',
            onPressed: () {
              // Handle filter action
              widget.onFilterApplied?.call(_parameters);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
