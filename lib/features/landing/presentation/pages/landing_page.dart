import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/res/app_images.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/delay_login.dart';
import 'package:nakha/features/home/presentation/bloc/home_bloc.dart';
import 'package:nakha/features/home/presentation/pages/auth_home_page.dart';
import 'package:nakha/features/home/presentation/pages/vendor_home_page.dart';
import 'package:nakha/features/orders/presentation/pages/cart_page.dart';
import 'package:nakha/features/orders/presentation/pages/orders_page.dart';
import 'package:nakha/features/profile/presentation/pages/my_account_page.dart';
import 'package:nakha/features/wallet/presentation/pages/wallet_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key, this.index = 0});

  final int index;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;

  final List _pages = const [
    [
      AssetImagesPath.homeSVG,
      AssetImagesPath.homeSelectedSVG,
      AuthHomePage(),
      'home',
    ],
    [
      AssetImagesPath.consultantSVG,
      AssetImagesPath.consultantSelectedSVG,
      OrdersPage(),
      'my_orders',
    ],
    [
      AssetImagesPath.cartSVG,
      AssetImagesPath.cartSelectedSVG,
      CartPage(),
      'cart',
    ],
    [
      AssetImagesPath.lightMenuSVG,
      AssetImagesPath.lightMenuSelectedSVG,
      MyAccountPage(),
      'more',
    ],
  ];
  final List _pagesProvider = const [
    [
      AssetImagesPath.homeSVG,
      AssetImagesPath.homeSelectedSVG,
      VendorHomePage(),
      'home',
    ],
    [
      AssetImagesPath.consultantSVG,
      AssetImagesPath.consultantSelectedSVG,
      OrdersPage(),
      'my_orders',
    ],
    [
      AssetImagesPath.walletSVG,
      AssetImagesPath.walletSelectedSVG,
      WalletPage(showBackButton: false),
      'wallet',
    ],
    [
      AssetImagesPath.lightMenuSVG,
      AssetImagesPath.lightMenuSelectedSVG,
      MyAccountPage(),
      'more',
    ],
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    if (index == 3) {
      setState(() {
        _selectedIndex = index;
      });
      return;
    }

    if (index == 0) {
      HomeBloc.get(context).add(const GetHomeUtilsEvent());
      setState(() {
        _selectedIndex = index;
      });
      return;
    }

    CheckLoginDelay.checkIfNeedLogin(
      onExecute: () {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    HomeBloc.get(context).add(const GetHomeUtilsEvent());
    if (widget.index > 0 && widget.index < _pages.length) {
      _selectedIndex = widget.index;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppConst.user?.userType == 'vendor'
          ? _pagesProvider[_selectedIndex][2]
          : _pages[_selectedIndex][2],
      bottomNavigationBar: BlocConsumer<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            previous.responseUtils.data?.totalItemsInCart !=
            current.responseUtils.data?.totalItemsInCart,
        listener: (context, state) {},
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: _selectedIndex,
            elevation: 0,
            onTap: _onItemTapped,
            items: List.generate(
              AppConst.user?.userType == 'vendor'
                  ? _pagesProvider.length
                  : _pages.length,
              (index) => BottomNavigationBarItem(
                icon: Badge.count(
                  isLabelVisible:
                      state.responseUtils.data?.totalItemsInCart != null &&
                      state.responseUtils.data!.totalItemsInCart != 0 &&
                      index == 2 &&
                      AppConst.user?.userType != 'vendor',
                  count: state.responseUtils.data?.totalItemsInCart ?? 0,
                  backgroundColor: AppColors.cPrimary,
                  child: AssetSvgImage(
                    width: 24,
                    AppConst.user?.userType == 'vendor'
                        ? _pagesProvider[index][index == _selectedIndex ? 1 : 0]
                        : _pages[index][index == _selectedIndex ? 1 : 0],
                    color: index == _selectedIndex
                        ? AppColors.cPrimary
                        : AppColors.boldGreyColor,
                  ),
                ),
                label: AppConst.user?.userType == 'vendor'
                    ? '${_pagesProvider[index][3]}'.tr()
                    : '${_pages[index][3]}'.tr(),
              ),
            ),
          );
        },
      ),
    );
  }
}
