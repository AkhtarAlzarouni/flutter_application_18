import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_18/root/app_root.dart';
import 'firebase_options.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_handler);
  // AwesomeNotifications().initialize(null, channelGroups:[ debug: true);])
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    
);
AwesomeNotifications().initialize(
  // set the icon to null if you want to use the default app icon
  null,
  [
    NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white)
  ],
  // Channel groups are only visual and are not required
  channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: 'basic_channel_group',
        channelGroupName: 'Basic group')
  ],
  debug: true
);


String? token = await FirebaseMessaging.instance.getToken();
print(token);

FirebaseMessaging.onMessage.listen((message){
AwesomeNotifications().createNotification(content: NotificationContent(id: 10, channelKey: 'basic_channel',
 actionType: ActionType.Default,
 title: message.data["title"],
 body: message.data["body"]
 ));
});

  runApp(const AppRoot());
}
 Future<void> _handler(RemoteMessage message)async{
 AwesomeNotifications().createNotification(content: NotificationContent(id: 10, channelKey: 'basic_channel',
 actionType: ActionType.Default,
 title: message.data["title"],
 body: message.data["body"]
 ));
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 }