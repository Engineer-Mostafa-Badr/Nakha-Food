import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/components/appbar/shared_app_bar.dart';
import 'package:nakha/core/components/images/cache_image_reuse.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PhotoImageViewer extends StatelessWidget {
  const PhotoImageViewer({super.key, required this.assetName});

  final String assetName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SharedAppBar(title: ''),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: InteractiveViewer(
          maxScale: 10.0,
          child: CacheImageReuse(
            imageUrl: assetName,
            imageBuilder: (context, imageProvider) =>
                Image(image: imageProvider),
          ),
        ),
      ),
    );
  }
}

class PhotoImageViewerForGroup extends StatefulWidget {
  const PhotoImageViewerForGroup({
    super.key,
    this.groupOfImages = const [],
    this.firstImageIndex,
  });

  final List<String> groupOfImages;
  final int? firstImageIndex;

  @override
  State<PhotoImageViewerForGroup> createState() =>
      _PhotoImageViewerForGroupState();
}

class _PhotoImageViewerForGroupState extends State<PhotoImageViewerForGroup> {
  int currentIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.firstImageIndex ?? 0;
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SharedAppBar(title: ''),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            itemCount: widget.groupOfImages.length,
            controller: PageController(
              initialPage: widget.firstImageIndex ?? 0,
            ),
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) => SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: InteractiveViewer(
                maxScale: 10.0,
                child: CacheImageReuse(
                  imageUrl: widget.groupOfImages[index],
                  imageBuilder: (context, imageProvider) =>
                      Image(image: imageProvider),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 20),
            child: AnimatedSmoothIndicator(
              activeIndex: currentIndex,
              count: widget.groupOfImages.length,
              effect: ExpandingDotsEffect(
                dotWidth: 10,
                dotHeight: 8,
                activeDotColor: AppColors.cPrimary,
                dotColor: AppColors.cPrimary.withValues(alpha: 0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
