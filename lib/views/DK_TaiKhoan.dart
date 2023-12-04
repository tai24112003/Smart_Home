import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'LoginScreen.dart';

class DkTaiKhoan extends StatefulWidget {
  @override
  _DkTaiKhoanState createState() => _DkTaiKhoanState();
}

class _DkTaiKhoanState extends State<DkTaiKhoan> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _rePasword;
  late TextEditingController _displayName;
  @override
  void initState() {
    super.initState();
    _rePasword = TextEditingController();
    _usernameController = TextEditingController();
    _displayName = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _rePasword.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _displayName.dispose();
    super.dispose();
  }

  User? currentUser = FirebaseAuth.instance.currentUser;
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
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _displayName,
                decoration: InputDecoration(
                  labelText: 'DisplayName',
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
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _rePasword,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Xác nhận mật khẩu',
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
            ElevatedButton(
              onPressed: () {
                // if (_passwordController.text
                //         .compareTo(_passwordController.text) ==
                //     0) {
                registerWithEmailPassword(_usernameController.text,
                    _passwordController.text, _displayName.text);
                signUp(_usernameController.text, _passwordController.text);
                saveAccountInfo(
                    _usernameController.text, _passwordController.text);
                saveCredentials(
                    _usernameController.text, _passwordController.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
                // } else
                //   _rePasword.text = "Mật khẩu không chính xác";

                // Xử lý khi nút được nhấn
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(77, 101, 125, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(200, 50),
              ),
              child: Text(
                'Đăng kí',
                style: TextStyle(
                  color: Color.fromRGBO(193, 228, 255, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initializeFirebase() async {
    await Firebase.initializeApp();
  }

// Đăng ký tài khoản mới
  Future<void> registerWithEmailPassword(
      String email, String password, String displayName) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Lưu thông tin người dùng vào Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': email,
        'displayName': displayName,
      });

      // Người dùng đã được đăng ký thành công và thông tin đã được lưu vào Firestore
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Lỗi đăng ký: $e');
    }
  }

  void signUp(String email, String password) async {
    try {
      UserCredential? userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': email,
        'password': password,
      });
      saveCredentials(email, password);
      //saveUserToFirestore(userCredential.user);
      saveAccountInfo(email, password);
      // Đăng ký thành công, bạn có thể lưu thông tin tài khoản vào Firestore hoặc Realtime Database tại đây
    } catch (e) {
      // Xử lý lỗi nếu có
      print("Lỗi tạo tài khoản");
    }
  }

// Đăng nhập với tài khoản đã đăng ký

  void saveCredentials(String username, String password) async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'username': username,
        'password': password,
      });
    }
  }

  void saveAccountInfo(String username, String password) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.doc(uid).set({
        'username': username,
        'password': password,
      });
      print('Thông tin tài khoản đã được lưu trữ thành công!');
    } catch (error) {
      print('Đã xảy ra lỗi khi lưu thông tin tài khoản: $error');
    }
  }

  void saveUserToFirestore(User? user) async {
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': user.email,
          // 'password': user.,
          'name': user.displayName
          //Thêm các thuộc tính người dùng khác
        });
        print('Thông tin người dùng đã được lưu trữ trong Firestore!');
      } catch (error) {
        print('Đã xảy ra lỗi khi lưu trữ thông tin người dùng: $error');
      }
    } else {
      print('Không có người dùng hiện tại.');
    }
  }

  void checkAccountInFirestore() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();
        if (snapshot.exists) {
          print('Tài khoản đã được lưu trữ trong Firestore!');
        } else {
          print('Tài khoản chưa được lưu trữ trong Firestore.');
        }
      } catch (error) {
        print('Đã xảy ra lỗi khi kiểm tra tài khoản trên Firestore: $error');
      }
    } else {
      print('Không có người dùng hiện tại.');
    }
  }

  void addUserToFirestore(String email, String name) async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'email': email,
        'name': name,
        //Thêm các thuộc tính người dùng khác
      });
      print('Tài liệu người dùng đã được thêm vào Firestore!');
    } catch (error) {
      print('Đã xảy ra lỗi khi thêm tài liệu người dùng: $error');
    }
  }
}
