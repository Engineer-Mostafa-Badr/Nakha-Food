import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/buttons/outlined_button.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/most_used_functions.dart';
import 'package:nakha/features/profile/data/models/invoice_model.dart';
import 'package:nakha/features/profile/presentation/widgets/my_invoices/invoice_sheet.dart';
import 'package:nakha/features/profile/presentation/widgets/my_invoices/invoice_text_value.dart';

class MyInvoicesItem extends StatelessWidget {
  const MyInvoicesItem({super.key, required this.invoiceModel});

  final InvoiceModel? invoiceModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.largePadding),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F4F9),
        borderRadius: BorderRadius.circular(AppBorderRadius.radius20),
        border: const BorderDirectional(
          top: BorderSide(color: AppColors.cSecondary),
          start: BorderSide(color: AppColors.cSecondary),
          end: BorderSide(color: AppColors.cSecondary),
          bottom: BorderSide(color: AppColors.cSecondary, width: 5),
        ),
      ),
      child: Column(
        children: [
          Text(
            invoiceModel?.doctorName ?? notSpecified,
            textAlign: TextAlign.center,
            style: AppStyles.title700,
          ).tr(),
          AppPadding.padding24.sizedHeight,
          InvoiceTextValue(
            title: 'date',
            value: invoiceModel?.date ?? notSpecified,
            valueTextStyle: AppStyles.title700,
            withRiyalSymbol: false,
          ),
          AppPadding.padding12.sizedHeight,
          InvoiceTextValue(
            title: 'status',
            value: invoiceModel?.status.toLowerCase().tr() ?? notSpecified,
            valueTextStyle: AppStyles.title700.copyWith(
              color: MostUsedFunctions.statusColor(
                invoiceModel?.status.toLowerCase() ?? notSpecified,
              ),
            ),
            withRiyalSymbol: false,
          ),
          AppPadding.padding12.sizedHeight,
          InvoiceTextValue(
            title: 'price',
            value: '${invoiceModel?.total ?? 0}',
            valueTextStyle: AppStyles.title700,
          ),
          AppPadding.mediumPadding.sizedHeight,
          const DashedWidgetReuse(),
          AppPadding.mediumPadding.sizedHeight,
          ReusedOutlinedButton(
            text: 'show_invoice_details',
            onPressed: () {
              if (invoiceModel == null) return;
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) {
                  return InvoiceSheet(invoiceModel: invoiceModel);
                },
              );
            },
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
