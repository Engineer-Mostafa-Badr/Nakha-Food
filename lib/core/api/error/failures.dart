import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;

  // final String? errNum;

  const Failure({
    required this.message,
    // required this.errNum,
  });

  @override
  List<Object> get props => [
    message!,
    // errNum!,
  ];
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    // required super.errNum,
  });
}

class AssetsFailure extends Failure {
  const AssetsFailure({
    required super.message,
    // required super.errNum,
  });
}
