import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging_sample/services/local_notification_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();

    LocalNotificationService.initialize(context);

    //gives you the message on which user taps
    //and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if(message != null){
        final routeFromMessage = message.data["route"];
        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    //forground work
    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification != null){
        print('알림 메시지를 출력합니다. ');
        print(message.notification!.body);
        print(message.notification!.title);
      }

      LocalNotificationService.display(message);
    });

    //When the app is in background but opened and user taps
    //on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];

      Navigator.of(context).pushNamed(routeFromMessage);
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
            child: Text(
              "You will receive message soon",
              style: TextStyle(fontSize: 34),
            )),
      ),
    );
  }
}
