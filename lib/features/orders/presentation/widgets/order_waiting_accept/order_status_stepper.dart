import 'package:easy_localization/easy_localization.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';

class OrderStatusStepper extends StatelessWidget {
  final int activeStep;

  const OrderStatusStepper({super.key, required this.activeStep});

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: activeStep,
      stepRadius: 24,
      lineStyle: LineStyle(
        lineThickness: 2,
        lineSpace: 0,
        activeLineColor: AppColors.cSuccess,
        finishedLineColor: AppColors.cSuccess,
        unreachedLineColor: const Color(0xffF7F5ED),
        lineType: LineType.normal,
        lineLength: 70.w,
      ),
      activeStepBorderColor: AppColors.cSuccess,
      activeStepBorderType: BorderType.normal,
      activeStepIconColor: AppColors.cSuccess,
      activeStepTextColor: AppColors.cSuccess,
      defaultStepBorderType: BorderType.normal,
      unreachedStepBorderType: BorderType.normal,
      finishedStepBorderType: BorderType.normal,
      finishedStepBorderColor: AppColors.cSuccess,
      finishedStepIconColor: AppColors.cSuccess,
      finishedStepTextColor: AppColors.cSuccess,
      finishedStepBackgroundColor: Colors.white,

      borderThickness: 2,
      unreachedStepBackgroundColor: const Color(0xffF6F5F5),
      unreachedStepBorderColor: const Color(0xffF7F5ED),
      showLoadingAnimation: false,
      steps: [
        EasyStep(
          finishIcon: const Icon(Icons.check_circle, color: AppColors.cSuccess),
          icon: const Icon(Icons.check, color: Colors.white, size: 12),
          customTitle: Text(
            'pay_done',
            textAlign: TextAlign.center,
            style: AppStyles.title700.copyWith(color: AppColors.cSuccess),
          ).tr(),
          activeIcon: const Icon(Icons.check_circle, color: AppColors.cSuccess),
          // topTitle: true,
        ),
        EasyStep(
          finishIcon: const Icon(Icons.check_circle, color: AppColors.cSuccess),
          icon: Icon(
            Icons.hourglass_empty,
            color: Colors.grey.shade500,
            size: 12,
          ),
          customTitle: Text(
            'order_processing',
            textAlign: TextAlign.center,
            style: AppStyles.title700.copyWith(color: Colors.grey.shade500),
          ).tr(),
          activeIcon: const Icon(Icons.check_circle, color: AppColors.cSuccess),
          // topTitle: true,
        ),
        EasyStep(
          finishIcon: const Icon(Icons.check_circle, color: AppColors.cSuccess),
          icon: Icon(
            Icons.shopping_basket,
            color: Colors.grey.shade500,
            size: 12,
          ),
          customTitle: Text(
            'delivered',
            textAlign: TextAlign.center,
            style: AppStyles.title700.copyWith(color: Colors.grey.shade500),
          ).tr(),
          activeIcon: const Icon(Icons.check_circle, color: AppColors.cSuccess),
          // topTitle: true,
        ),
      ],
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: const [
          OrderStatusStepper(
            activeStep: 0, // Change this value to test different steps
          ),
        ],
      ),
    );
  }
}
