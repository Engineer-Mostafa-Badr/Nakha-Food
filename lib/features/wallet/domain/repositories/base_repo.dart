import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/features/wallet/data/models/wallet_model.dart';
import 'package:nakha/features/wallet/domain/use_cases/get_wallet_usecase.dart';

abstract class BaseWalletRepository {
  Future<Either<Failure, BaseResponse<WalletModel>>> getWallet(
    WalletParameters parameters,
  );
}
