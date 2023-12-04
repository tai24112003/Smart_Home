import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smarthome/firebase_options.dart';
<<<<<<< HEAD
import 'package:smarthome/views/AccountManage.dart';
=======
import 'package:smarthome/views/DK_TaiKhoan.dart';
>>>>>>> a0ee346095469ac0e6dd32305cfc74f2ebda4a70
import 'package:smarthome/views/DetailRoomScreen.dart';
import 'package:smarthome/views/HomeScreen.dart';
import 'package:smarthome/views/LoginScreen.dart';
import 'package:smarthome/views/ProfileScreen.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
<<<<<<< HEAD
      home: QL_TaiKhoan(),
=======
      home: LoginPage(),
>>>>>>> a0ee346095469ac0e6dd32305cfc74f2ebda4a70
      // routes: {
      //   "/home": (context) => HomeScreen(),
      //   "/profile": (context) => ProfileScreen(),
      // },
    );
  }
}
