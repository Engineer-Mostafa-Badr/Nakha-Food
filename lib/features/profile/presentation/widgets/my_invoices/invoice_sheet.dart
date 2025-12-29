import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/most_used_functions.dart';
import 'package:nakha/features/profile/data/models/invoice_model.dart';
import 'package:nakha/features/profile/presentation/widgets/my_invoices/invoice_text_value.dart';
import 'package:nakha/features/profile/presentation/widgets/my_invoices/title_close_bottom_sheet.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InvoiceSheet extends StatelessWidget {
  const InvoiceSheet({super.key, this.invoiceModel});

  final InvoiceModel? invoiceModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.only(
        start: AppPadding.largePadding,
        end: AppPadding.largePadding,
        bottom: AppPadding.largePadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const DragBottomSheetContainer(),
          const TitleCloseBottomSheet(title: 'invoice_details'),
          Text(
            'invoice_details_message',
            textAlign: TextAlign.center,
            style: AppStyles.subtitle500.copyWith(fontSize: AppFontSize.f14),
          ).tr(),
          0.sizedHeight,
          InvoiceTextValue(
            title: 'service_name',
            withRiyalSymbol: false,
            value: invoiceModel?.products.isNotEmpty == true
                ? invoiceModel!.products
                      .map((element) {
                        return element.name;
                      })
                      .join(', ')
                : notSpecified,
          ),
          InvoiceTextValue(
            title: 'invoice_number',
            value: '#${invoiceModel?.id ?? notSpecified}',
            withRiyalSymbol: false,
            icon:
                const AssetSvgImage(
                  AssetImagesPath.fileCopySVG,
                  color: AppColors.cPrimary,
                ).addAction(
                  onTap: () {
                    MostUsedFunctions.copyToClipboardAndShowSnackBarFun(
                      '${invoiceModel?.id ?? ''}',
                    );
                  },
                ),
          ),
          const DashedWidgetReuse(),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'invoice_details',
              style: AppStyles.title700.copyWith(fontSize: AppFontSize.f16),
            ).tr(),
          ),
          InvoiceTextValue(
            title: invoiceModel?.doctorName ?? notSpecified,
            value: invoiceModel?.amount.toStringAsFixed(2) ?? '0.00',
          ),
          // InvoiceTextValue(
          //   title: 'medical_number',
          //   value: invoiceModel?.date ?? notSpecified,
          //   valueTextStyle: AppStyles.title700,
          //   withRiyalSymbol: false,
          // ),
          Row(
            children: [
              Expanded(
                child: InvoiceTextValue(
                  title: 'paid_amount',
                  value: invoiceModel?.paid.toStringAsFixed(2) ?? '0.00',
                  valueTextStyle: AppStyles.title700,
                ),
              ),
              AppPadding.smallPadding.sizedWidth,
              Expanded(
                child: InvoiceTextValue(
                  title: 'remaining_amount',
                  value: invoiceModel?.rest.toStringAsFixed(2) ?? '0.00',
                  valueTextStyle: AppStyles.title700,
                ),
              ),
            ],
          ),
          InvoiceTextValue(
            title: 'invoice_date',
            value: invoiceModel?.date ?? notSpecified,
            valueTextStyle: AppStyles.title600,
            withRiyalSymbol: false,
          ),
          Row(
            children: [
              Expanded(
                child: InvoiceTextValue(
                  title: 'tax',
                  value: invoiceModel?.tax.toStringAsFixed(2) ?? '0.00',
                ),
              ),
              AppPadding.smallPadding.sizedWidth,
              Expanded(
                child: InvoiceTextValue(
                  title: 'discount',
                  value: invoiceModel?.discount.toStringAsFixed(2) ?? '0.00',
                  symbolColor: AppColors.cError,
                  valueTextStyle: AppStyles.title600.copyWith(
                    color: AppColors.cError,
                  ),
                ),
              ),
            ],
          ),
          InvoiceTextValue(
            title: 'invoice_status',
            value: invoiceModel?.status.toLowerCase().tr() ?? notSpecified,
            textStyle: AppStyles.title600,
            valueTextStyle: AppStyles.title700.copyWith(
              color: MostUsedFunctions.statusColor(
                invoiceModel?.status.toLowerCase() ?? notSpecified,
              ),
            ),
            withRiyalSymbol: false,
          ),

          const DashedWidgetReuse(),

          InvoiceTextValue(
            title: 'invoice_total_amount',
            value: invoiceModel?.total.toStringAsFixed(2) ?? '0.00',
            textStyle: AppStyles.title700.copyWith(color: AppColors.cPrimary),
            valueTextStyle: AppStyles.title700.copyWith(
              color: AppColors.cPrimary,
            ),
            symbolColor: AppColors.cPrimary,
          ),

          ReusedRoundedButton(
            text: 'download_invoice',
            onPressed: () {
              if (invoiceModel?.invoiceLink == null ||
                  invoiceModel!.invoiceLink.isEmpty) {
                return;
              }
              MostUsedFunctions.urlLauncherFun(
                launchMode: LaunchMode.inAppBrowserView,
                invoiceModel!.invoiceLink,
              );
            },
          ).addPadding(top: AppPadding.smallPadding),
        ].paddingDirectional(bottom: AppPadding.largePadding),
      ),
    );
  }
}
