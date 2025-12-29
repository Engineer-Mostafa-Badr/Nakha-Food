import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/home/presentation/widgets/vendor_home/vendor_home_container.dart';

class OrderServices extends StatelessWidget {
  const OrderServices({super.key, this.vendorDataModel});

  final VendorDataModel? vendorDataModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        VendorHomeContainer(
          assetName: AssetImagesPath.allOrders,
          value: '${vendorDataModel!.allOrdersAmount} ${'r.s'.tr()}',
          title: 'all_orders_without_count',
          containerColor: const Color(0xffFFF4DE),
        ),
        VendorHomeContainer(
          assetName: AssetImagesPath.acceptedOrders,
          value: '${vendorDataModel!.approvedOrdersCount}',
          title: 'accepted_orders_without_count',
          containerColor: const Color(0xffDCFCE7),
        ),
        VendorHomeContainer(
          assetName: AssetImagesPath.newOrders,
          value: '${vendorDataModel!.pendingOrdersAmount} ${'r.s'.tr()}',
          title: 'new_orders',
          containerColor: const Color(0xffF3E8FF),
        ),
        VendorHomeContainer(
          assetName: AssetImagesPath.cancelledOrders,
          value: '${vendorDataModel!.cancelledOrdersCount}',
          title: 'cancelled_orders_without_count',
          containerColor: const Color(0xffFFE2E5),
        ),
      ],
    );
  }
}
