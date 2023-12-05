import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smarthome/firebase_options.dart';
import 'package:smarthome/views/AccountManage.dart';
import 'package:smarthome/views/HomeScreen.dart';
import 'package:smarthome/views/ProfileScreen.dart';
import 'package:smarthome/views/ProfileScreen.dart';
import './views/LoginScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  if (fcmToken != null) {
    print('Mã thông báo đăng ký của thiết bị: $fcmToken');
  } else {
    print('Không thể lấy mã thông báo đăng ký');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => LoginPage(),
        "/home": (context) => HomeScreen(),
        "/profile": (context) => AccountTabBar(),
      },
      initialRoute: '/',
    );
  }
}
