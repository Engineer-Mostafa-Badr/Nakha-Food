import 'package:flutter/material.dart';
import 'package:nakha/core/utils/most_used_functions.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import 'utils/pusher_constant.dart';

class PusherServices {
  PusherServices({required this.chatChannelName, required this.onEvent}) {
    connectToPusherChat();
  }

  late String chatChannelName;

  Function(PusherEvent)? onEvent;

  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  // fetch pusher credentials from server
  void connectToPusherChat() async {
    await pusher.init(
      apiKey: PusherConstant.pusherAppKey,
      cluster: PusherConstant.pusherAppCluster,
      onEvent: onEvent,
      onConnectionStateChange: onConnectionStateChange,
      onSubscriptionSucceeded: onSubscriptionSucceeded,
      onError: (error, stackTrace, s) {
        MostUsedFunctions.printFullText('onError: $error');
      },
      onMemberAdded: (s, event) {
        MostUsedFunctions.printFullText('onMemberAdded: $s event: $event');
      },
    );
    debugPrint('chatChannelName: $chatChannelName');
    await pusher.subscribe(channelName: chatChannelName);
    await pusher.connect();
  }

  // disconnect from pusher ====>>>
  void disconnectFromPusher() async {
    await pusher.unsubscribe(channelName: chatChannelName);
    await pusher.disconnect();
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    MostUsedFunctions.printFullText(
      'onSubscriptionSucceeded: $channelName data: $data',
    );
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    MostUsedFunctions.printFullText('Connection: $currentState');
  }
}
