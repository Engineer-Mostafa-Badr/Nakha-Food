import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class RatingBarReuse extends StatelessWidget {
  const RatingBarReuse({
    super.key,
    required this.rating,
    this.onRatingUpdate,
    this.itemPadding = AppPadding.padding4,
    this.size = 18,
    this.itemCount = 5,
    this.color = AppColors.cRate,
  });

  final double rating;
  final double size;
  final double itemPadding;
  final ValueChanged<double>? onRatingUpdate;
  final int itemCount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: rating,
      allowHalfRating: true,
      itemSize: size.sp,
      minRating: .5,
      glowColor: AppColors.cRate,
      textDirection: TextDirection.ltr,
      itemCount: itemCount,
      itemPadding: EdgeInsets.symmetric(horizontal: itemPadding),
      itemBuilder: (context, index) =>
          AssetSvgImage(AssetImagesPath.starSVG, color: color),
      unratedColor: color.withValues(alpha: .5),
      onRatingUpdate: onRatingUpdate ?? (double value) {},
      ignoreGestures: onRatingUpdate == null,
    );
  }
}

class RatingBarWithScore extends StatelessWidget {
  const RatingBarWithScore({
    super.key,
    required this.rating,
    required this.score,
    this.scoreTextStyle,
    this.size = 18,
    this.showRating = true,
    this.itemCount = 5,
  });

  final double rating;
  final String score;
  final int itemCount;
  final TextStyle? scoreTextStyle;
  final double size;
  final bool showRating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showRating) ...[
          RatingBarReuse(rating: rating, size: size, itemCount: itemCount),
          AppPadding.padding4.sizedWidth,
        ],
        Text(
          score,
          style:
              scoreTextStyle ??
              AppStyles.title500.copyWith(fontSize: AppFontSize.f16),
        ),
      ],
    );
  }
}

class RatingOneStarScore extends StatelessWidget {
  const RatingOneStarScore({super.key, required this.avgRates});

  final double avgRates;

  @override
  Widget build(BuildContext context) {
    return RatingBarWithScore(
      itemCount: 1,
      rating: avgRates >= 3
          ? avgRates
          : avgRates == 0
          ? 0
          : .5,
      score: avgRates.toStringAsFixed(1),
    );
  }
}
