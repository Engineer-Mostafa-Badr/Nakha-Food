import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/features/support/presentation/bloc/support_chat_bloc.dart';

class SupportChatConsumer extends StatelessWidget {
  const SupportChatConsumer({
    super.key,
    required this.builder,
    this.listener,
    this.buildWhen,
  });

  final Widget Function(SupportChatBloc, SupportChatState) builder;
  final void Function(SupportChatBloc, SupportChatState)? listener;
  final bool Function(SupportChatState, SupportChatState)? buildWhen;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SupportChatBloc, SupportChatState>(
      buildWhen: buildWhen,
      listener: listener != null
          ? (context, state) => listener!(SupportChatBloc.get(context), state)
          : (context, state) {},
      builder: (context, state) {
        return builder(SupportChatBloc.get(context), state);
      },
    );
  }
}
