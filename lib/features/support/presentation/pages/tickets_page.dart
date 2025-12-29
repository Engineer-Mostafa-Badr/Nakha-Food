import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/components/scaffold/profile_scaffold.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/profile/presentation/widgets/my_account/my_account_image_title.dart';
import 'package:nakha/features/support/presentation/bloc/support_chat_bloc.dart';
import 'package:nakha/features/support/presentation/widgets/tickets/tickets_button.dart';
import 'package:nakha/features/support/presentation/widgets/tickets/tickets_sliver_list.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<SupportChatBloc>()..add(const GetAllTicketsEvent()),
      child: ProfileScaffold(
        topWidget: const MyAccountImageTitle(),
        body: BlocBuilder<SupportChatBloc, SupportChatState>(
          buildWhen: (prev, current) => false,
          builder: (context, state) {
            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: SupportChatBloc.get(context).scrollController,
              slivers: const [
                SliverToBoxAdapter(child: TicketsHeaderButton()),
                TicketsSliverList(),
              ],
            );
          },
        ),
      ),
    );
  }
}
