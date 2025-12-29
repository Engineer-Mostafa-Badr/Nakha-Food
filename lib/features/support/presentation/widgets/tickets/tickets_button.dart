import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/support/presentation/bloc/support_chat_bloc.dart';
import 'package:nakha/features/support/presentation/pages/add_new_ticket_page.dart';
import 'package:nakha/features/support/presentation/pages/support_chat_consumer.dart';

class TicketsHeaderButton extends StatelessWidget {
  const TicketsHeaderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.sizedHeight,
        Row(
          children: [
            Expanded(
              child: Text(
                'tickets',
                style: AppStyles.title500.copyWith(fontSize: AppFontSize.f20),
              ).tr(),
            ),
            SupportChatConsumer(
              builder: (bloc, state) {
                return ReusedRoundedButton(
                  text: 'new_ticket',
                  width: 142,
                  onPressed: () {
                    context.navigateToPage(
                      AddNewTicketPage(
                        onAddTicket: (ticket) {
                          bloc.add(
                            UpdateTicketsLocalEvent(
                              state.getAllTicketsResponse.data!
                                ..insert(0, ticket),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ],
    ).addPadding(all: AppPadding.largePadding);
  }
}
