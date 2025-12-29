import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/components/textformfields/custom_dropdown.dart';
import 'package:nakha/core/cubit/app_cubit.dart';

class DistrictDropDown extends StatefulWidget {
  const DistrictDropDown({
    super.key,
    required this.onCitySelected,
    this.initValue,
    this.titleColor,
    this.hintText = 'select_district',
    this.title = 'district',
    this.fillColor,
    this.showAllLocations = false,
    this.titleFontSize = 14,
    required this.cityId,
  });

  final Function(int) onCitySelected;
  final int? cityId;
  final int? initValue;
  final Color? titleColor;
  final Color? fillColor;
  final String hintText;
  final String? title;
  final bool showAllLocations;
  final double titleFontSize;

  @override
  State<DistrictDropDown> createState() => _DistrictDropDownState();
}

class _DistrictDropDownState extends State<DistrictDropDown>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    if (widget.cityId != null) {
      if (MainAppCubit.get(context).regionsModel.isEmpty) {
        MainAppCubit.get(context).getRegions(widget.cityId!).then((value) {
          if (widget.initValue != null) {
            for (final country in MainAppCubit.get(context).regionsModel) {
              if (country.id == widget.initValue) {
                selectedCity = country.name;
                break;
              }
            }
          }
        });
      } else if (widget.initValue != null) {
        for (final country in MainAppCubit.get(context).regionsModel) {
          if (country.id == widget.initValue) {
            selectedCity = country.name;
            break;
          }
        }
      }
    }

    // selectedCity ??= MainAppCubit.get(context).countriesModel.first.name;
  }

  @override
  void didUpdateWidget(covariant DistrictDropDown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.cityId == null || widget.cityId != oldWidget.cityId) {
      selectedCity = null;
      setState(() {
        selectedCity = null;
      });
    }

    if (widget.cityId != null && widget.cityId != oldWidget.cityId) {
      MainAppCubit.get(context).getRegions(widget.cityId!).then((onValue) {
        if (widget.initValue != oldWidget.initValue &&
            widget.initValue != null) {
          for (final city in MainAppCubit.get(context).regionsModel) {
            if (city.id == widget.initValue) {
              setState(() {
                selectedCity = city.name;
              });
              break;
            }
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<MainAppCubit, MainAppCubitState>(
      builder: (context, state) {
        final cities = MainAppCubit.get(context).regionsModel;
        return CustomDropdownMenu(
          title: widget.title,
          titleColor: widget.titleColor,
          titleFontSize: widget.titleFontSize,
          hintText: widget.hintText,
          value: selectedCity,
          fillColor: widget.fillColor,
          items: cities.isEmpty
              ? []
              : [
                  if (widget.showAllLocations) 'all_locations',
                  for (final city in cities) city.name,
                ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'please_select_region'.tr();
            }
            return null;
          },
          onChanged: (value) {
            if (value == 'all_locations') {
              value = null;
              widget.onCitySelected(0);
              return;
            }

            setState(() {
              selectedCity = value;
              final cityId = cities.firstWhere((city) => city.name == value).id;
              widget.onCitySelected(cityId);
            });
          },
        );
      },
    );
  }
}
