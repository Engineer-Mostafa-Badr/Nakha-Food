import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/config/themes/styles.dart';
import 'package:nakha/core/components/appbar/shared_home_app_bar.dart';
import 'package:nakha/core/components/lists/grid_view_with_pagination.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/core/extensions/size_extensions.dart';
import 'package:nakha/core/utils/app_sizes.dart';
import 'package:nakha/features/home/presentation/bloc/home_bloc.dart';
import 'package:nakha/features/home/presentation/widgets/departments/department_list_view_item.dart';
import 'package:nakha/features/injection_container.dart';

class AllDepartmentsPage extends StatelessWidget {
  const AllDepartmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>()..add(const GetCategoriesEvent()),
      child: Scaffold(
        appBar: const SharedHomeAppBar(showBackButton: true),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'main_departments',
              style: AppStyles.title500.copyWith(fontSize: AppFontSize.f16),
            ).tr().addPadding(
              start: AppPadding.mediumPadding,
              top: AppPadding.mediumPadding,
              end: AppPadding.mediumPadding,
            ),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (prevState, currentState) =>
                    prevState.requestCategoriesState !=
                    currentState.requestCategoriesState,
                builder: (context, state) {
                  return PullRefreshReuse(
                    onRefresh: () async {
                      HomeBloc.get(context).add(const GetCategoriesEvent());
                    },
                    child: GridViewWithPagination(
                      // itemCount: 20,
                      // // padding: const EdgeInsets.all(AppPadding.padding10),
                      // padding: const EdgeInsets.symmetric(
                      //   horizontal: AppPadding.padding10,
                      //   vertical: AppPadding.mediumPadding,
                      // ),
                      // gridDelegate:
                      //     const SliverGridDelegateWithFixedCrossAxisCount(
                      //       crossAxisCount: 4,
                      //       // childAspectRatio: 1.0,
                      //       crossAxisSpacing: AppPadding.padding4,
                      //       mainAxisSpacing: 32,
                      //     ),
                      // itemBuilder: (context, index) {
                      //   return FittedBox(
                      //     fit: BoxFit.scaleDown,
                      //     child: DepartmentListViewItem(
                      //       category: CategoriesModel(
                      //         id: index,
                      //         name: 'Department $index',
                      //         cover: AssetImagesPath.networkImage(),
                      //       ),
                      //     ),
                      //   );
                      // },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            // childAspectRatio: 1.0,
                            crossAxisSpacing: AppPadding.padding4,
                            mainAxisSpacing: 32,
                          ),
                      emptyMessage: 'no_categories_found',
                      isListLoading:
                          state.requestCategoriesState == RequestState.loading,
                      // && state.getProvidersParameters.page == 1,
                      isLoadMoreLoading:
                          state.requestCategoriesState == RequestState.loading,
                      // state.getProvidersParameters.page > 1,
                      model: state.responseCategories.data,
                      items: state.responseCategories.data,
                      isLastPage:
                          state.responseCategories.pagination?.currentPage ==
                          state.responseCategories.pagination?.lastPage,
                      itemWidget: (item) {
                        return FittedBox(
                          fit: BoxFit.scaleDown,
                          child: DepartmentListViewItem(category: item),
                        );
                      },
                      onPressedLoadMore: () {
                        HomeBloc.get(context).add(const GetCategoriesEvent());
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
