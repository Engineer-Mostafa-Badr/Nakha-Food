import 'package:nakha/core/api/dio/api_consumer.dart';
import 'package:nakha/features/chat/data/data_sources/remote/remote_data_source.dart';
import 'package:nakha/features/chat/data/repositories/implementation_repositories.dart';
import 'package:nakha/features/chat/domain/repositories/base_repo.dart';
import 'package:nakha/features/chat/domain/use_cases/get_chats_usecase.dart';
import 'package:nakha/features/chat/domain/use_cases/send_message_usecase.dart';
import 'package:nakha/features/chat/domain/use_cases/show_chat_usecase.dart';
import 'package:nakha/features/chat/presentation/bloc/chats_bloc.dart';
import 'package:nakha/features/injection_container.dart';

Future<void> getChatsModule() async {
  /// Use Cases
  sl.registerLazySingleton<ChatsUseCase>(
    () => ChatsUseCase(sl<BaseChatsRepository>()),
  );
  sl.registerLazySingleton<ShowChatsUseCase>(
    () => ShowChatsUseCase(sl<BaseChatsRepository>()),
  );
  sl.registerLazySingleton<SendMessageUseCase>(
    () => SendMessageUseCase(sl<BaseChatsRepository>()),
  );

  /// Repositories
  sl.registerLazySingleton<BaseChatsRepository>(
    () => ChatsRepositoryImpl(sl<ChatsRemoteDataSource>()),
  );

  /// Data Sources
  sl.registerLazySingleton<ChatsRemoteDataSource>(
    () => ChatsRemoteDataSource(sl<ApiConsumer>()),
  );

  /// Blocs
  sl.registerFactory<ChatsBloc>(
    () => ChatsBloc(
      sl<ChatsUseCase>(),
      sl<ShowChatsUseCase>(),
      sl<SendMessageUseCase>(),
    ),
  );
}
