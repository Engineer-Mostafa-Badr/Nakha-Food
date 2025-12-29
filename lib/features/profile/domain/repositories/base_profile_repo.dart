import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/auth/data/models/user_model.dart';
import 'package:nakha/features/profile/data/models/invoice_model.dart';
import 'package:nakha/features/profile/domain/entities/update_profile_params.dart';
import 'package:nakha/features/profile/domain/use_cases/contact_us_usecase.dart';

abstract class BaseProfileRepository {
  Future<Either<Failure, BaseResponse<UserModel>>> getProfile();

  Future<Either<Failure, BaseResponse<UserModel>>> updateProfile(
    UpdateProfileParams parameters,
  );

  Future<Either<Failure, BaseResponse<List<InvoiceModel>>>> getMyInvoices(
    PaginationParameters params,
  );

  Future<Either<Failure, BaseResponse>> contactUs(ContactUsParams parameters);
}
