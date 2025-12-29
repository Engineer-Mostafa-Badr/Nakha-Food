import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.fillRemaining});

  final bool? fillRemaining;

  @override
  Widget build(BuildContext context) {
    if (fillRemaining != null) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: SizedBox(
            width: 25.r,
            height: 25.r,
            child: const CircularProgressIndicator.adaptive(),
          ),
        ),
      );
    }
    return Center(
      child: SizedBox(
        width: 25.r,
        height: 25.r,
        child: const CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
