import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smarthome/components/BottomNav.dart';
import 'package:smarthome/models/room.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:smarthome/views/LoginScreen.dart';

class AccountInfo {
  final String name;
  final String email;

  AccountInfo({required this.name, required this.email});
}

class AccountTabBar extends StatefulWidget {
  _AccountTabBarState createState() => _AccountTabBarState();
}

class _AccountTabBarState extends State<AccountTabBar> {
  late String displayName = "";
  late String email = "";
  late Device device;
  @override
  void initState() {
    super.initState();
    _databaseReference.child("system_lock").onValue.listen((event) {
      var snapshot = event.snapshot;
      setState(() {
        status = snapshot.value == true;
      });
    });
    // Lấy thông tin người dùng hiện tại một lần
    loadUserData();
  }

  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();
  Future<void> _updateFirebaseStatus(String key, bool status) async {
    try {
      await _databaseReference.update({key: status});
      print("Firebase update successful");
    } catch (error) {
      print("Error updating Firebase: $error");
    }
  }

  bool status = false;

  Future<void> loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (snapshot.exists) {
        var userData = snapshot.data()!;
        setState(() {
          displayName = userData['displayName'] ?? 'Không có tên hiển thị';
          email = userData['email'] ?? 'Không có email';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //_configureFirebaseMessaging();
    return DefaultTabController(
      length: 2, // Số lượng TabBar
      child: Scaffold(
        bottomNavigationBar: BottomAppBarCustom(active: 1),
        backgroundColor: const Color.fromRGBO(30, 53, 71, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(30, 53, 71, 1.0),
          title:Row(
            children: [
              Image.asset(
                'assets/img/logo.jpg', 
                height: 60,
                width: 60, 
              ),
              const SizedBox(width: 10), 
              const Text('Trang cá nhân',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
            ],
          ),
          bottom: TabBar( 
            tabs: [
              Tab(
                text: 'Thông tin người dùng',
              ),
              Tab(
                text: 'Quản lí người dùng',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
                color: Color.fromRGBO(30, 53, 71, 1.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 220,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(26, 42, 57, 1),
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Tên: $displayName',
                                style: TextStyle(color: Colors.white)),
                            Text('Email: $email',
                                style: TextStyle(color: Colors.white)),
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          status == true ? Icons.lock : Icons.lock_open,
                          color: status == true ? Colors.red : Colors.green,
                        ),
                        Switch(
                          value: status,
                          onChanged: (value) {
                            status = value;
                            _updateFirebaseStatus("system_lock", status);
                          },
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.directions_run_rounded,
                                  color: Colors.red),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Xác nhận đăng xuất'),
                                      content: Text(
                                          'Bạn có chắc chắn muốn đăng xuất?'),
                                      actions: [
                                        TextButton(
                                          child: Text('Hủy'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Đăng Xuất'),
                                          onPressed: () async {
                                            try {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginPage()));
                                              // Thực hiện các thao tác sau khi đăng xuất thành công
                                            } catch (e) {
                                              print('Lỗi đăng xuất: $e');
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "Đăng xuất",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                  fixedSize: MaterialStatePropertyAll(
                                      Size.fromWidth(
                                          MediaQuery.of(context).size.width *
                                              0.7)),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.red)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Đã xảy ra lỗi');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text('Không có người dùng');
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    String displayName = document['displayName'];
                    String userEmail = document['email'];
                    return Card(
                      color: Color.fromRGBO(30, 53, 71, 1),
                      child: ListTile(
                        title: Text(displayName,
                            style: TextStyle(color: Colors.white)),
                        subtitle: Text(userEmail,
                            style: TextStyle(color: Colors.white)),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.white,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Xác nhận xóa người dùng'),
                                content: Text(
                                    'Bạn có chắc chắn muốn xóa người dùng $userEmail?'),
                                actions: [
                                  TextButton(
                                    child: Text('Hủy'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Xóa'),
                                    onPressed: () {
                                      deleteUser(userEmail);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  // String getUserDisplayName(String userId) {
  //   String displayName = '';
  //   String documentPath = 'users';
  //   if (documentPath.isNotEmpty) {
  //     FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userId)
  //         .get()
  //         .then((doc) {
  //       if (doc.exists) {
  //         displayName = doc.data()!['displayName'];
  //       }
  //     });
  //   } else {
  //     print('Đường dẫn tài liệu không được để trống');
  //   }
  //   return displayName;
  // }
  void signOutCurrentUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      print('Đăng xuất thành công');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      // Thực hiện các thao tác sau khi đăng xuất thành công
    } catch (e) {
      print('Lỗi đăng xuất: $e');
    }
  }

  void deleteUser(String email) async {
    try {
// Lấy thông tin người dùng dựa trên email
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Lấy ID của người dùng
        String userId = querySnapshot.docs.first.id;

        // Xóa người dùng khỏi Firebase Authentication
        await FirebaseAuth.instance.currentUser?.delete();

        // Xóa người dùng khỏi Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .delete();

        print('Người dùng đã bị xóa thành công');
      } else {
        print('Không tìm thấy người dùng với email $email');
      }
    } catch (e) {
      print('Lỗi xóa người dùng: $e');
    }
  }
}
