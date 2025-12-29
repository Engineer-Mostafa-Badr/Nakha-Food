import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:nakha/core/api/dio/dio_consumer.dart';
import 'package:nakha/core/api/dio/end_points.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/core/storage/main_hive_box.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/cities_model.dart';
import 'package:nakha/features/injection_container.dart' as di;
import 'package:nakha/features/injection_container.dart';

part 'app_state.dart';

class MainAppCubit extends Cubit<MainAppCubitState> {
  MainAppCubit() : super(MainAppInitial());

  static MainAppCubit get(BuildContext context) => BlocProvider.of(context);

  // change theme mode
  bool isDark = false;

  bool get getIsDark => isDark;

  void changeThemeMode() async {
    isDark = !isDark;
    await di.sl<MainSecureStorage>().putValue(AppConst.isDarkBox, isDark);
    emit(AppChangeThemeMode());
  }

  ///
  List<CitiesModel> citiesModel = [];

  Future<void> getCities() async {
    citiesModel.clear();
    if (await InternetConnection().hasInternetAccess == false) {
      return;
    }
    emit(GetGovernoratesLoading());
    final response = await DioConsumer(
      client: sl(),
    ).get(EndPoints.cities, authenticated: false);

    if (response.data != null) {
      citiesModel.clear();
      for (final item in response.data['data'] ?? []) {
        citiesModel.add(CitiesModel.fromJson(item));
      }
      emit(GetGovernoratesSuccess());
    } else {
      emit(GetGovernoratesError());
    }
  }

  /// countriesModel
  List<CitiesModel> regionsModel = [];

  Future<void> getRegions(int cityId) async {
    regionsModel.clear();
    if (await InternetConnection().hasInternetAccess == false) {
      return;
    }
    emit(GetCountriesLoading());
    final response = await DioConsumer(client: sl()).get(
      EndPoints.regions,
      authenticated: false,
      queryParameters: {'city_id': cityId},
    );

    if (response.data != null) {
      regionsModel.clear();
      for (final item in response.data['data'] ?? []) {
        regionsModel.add(CitiesModel.fromJson(item));
      }
      emit(GetCountriesSuccess());
    } else {
      emit(GetCountriesError());
    }
  }

  /// categories
  List<CitiesModel> categoriesModel = [];

  Future<void> getCategories() async {
    categoriesModel.clear();
    if (await InternetConnection().hasInternetAccess == false) {
      return;
    }
    emit(GetCategoriesLoading());
    final response = await DioConsumer(
      client: sl(),
    ).get(EndPoints.categories, authenticated: false);

    if (response.data != null) {
      categoriesModel.clear();
      for (final item in response.data['data'] ?? []) {
        categoriesModel.add(CitiesModel.fromJson(item));
      }
      emit(GetCategoriesSuccess());
    } else {
      emit(GetCategoriesError());
    }
  }

  /// check internet connection
  late StreamSubscription<InternetStatus> listener;

  bool connectedToInternet = true;

  StreamSubscription<InternetStatus> checkInternetConnection() {
    // Listen to the Internet connection status stream
    return listener = InternetConnection().onStatusChange.listen((status) {
      // Ignore the event if the status hasn't actually changed
      if (status == InternetStatus.connected && connectedToInternet) return;
      if (status == InternetStatus.disconnected && !connectedToInternet) return;

      switch (status) {
        case InternetStatus.connected:
          // Update the internal state
          connectedToInternet = true;
          // Show a toast only if the connection just changed to connected
          'internet_connected_toast'.showTopSuccessToast;
          break;

        case InternetStatus.disconnected:
          // Update the internal state
          connectedToInternet = false;
          // Show a toast only if the connection just changed to disconnected
          'internet_disconnected_toast'.showTopErrorToast;
          break;
      }
    });
  }

  @override
  Future<void> close() {
    listener.cancel();
    return super.close();
  }
}
