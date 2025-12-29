import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class SelectTimeCalendarReuse extends StatelessWidget {
  const SelectTimeCalendarReuse({
    super.key,
    this.initDate,
    required this.onDateSelected,
    this.height = 330,
  });

  final String? initDate;
  final Function(String)? onDateSelected;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      padding: const EdgeInsets.symmetric(
        vertical: AppPadding.smallPadding,
        horizontal: AppPadding.smallPadding,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppBorderRadius.radius8),
        boxShadow: AppStyles.mostUsedBoxShadow,
      ),
      child: Stack(
        children: [
          Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColors.cFillTextFieldLight.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(AppBorderRadius.radius12),
            ),
          ),
          CalendarDatePicker2(
            config: CalendarDatePicker2Config(
              lastMonthIcon: const AssetSvgImage(AssetImagesPath.lastMonthSVG),
              nextMonthIcon: const AssetSvgImage(AssetImagesPath.nextMonthSVG),
              customModePickerIcon: const SizedBox.shrink(),
              firstDate: DateTime.now().add(const Duration(days: 1)),
              modePickerBuilder:
                  ({required monthDate, isMonthPicker, required viewMode}) {
                    return isMonthPicker == null || isMonthPicker == false
                        ? const SizedBox.shrink()
                        : Center(
                            child: Text(
                              DateFormat(
                                'MMMM yyyy',
                                context.locale.languageCode,
                              ).format(monthDate).toEnglishNumbers,
                              style: AppStyles.title500.copyWith(
                                fontSize: AppFontSize.f16,
                                color: const Color(0xFF454140),
                              ),
                            ),
                          );
                  },
              weekdayLabelTextStyle: AppStyles.subtitle500.copyWith(
                fontSize: AppFontSize.f11,
                color: const Color(0xFF8F8988),
              ),
              weekdayLabelBuilder:
                  ({bool? isScrollViewTopHeader, required int weekday}) {
                    return FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        [
                          'sunday',
                          'monday',
                          'tuesday',
                          'wednesday',
                          'thursday',
                          'friday',
                          'saturday',
                        ][weekday],
                        style: AppStyles.subtitle500.copyWith(
                          fontSize: AppFontSize.f11,
                          color: const Color(0xFF8F8988),
                        ),
                      ).tr(),
                    );
                  },
              dayTextStyle: AppStyles.title500.copyWith(
                fontSize: AppFontSize.f13,
              ),
            ),
            value: [
              if (initDate != null)
                AppConst.mostUsedDateFormat.parse(initDate!)
              else
                // DateTime.now(),
                DateTime.now().add(const Duration(days: 1)),
            ],
            onValueChanged: (dates) {
              if (onDateSelected == null) return;
              onDateSelected!.call(
                AppConst.mostUsedDateFormat.format(dates.first),
              );
            },
          ),
          if (onDateSelected == null)
            Container(height: height.h, color: Colors.transparent),
        ],
      ),
    );
  }
}
