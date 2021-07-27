import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:firebase_messaging_sample/pages/home.dart';
import 'package:flutter/material.dart';

/*
 * 앱이 백그라운드 상태일 때 메시지 처리
 * https://firebase.google.com/docs/cloud-messaging/js/receive
 */
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  print(message.data.toString());
  print(message.notification!.title);
}

/*
 * 현재 등록 토큰 가져오기
 * https://firebase.google.com/docs/cloud-messaging/android/client?hl=ko#retrieve-the-current-registration-token
 */
Future<void> _getToken() async {
  try {
    String? token = await FirebaseMessaging.instance.getToken();
    print("token : $token");
  } catch (e) {}
}

void main() async{
  // initialize
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // token
  _getToken();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(title: 'Firebase Messaging Sample'),
    );
  }
}
