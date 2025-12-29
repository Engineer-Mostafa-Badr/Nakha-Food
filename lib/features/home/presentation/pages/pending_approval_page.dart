import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/navigation_extensions.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/landing/presentation/pages/landing_page.dart';
import 'package:nakha/features/profile/presentation/bloc/profile_bloc.dart';

class PendingApprovalPage extends StatelessWidget {
  const PendingApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.cPrimary,
        body: BlocConsumer<ProfileBloc, ProfileState>(
          buildWhen: (previous, current) =>
              previous.getProfileState != current.getProfileState,
          listener: (context, state) {
            if (state.getProfileState == RequestState.loaded) {
              if (state.getProfileResponse.data!.status == 'active') {
                context.navigateToPageWithClearStack(const LandingPage());
              }
            }
          },
          builder: (context, state) {
            return PullRefreshReuse(
              onRefresh: () async {
                ProfileBloc.get(context).add(const GetProfileEvent());
              },
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.largePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.update, color: Colors.white, size: 100),
                    AppPadding.padding24.sizedHeight,
                    Text(
                      'pending_approval_message',
                      textAlign: TextAlign.center,
                      style: AppStyles.title500.copyWith(color: Colors.white),
                    ).tr(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
