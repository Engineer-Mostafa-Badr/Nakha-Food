import 'package:nakha/core/api/dio/api_consumer.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/dio/end_points.dart';
import 'package:nakha/core/api/dio/status_code.dart';
import 'package:nakha/core/api/error/exceptions.dart';
import 'package:nakha/features/wallet/data/models/wallet_model.dart';
import 'package:nakha/features/wallet/domain/use_cases/get_wallet_usecase.dart';

abstract class BaseWalletRemoteDataSource {
  Future<BaseResponse<WalletModel>> getWallet(WalletParameters parameters);
}

class WalletRemoteDataSource extends BaseWalletRemoteDataSource {
  final ApiConsumer _apiConsumer;

  WalletRemoteDataSource(this._apiConsumer);

  @override
  Future<BaseResponse<WalletModel>> getWallet(
    WalletParameters parameters,
  ) async {
    final response = await _apiConsumer.get(
      EndPoints.wallet,
      authenticated: true,
      queryParameters: parameters.toJson(),
    );

    if (StatusCode.isSuccessful(response)) {
      return BaseResponse<WalletModel>(
        status: response.data[BaseResponse.statusKey],
        data: WalletModel.fromJson(response.data[BaseResponse.dataKey]),
        pagination: PaginationModel.fromJson(
          response.data[BaseResponse.paginationKey],
        ),
        msg: response.data[BaseResponse.msgKey],
      );
    } else {
      throw ServerException(message: StatusCode.errorMessage(response));
    }
  }
}
