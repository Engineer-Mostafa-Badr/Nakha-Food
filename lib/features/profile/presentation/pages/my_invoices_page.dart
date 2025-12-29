import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/core/components/appbar/shared_app_bar.dart';
import 'package:nakha/core/components/lists/list_view_with_pagination.dart';
import 'package:nakha/core/enum/enums.dart';
import 'package:nakha/features/injection_container.dart';
import 'package:nakha/features/profile/data/models/invoice_model.dart';
import 'package:nakha/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:nakha/features/profile/presentation/widgets/my_invoices/my_invoices_item.dart';

class MyInvoicesPage extends StatelessWidget {
  const MyInvoicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileBloc>()..add(const GetMyInvoicesEvent()),
      child: Scaffold(
        appBar: const SharedAppBar(title: 'my_invoices'),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          buildWhen: (previous, current) =>
              previous.getMyInvoicesState != current.getMyInvoicesState,
          builder: (context, state) {
            return ListViewWithPagination<InvoiceModel>(
              emptyMessage: 'no_invoices',
              errorMessage: state.getMyInvoicesResponse.msg,
              isListLoading:
                  state.getMyInvoicesState == RequestState.loading &&
                  state.invoicesParameters.page == 1,
              isLoadMoreLoading:
                  state.getMyInvoicesState == RequestState.loading &&
                  state.invoicesParameters.page != 1,
              totalItems: state.getMyInvoicesResponse.pagination?.total ?? 0,
              isLastPage:
                  state.getMyInvoicesResponse.pagination?.currentPage ==
                  state.getMyInvoicesResponse.pagination?.lastPage,
              items: state.getMyInvoicesResponse.data,
              model: state.getMyInvoicesResponse.data,
              itemWidget: (item, index) => MyInvoicesItem(invoiceModel: item),
              onPressedLoadMore: () {
                ProfileBloc.get(context).add(
                  GetMyInvoicesEvent(
                    parameters: state.invoicesParameters.copyWith(
                      page: state.invoicesParameters.page + 1,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
