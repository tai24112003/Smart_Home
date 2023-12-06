import 'package:flutter/material.dart';
import 'package:smarthome/components/BottomNav.dart';
import 'package:smarthome/components/HomeDetail.dart';
import 'package:smarthome/models/room.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List lstroom = List.filled(
      0,
      Room(
          id: '',
          name: '',
          devices: List.filled(0, Device(id: '', type: '', description: '')),
          img: ''));
  _loadata() {
    Room.getData().then((value) {
      setState(() {
        lstroom = Room.rooms;
      });
    });
  }

  User? currentUser = FirebaseAuth.instance.currentUser;
  User? user = FirebaseAuth.instance.currentUser;
  bool check = false;
  @override
  void initState() {
    super.initState();

    _loadata();
    setState(() {
      getUserAuthStatus();
    });
  }

  void getUserAuthStatus() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    String? email = currentUser?.email;
    String emailString = email!;
    bool barrier = false;
    bool isAuthed = await checkUserAuthedByEmail(emailString);
    if (isAuthed == false)
      _showCustomDialog(context, barrier);
    else
      barrier = true;
    // Tiếp tục xử lý dựa trên kết quả isAuthed
  }

  Future<bool> checkUserAuthedByEmail(String email) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: email)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            querySnapshot.docs.first;
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;
        bool auth = userData?['auth'] ?? false;
        return auth;
      } else {
        return false; // Không tìm thấy người dùng
      }
    } catch (e) {
      print('Lỗi khi kiểm tra quyền admin: $e');
      return false; // Xử lý lỗi
    }
  }

  Future<void> _showCustomDialog(BuildContext context, bool barrier) async {
    return showDialog(
      barrierDismissible: barrier,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width, vertical: 200),
          backgroundColor: Colors.red,
          title: Center(
              child: Text(
            "Chờ xác nhận",
            style: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  getUserAuthStatus();
                });
              },
              child: Text(
                "Đóng",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: lstroom.length,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(30, 53, 71, 1),
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromRGBO(30, 53, 71, 1.0),
          title: Row(
            children: [
              Image.asset(
                'assets/img/logo.jpg',
                height: 60,
                width: 60,
              ),
              const SizedBox(width: 10),
              const Text(
                'Welcome Home',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          bottom: TabBar(
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            labelPadding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            isScrollable: true,
            unselectedLabelColor: const Color.fromRGBO(77, 101, 125, 1.0),
            labelColor: Colors.white,
            splashBorderRadius: BorderRadius.circular(50),
            indicator: BoxDecoration(
                border: Border.all(color: Colors.blue),
                color: Color.fromRGBO(26, 42, 57, 1),
                borderRadius: BorderRadius.circular(50)),
            tabs: lstroom.map((room) => Tab(text: room.name)).toList(),
          ),
        ),
        body: TabBarView(
          children:
              lstroom.map((room) => HomeScreenDetail(rooms: room)).toList(),
        ),
        bottomNavigationBar: const BottomAppBarCustom(
          active: 0,
        ),
      ),
    );
  }
}
