import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/providers/data/models/vendor_profile_model.dart';
import 'package:nakha/features/providers/domain/repositories/base_repo.dart';

class GetProviderProfileUseCase
    extends
        BaseUseCase<
          BaseResponse<ProviderProfileModel>,
          ProviderProfileParameters
        > {
  GetProviderProfileUseCase(this.repository);

  final BaseProvidersRepository repository;

  @override
  Future<Either<Failure, BaseResponse<ProviderProfileModel>>> call(
    ProviderProfileParameters parameters,
  ) {
    return repository.getProviderProfile(parameters);
  }
}

class ProviderProfileParameters extends Equatable {
  const ProviderProfileParameters({required this.providerId});

  final int providerId;

  Map<String, dynamic> toJson() {
    return {'vendor_id': providerId};
  }

  @override
  List<Object?> get props => [providerId];
}
