import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/components/images/cache_image_reuse.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';

class ProductDetailsSlider extends StatefulWidget {
  const ProductDetailsSlider({
    super.key,
    this.items = const [],
    this.isLoading = false,
  });

  final bool isLoading;
  final List<SlidersModel> items;

  @override
  State<ProductDetailsSlider> createState() => _ProductDetailsSliderState();
}

class _ProductDetailsSliderState extends State<ProductDetailsSlider> {
  late int _current;

  late final CarouselSliderController _carouselController;

  void changeCurrentIndex(int index) {
    if (_current == index) return;
    setState(() {
      _current = index;
      _carouselController.animateToPage(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _current = 0;
    _carouselController = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    return widget.items.isEmpty
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider.builder(
                carouselController: _carouselController,
                options: CarouselOptions(
                  viewportFraction: 1,
                  // autoPlay: widget.items.length > 1,
                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  padEnds: false,
                  enableInfiniteScroll: widget.items.length > 1,
                  onPageChanged: (index, reason) {
                    changeCurrentIndex(index);
                  },
                ),
                itemCount: widget.items.length,
                itemBuilder: (context, index, realIndex) {
                  return CacheImageReuse(
                    imageUrl: widget.items[index].cover,
                    loadingHeight: 316,
                    imageBuilder: (context, image) {
                      return Image(
                        image: image,
                        width: double.infinity,
                        height: 316.h,
                        fit: BoxFit.cover,
                      );
                    },
                  );
                },
              ),
              AppPadding.mediumPadding.sizedHeight,
              SizedBox(
                height: 86.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.items.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.mediumPadding,
                  ),
                  separatorBuilder: (context, index) =>
                      AppPadding.mediumPadding.sizedWidth,
                  itemBuilder: (context, index) {
                    final slider = widget.items[index];
                    return Container(
                      width: 86.w,
                      height: 86.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: _current == index ? 1.4 : 1,
                          color: _current == index
                              ? AppColors.cPrimary
                              : const Color(0xffEFEEEA),
                        ),
                        borderRadius: BorderRadius.circular(
                          AppBorderRadius.mediumRadius,
                        ),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(slider.cover),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ).addAction(
                      borderRadius: 16,
                      onTap: () {
                        changeCurrentIndex(index);
                      },
                    );
                  },
                ),
              ),
            ],
          );
  }
}
