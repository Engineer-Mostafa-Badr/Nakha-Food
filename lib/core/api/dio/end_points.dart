import 'package:flutter/foundation.dart';

class EndPoints {
  static const String domain = kDebugMode ? 'nakhaksa.com' : 'nakhaksa.com';
  static const String baseUrl = 'https://$domain/api';

  /// pages
  static String privacyPolicy = 'https://$domain/ar/privacy-policy';
  static String aboutUs = 'https://$domain/ar/about-us';
  static String servicePolicy = 'https://$domain/ar/terms-conditions';
  static String useTerms = 'https://$domain/ar/usage-policy';

  /// public data
  static const String cities = '/cities';
  static const String regions = '/regions';
  static const String notifications = '/notifications';
  static const String home = '/home';
  static const String generateNewPayLink = '/pay';
  static const String categories = '/categories';
  static const String contactUs = '/contact-us/store';

  /// auth
  static const String register = '/register';
  static const String login = '/login';
  static const String socialLogin = '/login/social/callback';
  static const String logout = '/logout';
  static const String deleteAccount = '/delete-account';
  static const String profile = '/profile';
  static const String myInvoices = '/invoices';
  static const String cars = '/cars';
  static const String resendVerificationEmail = '/resend-code';
  static const String verifyEmail = '/verify';
  static const String verifyOTP = '/otp-verify';
  static const String resendOTP = '/otp/resend';
  static const String agencies = '/agencies';
  static const String carModel = '/car-models';
  static const String addCar = '/cars/store';

  static String updateCar(int id) => '/cars/$id/update';

  static String deleteCar(int id) => '/cars/$id/delete';

  /// services
  static const String services = '/services';
  static const String vendors = '/vendors';
  static const String getAllProviders = '/vendors/list';
  static const String previewOrderRequest = '/orders/preview';

  static String showVendors(int id) => '/vendors/$id/show';
  static const String toggleFavorites = '/favorites/toggle';

  /// support chat
  static String showSupportChat(int id) => '/tickets/$id/show';

  static String addComment(int id) => '/tickets/$id/add-comment';
  static String storeTicket = '/tickets/store';
  static String getAllTickets = '/tickets';

  static String closeTicket(int id) => '/tickets/$id/close';

  /// wallet
  static const String wallet = '/wallet';
  static const String walletWithdraw = '/wallet/withdraw';

  /// favorites
  static const String favourite = '/favorites/list';

  /// Providers
  static const String providers = '/vendors';
  static const String providerProfile = '/vendor-profile';

  /// products
  static const String products = '/products';
  static const String vendorProducts = '/vendor/products';
  static const String addProduct = '/vendor/products';

  static String updateProduct(int productId) => '/vendor/products/$productId';

  static String deleteProduct(int productId) => '/vendor/products/$productId';

  static String showProduct(int productId) => '/products/$productId/show';

  /// orders
  static const String ordersList = '/client/orders';

  static String showOrder(int orderId) => '/client/orders/$orderId/show';

  static String rateProducts(int orderId) => '/orders/$orderId/ratings';

  static String updateOrderStatus(int orderId) =>
      '/vendor/orders/$orderId/change-status';

  /// cart
  static const String addToCart = '/client/cart/add';
  static const String updateToCart = '/client/cart/update';
  static const String cart = '/client/cart';
  static const String checkout = '/client/checkout';
  static const String payOrder = '/client/checkout/pay';

  /// favourite
  static const String favouriteProviders = '/client/vendors-favorites';
  static const String toggleFavouriteProviders =
      '/client/toggle-vendor-favourite';
  static const String favouriteProducts = '/client/products-favorites';
  static const String toggleFavouriteProducts =
      '/client/toggle-product-favourite';

  /// messages
  static const String chats = '/chat/conversations';

  static const String showChat = '/chat/conversation';
  static const String sendMessage = '/chat/messages';
}
