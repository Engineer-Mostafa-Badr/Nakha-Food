import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/home/data/models/categories_model.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/home/domain/entities/get_home_utils_params.dart';

abstract class BaseHomeRepository {
  Future<Either<Failure, BaseResponse<HomeModel>>> getHomeUtils(
    GetHomeUtilsParams params,
  );

  Future<Either<Failure, BaseResponse<String>>> generateNewPayLink();

  Future<Either<Failure, BaseResponse<List<CategoriesModel>>>> getCategories(
    NoParameters parameters,
  );
}
