import 'package:easy_localization/easy_localization.dart' show tr;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/screen_status/loading_widget.dart';
import 'package:nakha/core/components/textformfields/reused_textformfield.dart';
import 'package:nakha/core/components/utils/container_for_bottom_nav_buttons.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/check_permissions.dart';
import 'package:nakha/core/utils/image_utils.dart';
import 'package:nakha/core/utils/other_helpers.dart';
import 'package:nakha/features/chat/domain/use_cases/send_message_usecase.dart';
import 'package:nakha/features/chat/presentation/bloc/chats_bloc.dart';
import 'package:nakha/features/chat/presentation/widgets/all_chats/selected_file_item.dart';
import 'package:nakha/features/chat/presentation/widgets/chat_messages/voice_record_reuse.dart';
import 'package:nakha/features/injection_container.dart';

class ChatControllerForm extends StatefulWidget {
  const ChatControllerForm({super.key});

  @override
  State<ChatControllerForm> createState() => _ChatControllerFormState();
}

class _ChatControllerFormState extends State<ChatControllerForm> {
  final List<String> _filesPaths = [];

  void _pickFiles() async {
    await sl<CheckAppPermissions>().checkPhotosPermission();
    await sl<CheckAppPermissions>().checkStoragePermission();
    await sl<ImageUtils>().pickImagesFromGallery().then((pickedImages) async {
      if (pickedImages.isNotEmpty) {
        setState(() {
          for (final image in pickedImages) {
            _filesPaths.add(image.path);
          }
        });
      }
    });
  }

  late final TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatsBloc, ChatsState>(
      buildWhen: (previous, current) =>
          previous.showChatResponse.data?.allowChat !=
              current.showChatResponse.data?.allowChat ||
          previous.sendMessageState != current.sendMessageState,
      listener: (context, state) {
        if (state.sendMessageState.isLoaded) {
          // Message sent successfully
          setState(() {
            _messageController.clear();
            _filesPaths.clear();
          });
        } else if (state.sendMessageState.isError) {
          OtherHelper.showTopFailToast(state.sendMessageResponse.msg);
        }
      },
      builder: (context, state) {
        return ContainerForBottomNavButtons(
          // height: filesPaths.isEmpty ? 90 : 150,
          child: state.showChatResponse.data?.allowChat == null
              ? const SizedBox.shrink()
              : state.showChatResponse.data?.allowChat == false
              ? Text(
                  tr('you_cannot_send_messages_in_this_chat'),
                  style: AppStyles.title500,
                  textAlign: TextAlign.center,
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_filesPaths.isNotEmpty) ...[
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _filesPaths.length,
                          separatorBuilder: (context, index) =>
                              AppPadding.smallPadding.sizedWidth,
                          itemBuilder: (context, index) {
                            return SelectedFileChatItem(
                              path: _filesPaths[index],
                              onTap: () {
                                setState(() {
                                  _filesPaths.removeAt(index);
                                });
                              },
                            );
                          },
                        ),
                      ),
                      AppPadding.smallPadding.sizedHeight,
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ReusedTextFormField(
                            hintText: 'write_here',
                            // showLabel: false,
                            controller: _messageController,
                            // fillColor: AppColors.grey67Color,
                            keyboardType: TextInputType.multiline,
                            maxLines: 3,
                            suffixWidget: IconButton(
                              icon: Badge.count(
                                isLabelVisible: _filesPaths.isNotEmpty,
                                count: _filesPaths.length,
                                smallSize: 20.sp,
                                backgroundColor: AppColors.cPrimary,
                                child: const AssetSvgImage(
                                  AssetImagesPath.cameraSVG,
                                ),
                              ),
                              onPressed: () {
                                _pickFiles();
                              },
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.largePadding,
                            ),
                          ),
                        ),
                        AppPadding.padding12.sizedWidth,
                        VoiceRecordReuse(
                          onRecordedFilePath: (filePath) {
                            ChatsBloc.get(context).add(
                              SendMessageEvent(
                                parameters: SendMessageParameters(
                                  receiverId: ChatsBloc.get(
                                    context,
                                  ).state.showChatParameters.receiverId,
                                  attachments: [filePath],
                                  message: _messageController.text,
                                ),
                              ),
                            );
                          },
                        ),
                        AppPadding.smallPadding.sizedWidth,
                        RotatedBox(
                          quarterTurns:
                              TextDirection.ltr == Directionality.of(context)
                              ? 2
                              : 0,
                          child: state.sendMessageState.isLoading
                              ? const LoadingWidget()
                              : const AssetSvgImage(
                                  AssetImagesPath.sendMessageSVG,
                                  color: AppColors.cPrimary,
                                  width: 24,
                                  height: 24,
                                ).addAction(
                                  onTap: () {
                                    if (state.showChatResponse.data != null &&
                                        state
                                                .showChatResponse
                                                .data!
                                                .allowChat ==
                                            false) {
                                      return;
                                    }
                                    if (_messageController.text.isNotEmpty ||
                                        _filesPaths.isNotEmpty) {
                                      ChatsBloc.get(context).add(
                                        SendMessageEvent(
                                          parameters: SendMessageParameters(
                                            receiverId: ChatsBloc.get(context)
                                                .state
                                                .showChatParameters
                                                .receiverId,
                                            message: _messageController.text,
                                            attachments: _filesPaths,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
        );
      },
    );
  }
}
