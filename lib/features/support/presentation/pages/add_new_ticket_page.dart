import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/components/scaffold/profile_scaffold.dart';
import 'package:nakha/core/components/textformfields/reused_textformfield.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/validators.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/profile/presentation/widgets/my_account/my_account_image_title.dart';
import 'package:nakha/features/support/data/models/ticket_model.dart';
import 'package:nakha/features/support/domain/use_cases/store_ticket_usecase.dart';
import 'package:nakha/features/support/presentation/bloc/support_chat_bloc.dart';
import 'package:nakha/features/support/presentation/pages/support_chat_consumer.dart';

class AddNewTicketPage extends StatefulWidget {
  const AddNewTicketPage({super.key, this.onAddTicket});

  final Function(TicketModel)? onAddTicket;

  @override
  State<AddNewTicketPage> createState() => _AddNewTicketPageState();
}

class _AddNewTicketPageState extends State<AddNewTicketPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titleColor = Theme.of(context).textTheme.bodyLarge!.color;
    return BlocProvider(
      create: (context) => sl<SupportChatBloc>(),
      child: ProfileScaffold(
        topWidget: const MyAccountImageTitle(),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(AppPadding.largePadding),
            children: [
              AppPadding.smallPadding.sizedHeight,
              ReusedTextFormField(
                withBorder: false,
                titleColor: titleColor,
                title: 'ticket_title',
                hintText: 'ticket_title',
                fillColor: AppColors.cFillTextFieldLight,
                controller: _titleController,
                validator: Validators.validateName,
              ),
              ReusedTextFormField(
                withBorder: false,
                titleColor: titleColor,
                title: 'ticket_content',
                hintText: 'ticket_content',
                fillColor: AppColors.cFillTextFieldLight,
                minLines: 5,
                maxLines: 5,
                controller: _contentController,
                validator: Validators.validateDescription,
              ),
              0.sizedHeight,
              SupportChatConsumer(
                listener: (bloc, state) {
                  if (state.storeTicketState == RequestState.loaded) {
                    state.storeTicketResponse.msg!.showTopSuccessToast;
                    widget.onAddTicket?.call(state.storeTicketResponse.data!);
                    Navigator.pop(context, state.storeTicketResponse.data);
                  } else if (state.storeTicketState == RequestState.error) {
                    state.storeTicketResponse.msg!.showTopErrorToast;
                  }
                },
                builder: (bloc, state) {
                  return ReusedRoundedButton(
                    text: 'send_ticket',
                    isLoading: state.storeTicketState == RequestState.loading,
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      bloc.add(
                        StoreTicketEvent(
                          StoreTicketParams(
                            title: _titleController.text,
                            description: _contentController.text,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ].paddingDirectional(bottom: AppPadding.largePadding),
          ),
        ),
      ),
    );
  }
}
