import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/exceptions.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/features/wallet/data/data_sources/remote/remote_data_source.dart';
import 'package:nakha/features/wallet/data/models/wallet_model.dart';
import 'package:nakha/features/wallet/domain/repositories/base_repo.dart';
import 'package:nakha/features/wallet/domain/use_cases/get_wallet_usecase.dart';

class WalletRepositoryImpl implements BaseWalletRepository {
  WalletRepositoryImpl(this.remoteDataSource);

  final WalletRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, BaseResponse<WalletModel>>> getWallet(
    WalletParameters parameters,
  ) async {
    try {
      final response = await remoteDataSource.getWallet(parameters);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
