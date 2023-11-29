import 'package:flutter/material.dart';
import 'package:smarthome/Sua_TaiKhoan.dart';
import 'DK_TaiKhoan.dart';
import 'Profile.dart';
import 'Sua_TaiKhoan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => SuaTaiKhoan(),
        '/': (context) => QL_TaiKhoan(),
      },
      initialRoute: '/',
    );
  }
}
