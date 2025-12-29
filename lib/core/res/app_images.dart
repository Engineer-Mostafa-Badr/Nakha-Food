import 'dart:math';

class AssetImagesPath {
  // network ===>>>
  static String networkImage() {
    // random number between 900 and 999
    final int randomNumber = 900 + Random().nextInt(100);
    return 'https://picsum.photos/$randomNumber';
  }

  static const String launcherIcon = 'assets/images/ic_launcher.png';
  static const String appLogo = 'assets/images/app_logo.png';
  static const String logoSvg = 'assets/images/svg/logo.svg';

  /// real png ===>>>
  static const String splashBackground = 'assets/images/splash_background.png';
  static const String profileCard = 'assets/images/profile_card.png';
  static const String mapTem = 'assets/images/png/map_tem.jpg';
  static const onboarding1 = 'assets/images/intro_1.png';
  static const onboarding2 = 'assets/images/intro_2.png';
  static const onboarding3 = 'assets/images/intro_3.png';
  static const login = 'assets/images/login.png';

  /// real svg ===>>>

  static const loginSVG = 'assets/images/svg/login.svg';
  static const mailBoxSVG = 'assets/images/svg/MailBox.svg';
  static const appleSVG = 'assets/images/svg/apple.svg';
  static const homeSVG = 'assets/images/svg/home.svg';
  static const homeSelectedSVG = 'assets/images/svg/home_selected.svg';
  static const searchHomeSVG = 'assets/images/svg/iconoir_search.svg';
  static const searchSelectedHomeSVG =
      'assets/images/svg/iconoir_search_selected.svg';
  static const lightMenuSVG = 'assets/images/svg/light_menu.svg';
  static const lightMenuSelectedSVG =
      'assets/images/svg/light_menu_selected.svg';
  static const cartSVG = 'assets/images/svg/proicons_cart.svg';
  static const cartSelectedSVG = 'assets/images/svg/proicons_cart_selected.svg';
  static const walletSVG = 'assets/images/svg/solar_wallet.svg';
  static const walletSelectedSVG =
      'assets/images/svg/solar_wallet_selected.svg';
  static const avatarSVG = 'assets/images/svg/avatar.svg';
  static const arrowDownSVG = 'assets/images/svg/arrow-down-s-line.svg';
  static const arrowDown2SVG = 'assets/images/svg/arrow_down.svg';
  static const addressSVG = 'assets/images/svg/address.svg';
  static const starSVG = 'assets/images/svg/star.svg';
  static const backButtonSVG = 'assets/images/svg/back_button.svg';
  static const selectedSwitchSVG = 'assets/images/svg/selected_switch.svg';
  static const unselectedSwitchSVG = 'assets/images/svg/unselected_switch.svg';
  static const notificationPageSVG = 'assets/images/svg/notification_page.svg';
  static const searchSVG = 'assets/images/svg/search-line.svg';
  static const userXMarkSVG = 'assets/images/svg/user-xmark 1.svg';
  static const bellSVG = 'assets/images/svg/bell.svg';
  static const messagesSVG = 'assets/images/svg/messages.svg';
  static const timeSVG = 'assets/images/svg/time.svg';
  static const sendMessageSVG = 'assets/images/svg/send_message.svg';
  static const cameraSVG = 'assets/images/svg/camera.svg';
  static const nextMonthSVG = 'assets/images/svg/next_month.svg';
  static const lastMonthSVG = 'assets/images/svg/last_month.svg';

  static const onboarding4 = 'assets/images/svg/intro_4.svg';
  static const handsBrainSVG = 'assets/images/svg/hands-brain.svg';
  static const infoSVG = 'assets/images/svg/info.svg';
  static const privacySettingsSVG = 'assets/images/svg/privacy-settings.svg';
  static const termsInfoSVG = 'assets/images/svg/terms-info.svg';
  static const userGearSVG = 'assets/images/svg/user-gear 1.svg';
  static const userLogoutSVG = 'assets/images/svg/user-logout.svg';
  static const countrySVG = 'assets/images/svg/country.svg';
  static const languageSVG = 'assets/images/svg/famicons_language.svg';
  static const helpSVG = 'assets/images/svg/help.svg';
  static const favoriteSVG = 'assets/images/svg/light_favorite.svg';
  static const favoriteFilledSVG = 'assets/images/svg/favourite-filled.svg';
  static const verifySVG = 'assets/images/svg/verify.svg';
  static const locationSVG = 'assets/images/svg/location.svg';
  static const location2SVG = 'assets/images/svg/location2.svg';
  static const fullStarSVG = 'assets/images/svg/full_star.svg';
  static const mapSVG = 'assets/images/svg/map.svg';
  static const addSVG = 'assets/images/svg/add.svg';
  static const add2SVG = 'assets/images/svg/add2.svg';
  static const minusSVG = 'assets/images/svg/minus.svg';
  static const riyalSVG = 'assets/images/svg/riyal.svg';
  static const deleteSVG = 'assets/images/svg/delete.svg';
  static const depositSVG = 'assets/images/svg/deposit.svg';
  static const withdrawalSVG = 'assets/images/svg/withdrawal.svg';
  static const visaSVG = 'assets/images/svg/visa.svg';
  static const invoiceSVG = 'assets/images/svg/invoice.svg';
  static const cardSVG = 'assets/images/svg/card.svg';
  static const time2SVG = 'assets/images/svg/time2.svg';
  static const dateSVG = 'assets/images/svg/date.svg';
  static const deliveryManSVG = 'assets/images/svg/delivery-man.svg';
  static const handCashSVG = 'assets/images/svg/iconoir_hand-cash.svg';
  static const checkCircleSVG = 'assets/images/svg/check-circle.svg';
  static const closeCircleSVG = 'assets/images/svg/circle_close.svg';
  static const searchMapSVG = 'assets/images/svg/search_map.svg';
  static const questionSVG = 'assets/images/svg/question.svg';
  static const invoiceHomeSVG = 'assets/images/svg/invoice_home.svg';
  static const subscriptionSVG = 'assets/images/svg/subscription.svg';
  static const annualCheckupSVG = 'assets/images/svg/annual-checkup.svg';
  static const fileCopySVG = 'assets/images/svg/file_copy.svg';
  static const saudiRiyalSymbolSVG = 'assets/images/svg/Saudi_Riyal_Symbol.svg';
  static const consultantSVG = 'assets/images/svg/consultant.svg';
  static const consultantSelectedSVG =
      'assets/images/svg/consultant_selected.svg';
  static const clockSVG = 'assets/images/svg/clock.svg';
  static const clockSelectedSVG = 'assets/images/svg/clock_selected.svg';
  static const medicalReportSVG = 'assets/images/svg/medical-report.svg';
  static const filterSVG = 'assets/images/svg/filter.svg';
  static const arrowLeftSVG = 'assets/images/svg/arrow-left.svg';
  static const tickCircleSVG = 'assets/images/svg/tick-circle.svg';
  static const closeCircleTickSVG = 'assets/images/svg/close-circle.svg';
  static const bagTickSVG = 'assets/images/svg/bag-tick.svg';
  static const timerSVG = 'assets/images/svg/timer.svg';
  static const plusSVG = 'assets/images/svg/plus.svg';
  static const emailSVG = 'assets/images/svg/email.svg';
  static const whatsappSVG = 'assets/images/svg/whatsapp.svg';
  static const phoneSVG = 'assets/images/svg/phone.svg';
  static const contactSVG = 'assets/images/svg/contact.svg';
  static const transactionSVG = 'assets/images/svg/transaction.svg';
  static const allOrders = 'assets/images/svg/all_orders.svg';
  static const acceptedOrders = 'assets/images/svg/accepted_orders.svg';
  static const newOrders = 'assets/images/svg/new_orders.svg';
  static const cancelledOrders = 'assets/images/svg/cancelled_orders.svg';
  static const editSVG = 'assets/images/svg/edit.svg';
  static const viewSVG = 'assets/images/svg/view.svg';
  static const delete2SVG = 'assets/images/svg/delete2.svg';
  static const deleteImageSVG = 'assets/images/svg/delete_image.svg';
  static const transferSVG = 'assets/images/svg/Transfer.svg';
}
