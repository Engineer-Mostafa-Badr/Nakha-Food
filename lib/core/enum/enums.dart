enum RequestState { initial, loading, loaded, error }

extension RequestStateExtension on RequestState {
  bool get isLoading => this == RequestState.loading;

  bool get isLoaded => this == RequestState.loaded;

  bool get isError => this == RequestState.error;

  bool get isInitial => this == RequestState.initial;
}

enum UserRoleEnum { client, vendor }

enum NotificationsEnum {
  order,
  transaction,
  message,
  notification,
  service,
  offer,
  support,
}

enum MessageTypes { text, image, video, audio, file }

MessageTypes convertMessageType(String type) {
  switch (type) {
    case 'text':
      return MessageTypes.text;
    case 'image':
      return MessageTypes.image;
    case 'video':
      return MessageTypes.video;
    case 'audio':
      return MessageTypes.audio;
    case 'file':
      return MessageTypes.file;
    default:
      return MessageTypes.text;
  }
}

enum SocialProvidersEnum { google, apple }

enum PaymentMethodsEnum { direct, tamara, tabby }

enum UserTypeEnum { user, marketer, coordinator, trainer }

enum SubscribeStatusEnum { pending, done, in_progress, cancelled }

enum PayDirectlyButtonType { all_price, part_of_price }

enum OrderStatusFilterEnum {
  all_orders,
  pending_orders,
  accepted_orders,
  cancelled_orders,
}

enum OrdersStatusEnum { all, pending, approved, cancelled, completed }

enum AttachmentType { image, audio }

enum DeliveryAvailabilityEnum { delivery_open, delivery_closed }
