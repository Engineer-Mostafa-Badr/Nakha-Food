//app_id = "2036334"
// key = "1160bc5e875a61587ee2"
// secret = "ff670b5db1d17e85a578"
// cluster = "eu"
class PusherConstant {
  static const pusherAppId = '2036334';
  static const pusherAppKey = '1160bc5e875a61587ee2';
  static const pusherAppSecret = 'ff670b5db1d17e85a578';
  static const pusherHost = '';
  static const pusherPort = '443';
  static const pusherScheme = 'https';
  static const pusherAppCluster = 'eu';

  static String orderChatChannel(String orderId) => 'conversation.$orderId';

  static String ticketChatChannel(String ticketId) => 'ticket-$ticketId';
}
