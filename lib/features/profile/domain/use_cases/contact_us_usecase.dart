import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/profile/domain/repositories/base_profile_repo.dart';

class ContactUsUseCase extends BaseUseCase<BaseResponse, ContactUsParams> {
  final BaseProfileRepository repository;

  ContactUsUseCase(this.repository);

  @override
  Future<Either<Failure, BaseResponse>> call(ContactUsParams parameters) {
    return repository.contactUs(parameters);
  }
}

class ContactUsParams extends Equatable {
  const ContactUsParams({
    required this.address,
    required this.content,
    required this.name,
    required this.phone,
    this.filePath,
  });

  final String address;
  final String content;
  final String name;
  final String phone;
  final String? filePath;

  Future<Map<String, dynamic>> toJson() async {
    return {
      'subject': address,
      'message': content,
      if (name.isNotEmpty) 'name': name,
      if (phone.isNotEmpty) 'phone': phone,
      if (filePath != null && filePath!.isNotEmpty)
        'attachment': await MultipartFile.fromFile(
          filePath!,
          filename: filePath!.split('/').last,
        ),
    };
  }

  @override
  List<Object?> get props => [address, content, filePath, name, phone];
}
