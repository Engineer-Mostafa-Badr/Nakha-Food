import 'package:equatable/equatable.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/most_used_functions.dart';

// Position? _currentPosition;

class GetHomeUtilsParams extends Equatable {
  const GetHomeUtilsParams({this.subscriptionId});

  final int? subscriptionId;

  Future<Map<String, dynamic>> toJson() async {
    // _currentPosition ??= await sl<CheckAppPermissions>().getCurrentLocation();
    return {
      if (AppConst.fcmToken.isNotEmpty) 'device_token': AppConst.fcmToken,
      'device_id': await MostUsedFunctions.getDeviceId(),
      if (subscriptionId != null) 'subscription_id': subscriptionId,
      // if (_currentPosition != null) 'longitude': _currentPosition!.longitude,
      // if (_currentPosition != null) 'latitude': _currentPosition!.latitude,
    };
  }

  @override
  List<Object?> get props => [subscriptionId];
}
