part of 'app_cubit.dart';

@immutable
abstract class MainAppCubitState {}

class MainAppInitial extends MainAppCubitState {}

class AppChangeThemeMode extends MainAppCubitState {}

class AppChangeLanguage extends MainAppCubitState {}

class LoadingDownloadNewPatch extends MainAppCubitState {}

class SuccessDownloadNewPatch extends MainAppCubitState {}

class ErrorDownloadNewPatch extends MainAppCubitState {}

class GetGovernoratesLoading extends MainAppCubitState {}

class GetGovernoratesSuccess extends MainAppCubitState {}

class GetGovernoratesError extends MainAppCubitState {}

class GetUserRoleSuccess extends MainAppCubitState {}

class GetCountriesLoading extends MainAppCubitState {}

class GetCountriesSuccess extends MainAppCubitState {}

class GetCountriesError extends MainAppCubitState {}

class GetCategoriesLoading extends MainAppCubitState {}

class GetCategoriesSuccess extends MainAppCubitState {}

class GetCategoriesError extends MainAppCubitState {}
