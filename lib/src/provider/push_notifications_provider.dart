import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationsProvider {

  late AndroidNotificationChannel channel;
 FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

 void initNotifications () async {
   channel = const AndroidNotificationChannel(
     'high_importance_channel', // id
     'High Importance Notifications', // title
     description:
     'This channel is used for important notifications.', // description
     importance: Importance.high,
   );

   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
   await flutterLocalNotificationsPlugin
       .resolvePlatformSpecificImplementation<
       AndroidFlutterLocalNotificationsPlugin>()
       ?.createNotificationChannel(channel);

   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
     alert: true,
     badge: true,
     sound: true,
   );
 }

 void onMessageListener () {

   // RECIBIR NOTIFICACIONES EN SEGUNDO PLANO
   FirebaseMessaging.instance.getInitialMessage().then( (RemoteMessage? message) {
     if(message != null ) {
       print('Nueva notificacion: ${message}');
     }
   });

   //RECIBIR LAS NOTIFICACIONES EN PRIMER PLANO
   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
     RemoteNotification? notification = message.notification;
     AndroidNotification? android = message.notification?.android;
     if (notification != null && android != null) {
       flutterLocalNotificationsPlugin.show(
         notification.hashCode,
         notification.title,
         notification.body,
         NotificationDetails(
           android: AndroidNotificationDetails(
             channel.id,
             channel.name,
             channelDescription: channel.description,
             // TODO add a proper drawable resource to android, for now using
             //      one that already exists in example app.
             icon: 'launch_background',
           ),
         ),
       );
     }
   });

   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
     print('A new onMessageOpenedApp event was published!');
   });
 }

}