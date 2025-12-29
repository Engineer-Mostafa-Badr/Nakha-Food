import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/home/domain/entities/get_home_utils_params.dart';
import 'package:nakha/features/home/domain/repositories/base_home_repo.dart';

class GetHomeUtilsUseCase
    extends BaseUseCase<BaseResponse<HomeModel>, GetHomeUtilsParams> {
  final BaseHomeRepository repository;

  GetHomeUtilsUseCase(this.repository);

  @override
  Future<Either<Failure, BaseResponse<HomeModel>>> call(
    GetHomeUtilsParams parameters,
  ) {
    return repository.getHomeUtils(parameters);
  }
}
