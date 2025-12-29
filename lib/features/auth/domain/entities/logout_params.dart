import 'package:equatable/equatable.dart';
import 'package:nakha/core/utils/most_used_functions.dart';

class LogoutParameters extends Equatable {
  const LogoutParameters();

  Future<Map<String, dynamic>> toJson() async {
    return {'device_id': await MostUsedFunctions.getDeviceId()};
  }

  @override
  List<Object?> get props => [];
}
