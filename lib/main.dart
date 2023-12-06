import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smarthome/components/BottomNav.dart';
import 'package:smarthome/firebase_options.dart';
import 'package:smarthome/views/AccountManage.dart';
import 'package:smarthome/views/DK_TaiKhoan.dart';
import 'package:smarthome/views/HomeScreen.dart';
import 'package:smarthome/views/ProfileScreen.dart';
import './views/LoginScreen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => LoginPage(),
        "/dangki": (context) => DkTaiKhoan(),
        "/home": (context) => HomeScreen(),
        "/profile": (context) => AccountTabBar(),
      },
      initialRoute: '/',
    );
  }
}
