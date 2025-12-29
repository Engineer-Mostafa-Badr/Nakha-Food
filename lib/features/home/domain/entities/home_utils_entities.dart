import 'package:equatable/equatable.dart';
import 'package:nakha/features/auth/data/models/user_model.dart';
import 'package:nakha/features/home/data/models/categories_model.dart';
import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/orders/data/models/orders_model.dart';

class HomeEntities extends Equatable {
  const HomeEntities({
    required this.sliders,
    required this.unreadNotifications,
    required this.categories,
    required this.appInReview,
    required this.alternateCourseCost,
    required this.iosUrl,
    required this.androidUrl,
    required this.iosVersionNumber,
    required this.androidVersionNumber,
    this.vendors = const [],
    required this.phoneNumber,
    required this.whatsappNumber,
    required this.email,
    required this.location,
    required this.totalItemsInCart,
    required this.vendorData,
    required this.unreadConversations,
  });

  final List<SlidersModel> sliders;
  final List<CategoriesModel> categories;
  final int unreadNotifications;
  final int unreadConversations;

  final bool appInReview;
  final String alternateCourseCost;
  final String iosUrl;
  final int iosVersionNumber;
  final String androidUrl;
  final int androidVersionNumber;
  final List<ProvidersModel> vendors;
  final String phoneNumber;
  final String whatsappNumber;
  final String email;
  final String location;
  final int totalItemsInCart;
  final VendorDataModel vendorData;

  @override
  List<Object?> get props => [
    sliders,
    unreadNotifications,
    categories,
    appInReview,
    alternateCourseCost,
    iosUrl,
    androidUrl,
    iosVersionNumber,
    androidVersionNumber,
    vendors,
    unreadConversations,
    phoneNumber,
    whatsappNumber,
    email,
    location,
    totalItemsInCart,
    vendorData,
  ];
}

class SlidersEntities extends Equatable {
  final int id;
  final String title;
  final String subtitle;
  final String cover;
  final String specialText;

  const SlidersEntities({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.cover,
    required this.specialText,
  });

  @override
  List<Object?> get props => [id, title, subtitle, cover, specialText];
}

class ProvidersEntities extends UserModel {
  const ProvidersEntities({
    required super.id,
    required super.name,
    required super.phone,
    required super.image,
    required super.status,
    required super.workingTime,
    required super.deliveryAvailable,
    required super.preparationTime,
    required super.city,
    required super.region,
    required super.accessToken,
    required super.userType,
    required this.storeDescription,
    required this.rate,
    required this.rateCounts,
    required this.isFavorite,
    required super.deliveryPrice,
    required super.coverImage,
  });

  final String storeDescription;
  final double rate;
  final int rateCounts;
  final bool isFavorite;

  @override
  List<Object?> get props => [
    id,
    name,
    phone,
    image,
    status,
    workingTime,
    deliveryAvailable,
    userType,
    preparationTime,
    city,
    region,
    accessToken,
    storeDescription,
    rate,
    rateCounts,
    isFavorite,
    deliveryPrice,
    coverImage,
  ];
}

class VendorDataEntities extends Equatable {
  final double allOrdersAmount;
  final double pendingOrdersAmount;
  final double approvedOrdersAmount;
  final double cancelledOrdersAmount;
  final double completedOrdersAmount;
  final int allOrdersCount;
  final int pendingOrdersCount;
  final int approvedOrdersCount;
  final int cancelledOrdersCount;
  final int completedOrdersCount;
  final String accountStatus;
  final List<OrdersModel> pendingOrdersList;

  const VendorDataEntities({
    required this.allOrdersAmount,
    required this.pendingOrdersAmount,
    required this.approvedOrdersAmount,
    required this.cancelledOrdersAmount,
    required this.completedOrdersAmount,
    required this.allOrdersCount,
    required this.pendingOrdersCount,
    required this.approvedOrdersCount,
    required this.cancelledOrdersCount,
    required this.completedOrdersCount,
    required this.accountStatus,
    required this.pendingOrdersList,
  });

  @override
  List<Object?> get props => [
    allOrdersAmount,
    pendingOrdersAmount,
    approvedOrdersAmount,
    cancelledOrdersAmount,
    completedOrdersAmount,
    allOrdersCount,
    pendingOrdersCount,
    approvedOrdersCount,
    cancelledOrdersCount,
    completedOrdersCount,
    accountStatus,
    pendingOrdersList,
  ];
}
