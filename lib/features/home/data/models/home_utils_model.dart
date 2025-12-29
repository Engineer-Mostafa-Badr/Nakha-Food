import 'package:nakha/features/home/data/models/categories_model.dart';
import 'package:nakha/features/home/domain/entities/home_utils_entities.dart';
import 'package:nakha/features/orders/data/models/orders_model.dart';
import 'package:nakha/features/profile/data/models/cars_model.dart';

class HomeModel extends HomeEntities {
  const HomeModel({
    required super.sliders,
    required super.unreadNotifications,
    required super.appInReview,
    required super.categories,
    required super.alternateCourseCost,
    required super.iosUrl,
    required super.androidUrl,
    required super.iosVersionNumber,
    required super.androidVersionNumber,
    required super.vendors,
    required super.phoneNumber,
    required super.whatsappNumber,
    required super.email,
    required super.location,
    required super.totalItemsInCart,
    required super.vendorData,
    required super.unreadConversations,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      sliders: List<SlidersModel>.from(
        json['sliders'].map((x) => SlidersModel.fromJson(x)),
      ),
      unreadNotifications: json['unread_notifications'] ?? 0,
      appInReview: json['in_review'] ?? false,
      alternateCourseCost: '${json['alternate_course_cost'] ?? 0}',
      iosUrl: json['ios_url'] ?? '',
      androidUrl: json['android_url'] ?? '',
      iosVersionNumber: json['ios_version_number'] ?? 1,
      androidVersionNumber: json['android_version_number'] ?? 1,
      vendors: List<ProvidersModel>.from(
        json['vendors']?.map((x) => ProvidersModel.fromJson(x)) ?? [],
      ),
      categories: List<CategoriesModel>.from(
        json['categories']?.map((x) => CategoriesModel.fromJson(x)) ?? [],
      ),
      phoneNumber: json['contact_phone_number'] ?? '',
      whatsappNumber: json['contact_whatsapp_number'] ?? '',
      email: json['contact_email'] ?? '',
      location: json['contact_location'] ?? '',
      totalItemsInCart: json['total_items_in_cart'] ?? 0,
      vendorData: VendorDataModel.fromJson(
        json['vendor_data'] is List ? {} : json['vendor_data'] ?? {},
      ),
      unreadConversations: json['unread_conversations'] ?? 0,
    );
  }

  // copyWith
  HomeModel copyWith({
    List<SlidersModel>? sliders,
    int? unreadNotifications,
    bool? appInReview,
    String? alternateCourseCost,
    String? iosUrl,
    String? androidUrl,
    int? iosVersionNumber,
    int? androidVersionNumber,
    List<ProvidersModel>? vendors,
    List<CategoriesModel>? categories,
    String? phoneNumber,
    String? whatsappNumber,
    String? email,
    String? location,
    int? totalItemsInCart,
    int? unreadConversations,
    VendorDataModel? vendorData,
  }) {
    return HomeModel(
      sliders: sliders ?? this.sliders,
      unreadNotifications: unreadNotifications ?? this.unreadNotifications,
      appInReview: appInReview ?? this.appInReview,
      alternateCourseCost: alternateCourseCost ?? this.alternateCourseCost,
      iosUrl: iosUrl ?? this.iosUrl,
      androidUrl: androidUrl ?? this.androidUrl,
      iosVersionNumber: iosVersionNumber ?? this.iosVersionNumber,
      androidVersionNumber: androidVersionNumber ?? this.androidVersionNumber,
      vendors: vendors ?? this.vendors,
      categories: categories ?? this.categories,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      email: email ?? this.email,
      location: location ?? this.location,
      totalItemsInCart: totalItemsInCart ?? this.totalItemsInCart,
      vendorData: vendorData ?? this.vendorData,
      unreadConversations: unreadConversations ?? this.unreadConversations,
    );
  }
}

class SlidersModel extends SlidersEntities {
  const SlidersModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.cover,
    required super.specialText,
  });

  factory SlidersModel.fromJson(Map<String, dynamic> json) {
    return SlidersModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      cover: json['cover'] ?? '',
      specialText: json['special_text'] ?? '',
    );
  }
}

class ProvidersModel extends ProvidersEntities {
  const ProvidersModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.isFavorite,
    required super.userType,
    required super.image,
    required super.status,
    required super.workingTime,
    required super.deliveryAvailable,
    required super.preparationTime,
    required super.city,
    required super.region,
    required super.accessToken,
    required super.storeDescription,
    required super.rate,
    required super.rateCounts,
    required super.deliveryPrice,
    required super.coverImage,
  });

  factory ProvidersModel.fromJson(Map<String, dynamic> json) {
    return ProvidersModel(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      status: json['status'] ?? '',
      userType: json['user_type'] ?? '',
      isFavorite: json['is_favorite'] ?? false,
      workingTime: json['working_time'] ?? '',
      deliveryAvailable: json['delivery_available'] == 1,
      preparationTime: json['preparation_time'] ?? 0,
      city: NameIdModel.fromJson(json['city'] ?? {}),
      accessToken: json['access_token'] ?? '',
      storeDescription: json['store_description'] ?? '',
      region: json['region'] != null
          ? NameIdModel.fromJson(json['region'])
          : null,
      rate: (json['rate'] ?? 0).toDouble(),
      rateCounts: json['rate_counts'] ?? 0,
      deliveryPrice: int.tryParse('${json['delivery_price'] ?? 0}') ?? 0,
      coverImage: json['cover_image'] ?? '',
    );
  }
}

class VendorDataModel extends VendorDataEntities {
  const VendorDataModel({
    required super.allOrdersAmount,
    required super.pendingOrdersAmount,
    required super.approvedOrdersAmount,
    required super.cancelledOrdersAmount,
    required super.completedOrdersAmount,
    required super.allOrdersCount,
    required super.pendingOrdersCount,
    required super.approvedOrdersCount,
    required super.cancelledOrdersCount,
    required super.completedOrdersCount,
    required super.accountStatus,
    required super.pendingOrdersList,
  });

  // "vendor_data": {
  //       "all_orders_amount": 6050,
  //       "pending_orders_amount": 100,
  //       "approved_orders_amount": 5900,
  //       "cancelled_orders_amount": 0,
  //       "completed_orders_amount": 50,
  //       "all_orders_count": 3,
  //       "pending_orders_count": 1,
  //       "approved_orders_count": 1,
  //       "cancelled_orders_count": 0,
  //       "completed_orders_count": 1,
  //       "account_status": "active",
  //       "pending_orders_list": [
  //         {
  //           "id": 20,
  //           "order_number": "ORD-250817-5368",
  //           "subtotal": "100.00",
  //           "tax": "0.00",
  //           "total": "100.00",
  //           "status": "pending",
  //           "street_name": "s",
  //           "location_desc": "sssssss",
  //           "created_at": "2025-08-17 11:16 ص",
  //           "time": "11:16 ص",
  //           "lat": "24.71406964",
  //           "lng": "46.68849647",
  //           "cancelled_at": null,
  //           "cancelled_by": null,
  //           "cancelled_reason": null,
  //           "step": 0,
  //           "order_timer": "2025-08-17T09:16:05.000000Z",
  //           "user": {
  //             "id": 2,
  //             "name": "مطبخ سارة",
  //             "phone": "0522222222",
  //             "image": "http://nakha.test/images/default/image.jpg",
  //             "status": "active",
  //             "user_type": "vendor"
  //           },
  //           "items": [
  //             {
  //               "id": 18,
  //               "product_id": 4,
  //               "vendor_id": 2,
  //               "qty": 2,
  //               "price": "50.00",
  //               "subtotal": "100.00",
  //               "tax": "0.00",
  //               "total": "100.00",
  //               "product": {
  //                 "id": 4,
  //                 "name": "كعك العيد",
  //                 "price": "50.00",
  //                 "description": "كعك العيد",
  //                 "preparation_msg": "3",
  //                 "created_at": "2025-08-14 6:08 ص",
  //                 "delivery_available": 1,
  //                 "rate": 0,
  //                 "rate_counts": 0,
  //                 "provider": {
  //                   "id": 2,
  //                   "name": "مطبخ سارة"
  //                 },
  //                 "image": "http://nakha.test/images/default/image.jpg",
  //                 "images": [],
  //                 "is_favorite": false,
  //                 "favorite_count": 0,
  //                 "qty_in_cart": 0
  //               }
  //             }
  //           ],
  //           "rating_status": {
  //             "is_rated": false,
  //             "vendor_rated": false,
  //             "products_rated": 0,
  //             "all_rated": false
  //           }
  //         }
  //       ]
  //     }
  factory VendorDataModel.fromJson(Map<String, dynamic> json) {
    return VendorDataModel(
      allOrdersAmount: double.parse('${json['all_orders_amount'] ?? 0}'),
      pendingOrdersAmount: double.parse(
        '${json['pending_orders_amount'] ?? 0}',
      ),
      approvedOrdersAmount: double.parse(
        '${json['approved_orders_amount'] ?? 0}',
      ),
      cancelledOrdersAmount: double.parse(
        '${json['cancelled_orders_amount'] ?? 0}',
      ),
      completedOrdersAmount: double.parse(
        '${json['completed_orders_amount'] ?? 0}',
      ),
      allOrdersCount: json['all_orders_count'] ?? 0,
      pendingOrdersCount: json['pending_orders_count'] ?? 0,
      approvedOrdersCount: json['approved_orders_count'] ?? 0,
      cancelledOrdersCount: json['cancelled_orders_count'] ?? 0,
      completedOrdersCount: json['completed_orders_count'] ?? 0,
      accountStatus: json['account_status'] ?? '',
      pendingOrdersList: List<OrdersModel>.from(
        json['pending_orders_list']?.map((x) => OrdersModel.fromJson(x)) ?? [],
      ),
    );
  }
}
