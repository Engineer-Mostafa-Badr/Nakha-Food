import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/components/textformfields/custom_dropdown.dart';
import 'package:nakha/core/cubit/app_cubit.dart';

class CityDropDown extends StatefulWidget {
  const CityDropDown({
    super.key,
    required this.onCitySelected,
    this.initValue,
    this.titleColor,
    this.hintText = 'select_city',
    this.title = 'city',
    this.fillColor,
    this.showAllLocations = false,
    this.titleFontSize = 14,
  });

  final Function(int) onCitySelected;
  final int? initValue;
  final Color? titleColor;
  final Color? fillColor;
  final String hintText;
  final String? title;
  final bool showAllLocations;
  final double titleFontSize;

  @override
  State<CityDropDown> createState() => _CityDropDownState();
}

class _CityDropDownState extends State<CityDropDown>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    if (MainAppCubit.get(context).citiesModel.isEmpty) {
      MainAppCubit.get(context).getCities().then((value) {
        if (widget.initValue != null) {
          for (final city in MainAppCubit.get(context).citiesModel) {
            if (city.id == widget.initValue) {
              selectedCity = city.name;
              break;
            }
          }
        }
      });
    } else {
      if (widget.initValue != null) {
        for (final city in MainAppCubit.get(context).citiesModel) {
          if (city.id == widget.initValue) {
            selectedCity = city.name;
            break;
          }
        }
      }
    }
    // selectedCity ??= MainAppCubit.get(context).citiesModel.first.name;
  }

  @override
  void didUpdateWidget(covariant CityDropDown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initValue != oldWidget.initValue && widget.initValue != null) {
      for (final city in MainAppCubit.get(context).citiesModel) {
        if (city.id == widget.initValue) {
          selectedCity = city.name;
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<MainAppCubit, MainAppCubitState>(
      builder: (context, state) {
        final cities = MainAppCubit.get(context).citiesModel;
        return CustomDropdownMenu(
          title: widget.title,
          titleColor: widget.titleColor,
          titleFontSize: widget.titleFontSize,
          hintText: widget.hintText,
          value: selectedCity,
          fillColor: widget.fillColor,
          // border: widget.border,
          validator: (selectedCity) {
            if (selectedCity == null || selectedCity.isEmpty) {
              return 'please_select_city'.tr();
            }
            return null;
          },
          items: [
            if (widget.showAllLocations) 'all_locations',
            for (final city in cities) city.name,
          ],
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
