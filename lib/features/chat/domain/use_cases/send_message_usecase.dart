import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/chat/domain/repositories/base_repo.dart';

class SendMessageUseCase
    extends BaseUseCase<BaseResponse, SendMessageParameters> {
  SendMessageUseCase(this.repository);

  final BaseChatsRepository repository;

  @override
  Future<Either<Failure, BaseResponse>> call(SendMessageParameters parameters) {
    return repository.sendMessage(parameters);
  }
}

class SendMessageParameters extends Equatable {
  const SendMessageParameters({
    required this.receiverId,
    required this.message,
    this.attachments = const [],
  });

  final int receiverId;
  final String message;
  final List<String> attachments;

  Future<Map<String, dynamic>> toJson() async {
    return {
      if (message.isNotEmpty) 'message': message,
      'receiver_id': receiverId,
      for (int i = 0; i < attachments.length; i++)
        'attachments[$i]': await MultipartFile.fromFile(attachments[i]),
    };
  }

  @override
  List<Object?> get props => [receiverId, message, attachments];
}
