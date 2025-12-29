import 'package:dartz/dartz.dart';
import 'package:nakha/core/api/dio/base_response.dart';
import 'package:nakha/core/api/error/failures.dart';
import 'package:nakha/core/usecase/base_use_case.dart';
import 'package:nakha/features/profile/data/models/invoice_model.dart';
import 'package:nakha/features/profile/domain/repositories/base_profile_repo.dart';

class GetMyInvoicesUseCase
    extends
        BaseUseCase<BaseResponse<List<InvoiceModel>>, PaginationParameters> {
  GetMyInvoicesUseCase(this.repository);

  final BaseProfileRepository repository;

  @override
  Future<Either<Failure, BaseResponse<List<InvoiceModel>>>> call(
    PaginationParameters parameters,
  ) {
    return repository.getMyInvoices(parameters);
  }
}
