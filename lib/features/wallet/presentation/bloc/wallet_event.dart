part of 'wallet_bloc.dart';

sealed class WalletEvent extends Equatable {
  const WalletEvent();
}

final class WalletFetchEvent extends WalletEvent {
  const WalletFetchEvent({this.params = const WalletParameters()});

  final WalletParameters params;

  @override
  List<Object> get props => [params];
}
