part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetHomeUtilsEvent extends HomeEvent {
  final GetHomeUtilsParams params;

  const GetHomeUtilsEvent({this.params = const GetHomeUtilsParams()});

  @override
  List<Object> get props => [];
}

class MakeCounterNotificationZeroEvent extends HomeEvent {
  const MakeCounterNotificationZeroEvent();

  @override
  List<Object> get props => [];
}

class GenerateNewPayLinkEvent extends HomeEvent {
  const GenerateNewPayLinkEvent();

  @override
  List<Object> get props => [];
}

class GetCategoriesEvent extends HomeEvent {
  const GetCategoriesEvent({this.params = const NoParameters()});

  final NoParameters params;

  @override
  List<Object> get props => [];
}

final class ReplaceProviderEvent extends HomeEvent {
  const ReplaceProviderEvent(this.provider);

  final ProvidersModel provider;

  @override
  List<Object> get props => [provider];
}

class UpdateHomeUtilsEvent extends HomeEvent {
  const UpdateHomeUtilsEvent(this.homeUtils);

  final HomeModel homeUtils;

  @override
  List<Object> get props => [homeUtils];
}

final class AddMinusUnreadConversationsEvent extends HomeEvent {
  const AddMinusUnreadConversationsEvent(this.isAdd);

  final bool isAdd;

  @override
  List<Object> get props => [isAdd];
}
