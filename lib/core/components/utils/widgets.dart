import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/res/app_images.dart';

// asset svg image ========>>>
class AssetSvgImage extends StatelessWidget {
  const AssetSvgImage(
    this.assetName, {
    super.key,
    this.width,
    this.height,
    this.color,
    this.noColor = false,
  });

  final String assetName;
  final double? width;
  final double? height;
  final Color? color;
  final bool noColor;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      height: height?.h,
      width: width?.w,
      semanticsLabel: assetName,
      colorFilter: noColor
          ? null
          : color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
    );
  }
}

// my app logo ========>>>
class MyAppLogo extends StatelessWidget {
  const MyAppLogo({super.key, this.size = 140.0});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(AssetImagesPath.appLogo, width: size.w, height: size.h);
  }
}

class PullRefreshReuse extends StatelessWidget {
  const PullRefreshReuse({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  final RefreshCallback onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Stack(
        children: [
          ListView(physics: const AlwaysScrollableScrollPhysics()),
          child,
        ],
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;

  const DashedLinePainter({this.color = AppColors.cPrimary});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = .8
      ..strokeCap = StrokeCap
          .round // to make the dashes round
      ..style = PaintingStyle.stroke;

    double startX = 0;
    final double startY = size.height / 2;
    final double endY = size.height / 2;

    const double dashWidth = 4; // dash width
    const double dashSpace = 6; // space between dashes

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, startY),
        Offset(startX + dashWidth, endY),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DashedWidgetReuse extends StatelessWidget {
  const DashedWidgetReuse({super.key, this.color = AppColors.cPrimary});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomPaint(painter: DashedLinePainter(color: color)),
    );
  }
}
