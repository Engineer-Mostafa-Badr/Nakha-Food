import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';
import 'package:nakha/features/providers/domain/repositories/base_repo.dart';

class AddProductUseCase
    extends BaseUseCase<BaseResponse<ProductsModel>, AddProductParameters> {
  AddProductUseCase(this.repository);

  final BaseProvidersRepository repository;

  @override
  Future<Either<Failure, BaseResponse<ProductsModel>>> call(
    AddProductParameters parameters,
  ) {
    return repository.addProduct(parameters);
  }
}

class AddProductParameters extends Equatable {
  const AddProductParameters({
    required this.name,
    required this.price,
    required this.description,
    required this.categoryId,
    this.preparationMsg = '',
    required this.image,
    this.images = const [],
    this.productId = 0,
    // this.deliveryAvailable = 0,
  });

  final int productId;

  final String name;
  final String price;
  final String description;
  final int categoryId;

  // final int deliveryAvailable;
  final String preparationMsg;
  final String image;
  final List<String> images;

  Future<Map<String, dynamic>> toJson() async {
    return {
      'name': name,
      'price': price,
      'description': description,
      'category_id': categoryId,
      // 'delivery_available': deliveryAvailable,
      if (preparationMsg.isNotEmpty) 'preparation_msg': preparationMsg,
      if (!image.isLink)
        'image': await MultipartFile.fromFile(
          image,
          filename: image.split('/').last,
        ),
      for (int i = 0; i < images.length; i++)
        'images[$i]': images[i].isLink
            ? images[i]
            : await MultipartFile.fromFile(
                images[i],
                filename: images[i].split('/').last,
              ),
    };
  }

  @override
  List<Object?> get props => [
    name,
    price,
    description,
    categoryId,
    preparationMsg,
    image,
    images,
    productId,
    // deliveryAvailable,
  ];
}
