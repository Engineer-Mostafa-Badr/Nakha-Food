import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/components/buttons/rounded_button.dart';
import 'package:nakha/core/components/screen_status/loading_result_page_reuse.dart';
import 'package:nakha/core/components/utils/container_for_bottom_nav_buttons.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/chat/presentation/pages/chat_messages_page.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/landing/presentation/pages/landing_page.dart';
import 'package:nakha/features/providers/domain/use_cases/get_provider_profile_usecase.dart';
import 'package:nakha/features/providers/presentation/bloc/providers_bloc.dart';
import 'package:nakha/features/providers/presentation/widgets/providers_details/providers_details_products_section.dart';
import 'package:nakha/features/providers/presentation/widgets/providers_details/providers_details_sliver_persistent_header.dart';
import 'package:nakha/features/providers/presentation/widgets/providers_details/show_info_section.dart';
import 'package:nakha/features/providers/presentation/widgets/providers_details/top_section_providers_details.dart';

class ProvidersDetailsPage extends StatefulWidget {
  const ProvidersDetailsPage({super.key, required this.providerId});

  final int providerId;

  @override
  State<ProvidersDetailsPage> createState() => _ProvidersDetailsPageState();
}

class _ProvidersDetailsPageState extends State<ProvidersDetailsPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProvidersBloc>()
        ..add(
          ProviderProfileFetchEvent(
            params: ProviderProfileParameters(providerId: widget.providerId),
          ),
        ),
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          initialIndex: _currentIndex,
          child: SafeArea(
            child: BlocBuilder<ProvidersBloc, ProvidersState>(
              buildWhen: (previous, current) =>
                  current.getProviderProfileState !=
                  previous.getProviderProfileState,
              builder: (context, state) {
                return PullRefreshReuse(
                  onRefresh: () async {
                    ProvidersBloc.get(context).add(
                      ProviderProfileFetchEvent(
                        params: ProviderProfileParameters(
                          providerId: widget.providerId,
                        ),
                      ),
                    );
                  },
                  child: LoadingResultPageReuse(
                    isListLoading:
                        state.getProviderProfileState == RequestState.loading,
                    model: state.getProviderProfileResponse.data,
                    child: state.getProviderProfileResponse.data == null
                        ? const SizedBox.shrink()
                        : CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: TopSectionProvidersDetails(
                                  providerProfileModel:
                                      state.getProviderProfileResponse.data!,
                                ),
                              ),

                              ///
                              ProvidersDetailsSliverPersistentHeader(
                                onTap: (index) {
                                  if (_currentIndex == index) return;
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                },
                              ),

                              if (_currentIndex == 0)
                                SliverToBoxAdapter(
                                  child: ShowInfoSection(
                                    providersModel: state
                                        .getProviderProfileResponse
                                        .data!
                                        .vendor,
                                  ),
                                )
                              else if (_currentIndex == 1)
                                ProvidersDetailsProductsSection(
                                  onAddToFav: (product) {
                                    ProvidersBloc.get(
                                      context,
                                    ).add(ReplaceProductEvent(product));
                                  },
                                  products: state
                                      .getProviderProfileResponse
                                      .data!
                                      .products,
                                ),
                            ],
                          ),
                  ),
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: BlocBuilder<ProvidersBloc, ProvidersState>(
          buildWhen: (previous, current) =>
              current.getProviderProfileState !=
              previous.getProviderProfileState,
          builder: (context, state) {
            return state.getProviderProfileResponse.data != null
                ? ContainerForBottomNavButtons(
                    child: Row(
                      children: [
                        if (state
                                .getProviderProfileResponse
                                .data!
                                .totalProductsInCart >
                            0) ...[
                          Expanded(
                            child: ReusedRoundedButton(
                              text: 'got_to_cart'.tr(
                                namedArgs: {
                                  'count': state
                                      .getProviderProfileResponse
                                      .data!
                                      .totalProductsInCart
                                      .toString(),
                                },
                              ),
                              onPressed: () {
                                context.navigateToPageWithClearStack(
                                  const LandingPage(index: 2),
                                );
                              },
                            ),
                          ),
                          AppPadding.smallPadding.sizedWidth,
                        ],
                        Expanded(
                          child: ReusedRoundedButton(
                            color: AppColors.cPrimaryBold,
                            rowWidget: const AssetSvgImage(
                              AssetImagesPath.messagesSVG,
                              color: Colors.white,
                              height: 20,
                              width: 20,
                            ),
                            text: 'contact_with_provider'.tr(
                              namedArgs: {
                                'providerName': state
                                    .getProviderProfileResponse
                                    .data!
                                    .vendor
                                    .name,
                              },
                            ),
                            onPressed: () {
                              context.navigateToPage(
                                ChatMessagesPage(receiverId: widget.providerId),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
