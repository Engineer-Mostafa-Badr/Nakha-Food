import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/components/screen_status/loading_widget.dart';
import 'package:nakha/core/components/textformfields/reused_textformfield.dart';
import 'package:nakha/core/components/utils/container_for_bottom_nav_buttons.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/core/utils/image_utils.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/support/domain/entities/send_support_message_params.dart';
import 'package:nakha/features/support/presentation/bloc/support_chat_bloc.dart';
import 'package:nakha/features/support/presentation/pages/support_chat_consumer.dart';
import 'package:nakha/features/support/presentation/widgets/selected_file_item.dart';

class ChatControllerReuse extends StatefulWidget {
  const ChatControllerReuse({super.key, this.packageId});

  final String? packageId;

  @override
  State<ChatControllerReuse> createState() => _ChatControllerReuseState();
}

class _ChatControllerReuseState extends State<ChatControllerReuse> {
  List<String> filesPaths = [];

  void pickFiles() async {
    // final images = await ImagePicker().pickMultiImage();
    // if (images.isNotEmpty) {
    //   setState(() {
    //     for (final image in images) {
    //       filesPaths.add(image.path);
    //     }
    //   });
    // }
    await sl<ImageUtils>().pickImagesFromGallery().then((images) {
      if (images.isNotEmpty) {
        setState(() {
          for (final file in images) {
            filesPaths.add(file.path);
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
    return SupportChatConsumer(
      buildWhen: (previous, current) =>
          previous.sendSupportMessageState != current.sendSupportMessageState,
      listener: (context, state) {
        if (state.sendSupportMessageState == RequestState.loaded) {
          _messageController.clear();
          filesPaths.clear();
        } else if (state.sendSupportMessageState == RequestState.error) {
          state.sendSupportMessageResponse.msg!.showTopErrorToast;
        }
      },
      builder: (bloc, state) {
        return ContainerForBottomNavButtons(
          // height: filesPaths.isEmpty ? 90 : 150,
          isBottomNavigatorSheet: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (filesPaths.isNotEmpty) ...[
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: filesPaths.length,
                    separatorBuilder: (context, index) =>
                        AppPadding.smallPadding.sizedWidth,
                    itemBuilder: (context, index) {
                      return SelectedFileChatItem(
                        path: filesPaths[index],
                        onTap: () {
                          setState(() {
                            filesPaths.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
                ),
                AppPadding.smallPadding.sizedHeight,
              ],
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: ReusedTextFormField(
                        hintText: 'enter_message',
                        controller: _messageController,
                        suffixWidget: IconButton(
                          icon: Badge.count(
                            isLabelVisible: filesPaths.isNotEmpty,
                            count: filesPaths.length,
                            smallSize: 20.sp,
                            backgroundColor: AppColors.cPrimary,
                            child: const AssetSvgImage(
                              AssetImagesPath.cameraSVG,
                            ),
                          ),
                          onPressed: () {
                            pickFiles();
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.largePadding,
                        ),
                      ),
                    ),
                    AppPadding.smallPadding.sizedWidth,
                    if (state.sendSupportMessageState == RequestState.loading)
                      const LoadingWidget()
                    else
                      IconButton(
                        icon: const AssetSvgImage(
                          AssetImagesPath.sendMessageSVG,
                          color: AppColors.cPrimary,
                        ),
                        onPressed: () {
                          if ((_messageController.text.isEmpty &&
                                  filesPaths.isEmpty) ||
                              state.sendSupportMessageState ==
                                  RequestState.loading) {
                            return;
                          }

                          SupportChatBloc.get(context).add(
                            SendSupportMessageEvent(
                              SendSupportMessageParams(
                                content: _messageController.text,
                                attachments: filesPaths,
                                packageId: int.tryParse(widget.packageId!),
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
