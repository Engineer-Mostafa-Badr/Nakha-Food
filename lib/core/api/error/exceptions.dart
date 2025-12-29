import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String? message;

  // final String? errNum;

  const ServerException({
    required this.message,
    // required this.errNum,
  });

  @override
  List<Object?> get props => [
    message,
    // errNum,
  ];

  @override
  String toString() {
    return '$message';
  }
}

class AssetsException extends Equatable implements Exception {
  final String? message;

  const AssetsException({required this.message});

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return '$message';
  }
}
