import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_sizes.dart';

class CartCounterWidget extends StatefulWidget {
  const CartCounterWidget({
    super.key,
    this.initialQuantity = 1,
    this.onQuantityChanged,
  });

  final int initialQuantity;
  final Function(int)? onQuantityChanged;

  @override
  State<CartCounterWidget> createState() => _CartCounterWidgetState();
}

class _CartCounterWidgetState extends State<CartCounterWidget>
    with AutomaticKeepAliveClientMixin<CartCounterWidget> {
  @override
  bool get wantKeepAlive => true;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
      widget.onQuantityChanged?.call(_quantity);
    });
  }

  void _decrementQuantity() {
    if (_quantity >= 1) {
      setState(() {
        _quantity--;
        widget.onQuantityChanged?.call(_quantity);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.onQuantityChanged != null)
          IconButton(
            icon: const AssetSvgImage(AssetImagesPath.minusSVG),
            onPressed: _decrementQuantity,
          ),
        Text(
          'x $_quantity',
          style: AppStyles.title500.copyWith(
            color: AppColors.grey54Color,
            fontSize: widget.onQuantityChanged != null
                ? AppFontSize.f14
                : AppFontSize.f16,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
        if (widget.onQuantityChanged != null)
          IconButton(
            icon: const AssetSvgImage(AssetImagesPath.addSVG),
            onPressed: _incrementQuantity,
          ),
      ],
    );
  }
}
