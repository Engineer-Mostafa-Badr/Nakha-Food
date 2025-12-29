import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/utils/most_used_functions.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    MostUsedFunctions.printFullText('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    MostUsedFunctions.printFullText('onChange -- ${bloc.runtimeType}, ');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    MostUsedFunctions.printFullText('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    MostUsedFunctions.printFullText('onClose -- ${bloc.runtimeType}');
  }
}
