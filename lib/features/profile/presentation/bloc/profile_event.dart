part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class GetProfileEvent extends ProfileEvent {
  const GetProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfileEvent extends ProfileEvent {
  const UpdateProfileEvent(this.parameters);

  final UpdateProfileParams parameters;

  @override
  List<Object> get props => [parameters];
}

class GetMyInvoicesEvent extends ProfileEvent {
  final PaginationParameters parameters;

  const GetMyInvoicesEvent({this.parameters = const PaginationParameters()});

  @override
  List<Object> get props => [parameters];
}

class ContactUsEvent extends ProfileEvent {
  const ContactUsEvent(this.parameters);

  final ContactUsParams parameters;

  @override
  List<Object> get props => [parameters];
}
