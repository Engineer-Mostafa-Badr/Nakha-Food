import 'package:nakha/core/api/error/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

abstract class BaseUseCase<T, Parameters> {
  Future<Either<Failure, T>> call(Parameters parameters);
}

class NoParameters extends Equatable {
  const NoParameters();

  @override
  List<Object> get props => [];
}

class PaginationParameters extends Equatable {
  final int page;

  const PaginationParameters({this.page = 1});

  // to json
  Map<String, dynamic> toJson() {
    return {'page': page};
  }

  // copy with
  PaginationParameters copyWith({int page = 1}) {
    return PaginationParameters(page: page);
  }

  @override
  List<Object?> get props => [page];
}
