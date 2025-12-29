import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/components/screen_status/empty_widget.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/home/presentation/widgets/vendor_home/new_orders_item_widget.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/orders/data/models/orders_model.dart';
import 'package:nakha/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewOrderSlider extends StatefulWidget {
  const NewOrderSlider({
    super.key,
    this.items = const [],
    this.isLoading = false,
  });

  final bool isLoading;
  final List<OrdersModel> items;

  @override
  State<NewOrderSlider> createState() => _NewOrderSliderState();
}

class _NewOrderSliderState extends State<NewOrderSlider> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return widget.items.isEmpty
        ? const EmptyBody(text: 'no_new_orders_available')
        : BlocProvider(
            create: (context) => sl<OrdersBloc>(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider.builder(
                  options: CarouselOptions(
                    // aspectRatio: 344 / 180,
                    viewportFraction: 1,
                    autoPlay: widget.items.length > 1,
                    enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                    padEnds: false,
                    scrollPhysics: widget.items.length > 1
                        ? const AlwaysScrollableScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                  itemCount: widget.items.length,
                  itemBuilder: (context, index, realIndex) {
                    return NewOrderVendorItem(
                      ordersModel: widget.items[index],
                    ).addPadding(horizontal: AppPadding.mediumPadding);
                  },
                ),
                if (widget.items.length > 1) ...[
                  AppPadding.padding12.sizedHeight,
                  AnimatedSmoothIndicator(
                    activeIndex: _current,
                    count: widget.items.length,
                    effect: WormEffect(
                      dotWidth: 8.w,
                      dotHeight: 8.h,
                      activeDotColor: AppColors.cPrimary,
                      dotColor: AppColors.cTextSubtitleLight.withValues(
                        alpha: 0.2,
                      ),
                    ),
                  ).addPadding(bottom: AppPadding.smallPadding),
                ],
              ],
            ),
          );
  }
}
