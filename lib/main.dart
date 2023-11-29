import 'package:flutter/material.dart';
import 'DK_TaiKhoan.dart';
import 'QL_TaiKhoan.dart';

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
        '/': (context) => DkTaiKhoan(),
        '/home': (context) => QL_TaiKhoan(),
      },
      initialRoute: '/',
    );
  }
}
