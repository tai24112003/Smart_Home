import 'dart:html';

import 'package:flutter/material.dart';
import 'Profile.dart';

class SuaTaiKhoan extends StatefulWidget {
  @override
  _SuaTaiKhoanState createState() => _SuaTaiKhoanState();
}

class _SuaTaiKhoanState extends State<SuaTaiKhoan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              width: 200,
              height: 200,
              color: Colors.blue,
              child: Text(
                "LOGO",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Tên đăng nhập',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Số điện thoại',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu',
                          border: InputBorder.none,
                        ),
                      ),
                    )),
                    IconButton(
                      onPressed: () {
                        // Nhảy qua trang đổi mật khẩu
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QL_TaiKhoan()),
                );
              },
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    'Cập nhật',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
