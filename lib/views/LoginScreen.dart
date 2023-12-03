import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'AccountManage.dart';
import 'DK_TaiKhoan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 53, 71, 1),
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
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Email',
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
            SizedBox(height: 20),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   child: TextField(
            //     obscureText: true,
            //     decoration: InputDecoration(
            //       labelText: 'Số điện thoại',
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
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
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(children: [
                  ElevatedButton(
                    onPressed: () {
                      requestLogin(
                          _usernameController.text, _usernameController.text);
                      sendNotification("1569hDWLkyb5ICqvXyzUEdOvixG3",
                          _usernameController.text, _usernameController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(77, 101, 125, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: Size(150, 50),
                    ),
                    child: Text(
                      'Đăng Nhập',
                      style: TextStyle(
                        color: Color.fromRGBO(193, 228, 255, 1),
                      ),
                    ),
                  ),
                ]),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DkTaiKhoan()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(77, 101, 125, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: Size(150, 50),
                      ),
                      child: Text(
                        'Đăng kí',
                        style: TextStyle(
                          color: Color.fromRGBO(193, 228, 255, 1),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void requestLogin(String email, String username) {
    if (email != "thanhkiet.101023@gmail.com") {
      // Gửi yêu cầu đăng nhập đến tài khoản "thanhkiet.1023@gmail.com"
      final data = {
        'email': email,
        'username': username,
      };

      FirebaseFirestore.instance
          .collection('login_requests')
          .add(data)
          .then((value) {
        print('Yêu cầu đăng nhập đã được gửi thành công');
      }).catchError((error) {
        print('Lỗi khi gửi yêu cầu đăng nhập: $error');
      });
    } else {
      // Đăng nhập thành công, chuyển tới trang chủ
      loginWithEmailPassword(
          _usernameController.text, _passwordController.text);
      signIn(
          _usernameController.text,
          _passwordController
              .text); // Hàm chuyển tới trang chủ, bạn cần thay thế tên hàm này bằng hàm thật của bạn
    }
  }

  void sendNotification(
      String receiverToken, String senderEmail, String senderUsername) {
    // Gửi thông báo đến thiết bị của tài khoản khác
    final notification = {
      'title': 'Yêu cầu đăng nhập mới',
      'body': 'Tài khoản $senderEmail muốn đăng nhập vào ứng dụng',
    };

    final data = {
      'email': senderEmail,
      'username': senderUsername,
    };

    final message = {
      'token': receiverToken,
      'notification': notification,
      'data': data,
    };

    FirebaseFirestore.instance
        .collection('notifications')
        .add(message)
        .then((value) {
      print('Thông báo đã được gửi thành công');
    }).catchError((error) {
      print('Lỗi khi gửi thông báo: $error');
    });
  }

  Future<void> loginWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Người dùng đã đăng nhập thành công
      // Chuyển hướng đến trang chủ hoặc thực hiện các tác vụ liên quan
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => QL_TaiKhoan()),
      );
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Lỗi đăng nhập: $e');
    }
  }

  void signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //_usernameController.text = "DNTC";
      StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data == null) {
              return DkTaiKhoan();
            } else
              return QL_TaiKhoan();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      // Đăng nhập thành công
    } catch (e) {
      // Xử lý lỗi nếu có
    }
  }
}
