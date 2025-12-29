import 'package:nakha/core/components/textformfields/custom_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:nakha/core/cubit/app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class CategoriesDropDown extends StatefulWidget {
  const CategoriesDropDown({
    super.key,
    required this.onCategoriesSelected,
    this.initValue,
    this.titleColor,
    this.hintText = 'select_category',
    this.title = 'category',
    this.fillColor,
    this.titleFontSize = 14,
  });

  final Function(int) onCategoriesSelected;
  final int? initValue;
  final Color? titleColor;
  final Color? fillColor;
  final String hintText;
  final String? title;

  // final bool showAllLocations;
  final double titleFontSize;

  @override
  State<CategoriesDropDown> createState() => _CategoriesDropDownState();
}

class _CategoriesDropDownState extends State<CategoriesDropDown>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String? selectedCategories;

  @override
  void initState() {
    super.initState();
    if (MainAppCubit.get(context).categoriesModel.isEmpty) {
      MainAppCubit.get(context).getCategories().then((value) {
        if (widget.initValue != null) {
          for (final category in MainAppCubit.get(context).categoriesModel) {
            if (category.id == widget.initValue) {
              selectedCategories = category.name;
              break;
            }
          }
        }
      });
    } else {
      if (widget.initValue != null) {
        for (final category in MainAppCubit.get(context).categoriesModel) {
          if (category.id == widget.initValue) {
            selectedCategories = category.name;
            break;
          }
        }
      }
    }
    // selectedCategories ??= MainAppCubit.get(context).categoriesModel.first.name;
  }

  @override
  void didUpdateWidget(covariant CategoriesDropDown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initValue != oldWidget.initValue && widget.initValue != null) {
      for (final category in MainAppCubit.get(context).categoriesModel) {
        if (category.id == widget.initValue) {
          selectedCategories = category.name;
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
        final cities = MainAppCubit.get(context).categoriesModel;
        return CustomDropdownMenu(
          title: widget.title,
          titleColor: widget.titleColor,
          titleFontSize: widget.titleFontSize,
          hintText: widget.hintText,
          value: selectedCategories,
          fillColor: widget.fillColor,
          // border: widget.border,
          validator: (selectedCategories) {
            if (selectedCategories == null || selectedCategories.isEmpty) {
              return 'please_select_category'.tr();
            }
            return null;
          },
          items: [for (final category in cities) category.name],
          onChanged: (value) {
            setState(() {
              selectedCategories = value;
              final categoryId = cities
                  .firstWhere((category) => category.name == value)
                  .id;
              widget.onCategoriesSelected(categoryId);
            });
          },
        );
      },
    );
  }
}
