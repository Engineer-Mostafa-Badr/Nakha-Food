import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/buttons/back_button_with_text.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/components/images/cache_image_reuse.dart';
import 'package:nakha/core/components/textformfields/categories_drop_down.dart';
import 'package:nakha/core/components/textformfields/reused_textformfield.dart';
import 'package:nakha/core/components/utils/container_for_bottom_nav_buttons.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/image_utils.dart';
import 'package:nakha/core/utils/validators.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';
import 'package:nakha/features/providers/domain/use_cases/add_product_usecase.dart';
import 'package:nakha/features/providers/presentation/bloc/providers_bloc.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key, this.productModel});

  final ProductsModel? productModel;

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String? _mainImagePath;
  final List<String> _additionalImagePaths = [];
  late final TextEditingController _productNameController;
  late final TextEditingController _productPriceController;
  late final TextEditingController _productDescriptionController;
  late final TextEditingController _productPreparationTimeController;
  late int? _selectedCategoryId;
  late final GlobalKey<FormState> _formKey;

  // late bool _deliveryAvailable;

  void _pickImage() async {
    await sl<ImageUtils>().pickImagesFromGallery().then((images) {
      if (images.isNotEmpty) {
        setState(() {
          _mainImagePath = images.first.path;
        });
      }
    });
  }

  void _pickAdditionalImage() async {
    await sl<ImageUtils>().pickImagesFromGallery(allowMultiple: true).then((
      images,
    ) {
      if (images.isNotEmpty) {
        setState(() {
          for (final image in images) {
            _additionalImagePaths.add(image.path);
          }
        });
      }
    });
  }

  void _removeAdditionalImage(int index) {
    setState(() {
      _additionalImagePaths.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _mainImagePath = widget.productModel?.image;
    _additionalImagePaths.addAll(
      widget.productModel?.images.map((e) => e).toList() ?? [],
    );
    _productNameController = TextEditingController()
      ..text = widget.productModel?.name ?? '';
    _productPriceController = TextEditingController()
      ..text = widget.productModel?.price ?? '';
    _productDescriptionController = TextEditingController()
      ..text = widget.productModel?.description ?? '';
    _productPreparationTimeController = TextEditingController()
      ..text = widget.productModel?.preparationMsg ?? '';
    _selectedCategoryId = widget.productModel?.category.id;
    // _deliveryAvailable =
    //     widget.productModel?.deliveryAvailable != null &&
    //     widget.productModel!.deliveryAvailable == 1;
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productPriceController.dispose();
    _productDescriptionController.dispose();
    _productPreparationTimeController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProvidersBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('add_product').tr(),
          automaticallyImplyLeading: false,
          actions: const [BackButtonLeftIcon()],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(AppPadding.largePadding),
            children: [
              /// images
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 140.w,
                      height: 140.h,
                      decoration: BoxDecoration(
                        color: const Color(0xffE2E2E2),
                        borderRadius: BorderRadius.circular(
                          AppBorderRadius.radius14,
                        ),
                      ),
                    ),
                    Container(
                      width: 120.w,
                      height: 120.h,
                      decoration: BoxDecoration(
                        color: const Color(0xffF3F3F3),
                        borderRadius: BorderRadius.circular(
                          AppBorderRadius.radius14,
                        ),
                      ),
                      child: _mainImagePath != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(
                                AppBorderRadius.radius14,
                              ),
                              child: _mainImagePath!.isLink
                                  ? CacheImageReuse(
                                      imageUrl: _mainImagePath,
                                      imageBuilder: (context, imageProvider) =>
                                          Image(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                    )
                                  : Image.file(
                                      File(_mainImagePath!),
                                      fit: BoxFit.cover,
                                    ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox.shrink(),
                                const AssetSvgImage(AssetImagesPath.add2SVG),
                                Text(
                                  'main_image',
                                  style: AppStyles.title700.copyWith(
                                    fontSize: AppFontSize.f12,
                                  ),
                                ).tr(),
                              ],
                            ),
                    ).addAction(borderRadius: 14, onTap: _pickImage),
                  ],
                ),
              ),
              AppPadding.largePadding.sizedHeight,

              /// additional images
              Row(
                children: [
                  Container(
                    width: 72.w,
                    height: 72.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffD8D8D8),
                      borderRadius: BorderRadius.circular(
                        AppBorderRadius.radius16,
                      ),
                      border: Border.all(
                        color: const Color(0xffA6A6A6),
                        width: 1.2,
                      ),
                    ),
                    child: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: AssetSvgImage(
                        AssetImagesPath.add2SVG,
                        color: AppColors.grey54Color,
                      ),
                    ),
                  ).addAction(borderRadius: 14, onTap: _pickAdditionalImage),

                  AppPadding.smallPadding.sizedWidth,
                  Expanded(
                    child: SizedBox(
                      height: 72.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _additionalImagePaths.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 72.w,
                            height: 72.h,
                            margin: EdgeInsets.only(
                              right: AppPadding.smallPadding.w,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppBorderRadius.radius16,
                              ),
                              border: Border.all(
                                color: const Color(0xffEFEEEA),
                              ),
                              image: DecorationImage(
                                image: _additionalImagePaths[index].isLink
                                    ? NetworkImage(_additionalImagePaths[index])
                                    : FileImage(
                                        File(_additionalImagePaths[index]),
                                      ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            padding: const EdgeInsets.all(
                              AppPadding.smallPadding,
                            ),
                            alignment: AlignmentDirectional.topEnd,
                            child:
                                const FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: AssetSvgImage(
                                    AssetImagesPath.deleteImageSVG,
                                  ),
                                ).addAction(
                                  borderRadius: 16,
                                  onTap: () => _removeAdditionalImage(index),
                                ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),

              AppPadding.largePadding.sizedHeight,

              /// delivery available
              // SwitchListTile.adaptive(
              //   title: const Text('delivery_available').tr(),
              //   value: _deliveryAvailable,
              //   contentPadding: EdgeInsets.zero,
              //   materialTapTargetSize: MaterialTapTargetSize.padded,
              //   trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
              //   // activeTrackColor: AppColors.cFillBorderLight,
              //   inactiveTrackColor: AppColors.cFillBorderLight,
              //   inactiveThumbColor: Colors.white,
              //   thumbIcon: WidgetStateProperty.all(
              //     const Icon(Icons.check, color: Colors.transparent),
              //   ),
              //   activeColor: AppColors.cSuccess,
              //   onChanged: (value) {
              //     setState(() {
              //       _deliveryAvailable = value;
              //     });
              //   },
              // ),

              ///
              ReusedTextFormField(
                controller: _productNameController,
                title: 'product_name',
                hintText: 'product_name_hint',
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validator: Validators.validateName,
              ),
              AppPadding.largePadding.sizedHeight,
              CategoriesDropDown(
                title: 'product_category',
                hintText: 'product_category_hint',
                initValue: _selectedCategoryId,
                onCategoriesSelected: (categoryId) {
                  _selectedCategoryId = categoryId;
                },
              ),
              AppPadding.largePadding.sizedHeight,
              ReusedTextFormField(
                controller: _productPriceController,
                title: 'product_price',
                hintText: 'product_price_hint',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: Validators.requiredField,
              ),
              AppPadding.largePadding.sizedHeight,
              ReusedTextFormField(
                controller: _productPreparationTimeController,
                title: 'product_preparation_time',
                hintText: 'product_preparation_time_hint',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                validator: Validators.requiredField,
              ),
              AppPadding.largePadding.sizedHeight,
              ReusedTextFormField(
                controller: _productDescriptionController,
                title: 'product_description',
                hintText: 'product_description_hint',
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 3,
                maxLines: 5,
                validator: Validators.requiredField,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BlocConsumer<ProvidersBloc, ProvidersState>(
          buildWhen: (previous, current) =>
              previous.addProductState != current.addProductState ||
              previous.updateProductState != current.updateProductState,
          listener: (context, state) {
            if (state.addProductState.isLoaded) {
              state.addProductResponse.msg!.showTopSuccessToast;
              Navigator.pop(context, true);
            } else if (state.addProductState.isError) {
              state.addProductResponse.msg!.showTopErrorToast;
            }

            if (state.updateProductState.isLoaded) {
              state.updateProductResponse.msg!.showTopSuccessToast;
              Navigator.pop(context, true);
            } else if (state.updateProductState.isError) {
              state.updateProductResponse.msg!.showTopErrorToast;
            }
          },
          builder: (context, state) {
            return ContainerForBottomNavButtons(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: ReusedRoundedButton(
                  radius: 21,
                  width: 275,
                  isLoading:
                      state.addProductState.isLoading ||
                      state.updateProductState.isLoading,
                  text: widget.productModel != null
                      ? 'update_product'
                      : 'add_new_product',
                  onPressed: () {
                    if (_mainImagePath == null) {
                      'please_select_main_image'.showTopInfoToast;
                    }

                    if (_additionalImagePaths.isEmpty) {
                      'please_select_additional_images'.showTopInfoToast;
                    }

                    if (!_formKey.currentState!.validate() ||
                        _mainImagePath == null ||
                        _additionalImagePaths.isEmpty) {
                      return;
                    }
                    final productParams = AddProductParameters(
                      name: _productNameController.text,
                      price: _productPriceController.text,
                      image: _mainImagePath!,
                      images: _additionalImagePaths,
                      description: _productDescriptionController.text,
                      preparationMsg: _productPreparationTimeController.text,
                      categoryId: _selectedCategoryId!,
                      productId: widget.productModel?.id ?? 0,
                      // deliveryAvailable: _deliveryAvailable ? 1 : 0,
                    );
                    ProvidersBloc.get(context).add(
                      widget.productModel != null
                          ? UpdateProductEvent(productParams)
                          : AddProductEvent(productParams),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
