import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/wallet/data/models/wallet_model.dart';
import 'package:nakha/features/wallet/domain/repositories/base_repo.dart';

class GetWalletUseCase
    extends BaseUseCase<BaseResponse<WalletModel>, WalletParameters> {
  GetWalletUseCase(this.repository);

  final BaseWalletRepository repository;

  @override
  Future<Either<Failure, BaseResponse<WalletModel>>> call(
    WalletParameters parameters,
  ) {
    return repository.getWallet(parameters);
  }
}

class WalletParameters extends PaginationParameters {
  const WalletParameters({super.page = 1});

  @override
  Map<String, dynamic> toJson() {
    return {'page': page};
  }

  @override
  WalletParameters copyWith({int page = 1}) {
    return WalletParameters(page: page);
  }

  @override
  List<Object?> get props => [page];
}
