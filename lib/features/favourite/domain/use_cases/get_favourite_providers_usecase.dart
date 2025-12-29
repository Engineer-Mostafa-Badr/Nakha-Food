import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/favourite/domain/repositories/base_repo.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';

class GetFavouriteProvidersUseCase
    extends
        BaseUseCase<
          BaseResponse<List<ProvidersModel>>,
          FavouriteProvidersParameters
        > {
  GetFavouriteProvidersUseCase(this.repository);

  final BaseFavouriteRepository repository;

  @override
  Future<Either<Failure, BaseResponse<List<ProvidersModel>>>> call(
    FavouriteProvidersParameters parameters,
  ) {
    return repository.getFavouriteProviders(parameters);
  }
}

class FavouriteProvidersParameters extends PaginationParameters {
  const FavouriteProvidersParameters({super.page = 1});

  @override
  Map<String, dynamic> toJson() {
    return {'page': page};
  }

  @override
  FavouriteProvidersParameters copyWith({int page = 1}) {
    return FavouriteProvidersParameters(page: page);
  }

  @override
  List<Object?> get props => [page];
}
