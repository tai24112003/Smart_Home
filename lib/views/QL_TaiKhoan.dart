import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountInfo {
  final String name;
  final String email;

  AccountInfo({required this.name, required this.email});
}

class AccountTabBar extends StatefulWidget {
  @override
  _AccountTabBarState createState() => _AccountTabBarState();
}

class _AccountTabBarState extends State<AccountTabBar> {
  int _currentIndex = 0;
  late Stream<QuerySnapshot> _accountsStream;
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _accountsStream =
        FirebaseFirestore.instance.collection('accounts').snapshots();
  }

  Future<void> _getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _currentUser = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Tab Bar'),
      ),
      body: Column(
        children: [
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  tabs: [
                    Tab(text: 'Thông tin tài khoản'),
                    Tab(text: 'Danh sách tài khoản'),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: 400, // Điều chỉnh chiều cao tùy ý
                  child: IndexedStack(
                    index: _currentIndex,
                    children: [
                      AccountInfoTab(currentUser: _currentUser),
                      AccountListTab(accountsStream: _accountsStream),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccountInfoTab extends StatelessWidget {
  final User currentUser;

  AccountInfoTab({required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Thông tin tài khoản hiện tại', style: TextStyle(fontSize: 20)),
        SizedBox(height: 10),
        Text('Tên: ${currentUser.displayName}'),
        Text('Email: ${currentUser.email}'),
        SizedBox(height: 20),
        Card(
          child: Column(
            children: [
              ListTile(
                title: Text('Thay đổi mật khẩu'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Xử lý khi nhấn vào "Thay đổi mật khẩu"
                },
              ),
              Divider(),
              ListTile(
                title: Text('Thay đổi tài khoản'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Xử lý khi nhấn vào "Thay đổi tài khoản"
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AccountListTab extends StatelessWidget {
  final Stream<QuerySnapshot> accountsStream;

  AccountListTab({required this.accountsStream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: accountsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final accounts = snapshot.data!.docs.map((doc) {
            return AccountInfo(
              name: doc['name'],
              email: doc['email'],
            );
          }).toList();

          return ListView.builder(
            itemCount: accounts.length,
            itemBuilder: (context, index) {
              final account = accounts[index];

              return Card(
                child: ListTile(
                  title: Text(account.name),
                  subtitle: Text(account.email),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Xử lý khi nhấn vào IconButton "Xóa tài khoản"
                    },
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Đã xảy ra lỗi: ${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }
}
