import 'package:flutter/material.dart';

class Lock extends StatelessWidget {
  Lock({super.key});
  TextEditingController _lock = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextField(
          style: TextStyle(color: Colors.white),
          controller: _lock,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Nhập mật khẩu',
            labelStyle: TextStyle(
              color: Color.fromRGBO(96, 130, 157, 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color.fromRGBO(156, 212, 255, 1), // Màu của border
                width: 2, // Độ dày của border
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color.fromRGBO(
                    156, 212, 255, 1), // Màu của border khi được chọn
                width: 2, // Độ dày của border
              ),
            ),
          ),
        ),
      ),
    );
  }
}
