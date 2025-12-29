import 'package:nakha/core/api/dio/api_consumer.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/support/data/data_sources/remote/remote_data_source.dart';
import 'package:nakha/features/support/data/repositories/implementation_repositories.dart';
import 'package:nakha/features/support/domain/repositories/base_support_chat_repo.dart';
import 'package:nakha/features/support/domain/use_cases/close_ticket_usecase.dart';
import 'package:nakha/features/support/domain/use_cases/get_all_tickets_usecase.dart';
import 'package:nakha/features/support/domain/use_cases/get_support_chat_usecase.dart';
import 'package:nakha/features/support/domain/use_cases/send_support_message_usecase.dart';
import 'package:nakha/features/support/domain/use_cases/store_ticket_usecase.dart';
import 'package:nakha/features/support/presentation/bloc/support_chat_bloc.dart';

Future<void> getSupportChatModule() async {
  /// Use Cases
  sl.registerLazySingleton<GetSupportChatUseCase>(
    () => GetSupportChatUseCase(sl<BaseSupportChatRepository>()),
  );
  sl.registerLazySingleton<SendSupportMessageUseCase>(
    () => SendSupportMessageUseCase(sl<BaseSupportChatRepository>()),
  );
  sl.registerLazySingleton<StoreTicketUseCase>(
    () => StoreTicketUseCase(sl<BaseSupportChatRepository>()),
  );
  sl.registerLazySingleton<GetAllTicketsUseCase>(
    () => GetAllTicketsUseCase(sl<BaseSupportChatRepository>()),
  );
  sl.registerLazySingleton<CloseTicketUseCase>(
    () => CloseTicketUseCase(sl<BaseSupportChatRepository>()),
  );

  /// Repositories
  sl.registerLazySingleton<BaseSupportChatRepository>(
    () => SupportChatRepositoryImpl(sl<SupportChatRemoteDataSource>()),
  );

  /// Data Sources
  sl.registerLazySingleton<SupportChatRemoteDataSource>(
    () => SupportChatRemoteDataSource(sl<ApiConsumer>()),
  );

  /// Blocs
  sl.registerFactory<SupportChatBloc>(
    () => SupportChatBloc(
      sl<GetSupportChatUseCase>(),
      sl<SendSupportMessageUseCase>(),
      sl<StoreTicketUseCase>(),
      sl<GetAllTicketsUseCase>(),
      sl<CloseTicketUseCase>(),
    ),
  );
}
