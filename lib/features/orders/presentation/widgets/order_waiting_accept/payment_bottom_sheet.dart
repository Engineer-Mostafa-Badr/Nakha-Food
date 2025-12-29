import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/orders/data/models/orders_model.dart';
import 'package:nakha/features/orders/presentation/widgets/cart/total_price_list_tile.dart';
import 'package:nakha/features/orders/presentation/widgets/order_waiting_accept/payment_row_text_value.dart';

class PaymentBottomSheet extends StatelessWidget {
  const PaymentBottomSheet({
    super.key,
    required this.ordersModel,
    required this.onPay,
  });

  final OrdersModel ordersModel;
  final Function() onPay;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppPadding.largePadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppPadding.mediumPadding,
        children: [
          AppPadding.mediumPadding.sizedHeight,
          PaymentRowTextValue(text: 'total', value: ordersModel.subtotal),
          PaymentRowTextValue(text: 'tax', value: ordersModel.tax),
          TotalPriceListTile(price: ordersModel.totalPrice),
          20.sizedHeight,
          ReusedRoundedButton(
            text: 'pay_details_button'.tr(
              namedArgs: {'price': ordersModel.totalPrice},
            ),
            color: AppColors.cSuccess,
            onPressed: () {
              // Handle payment action
              onPay();
              Navigator.pop(context); // Close the bottom sheet
            },
          ),
        ],
      ),
    );
  }
}
