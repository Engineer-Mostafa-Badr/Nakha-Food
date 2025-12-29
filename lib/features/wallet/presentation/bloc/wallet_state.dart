part of 'wallet_bloc.dart';

final class WalletState extends Equatable {
  const WalletState({
    /// get providers state
    this.getWalletState = RequestState.loading,
    this.getWalletResponse = const BaseResponse(),
    this.getWalletParameters = const WalletParameters(),
  });

  /// get providers state
  final RequestState getWalletState;
  final BaseResponse<WalletModel> getWalletResponse;
  final WalletParameters getWalletParameters;

  WalletState copyWith({
    /// get providers state
    RequestState? getWalletState,
    BaseResponse<WalletModel>? getWalletResponse,
    WalletParameters? getWalletParameters,
  }) {
    return WalletState(
      /// get providers state
      getWalletState: getWalletState ?? this.getWalletState,
      getWalletResponse: getWalletResponse ?? this.getWalletResponse,
      getWalletParameters: getWalletParameters ?? this.getWalletParameters,
    );
  }

  @override
  List<Object?> get props => [
    /// get provider profile state
    getWalletState,
    getWalletResponse,
    getWalletParameters,
  ];
}
