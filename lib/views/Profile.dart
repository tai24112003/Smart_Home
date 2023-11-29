import 'package:flutter/material.dart';
import 'package:smarthome/components/Account.dart';
import 'package:smarthome/components/UserInfo.dart';
import '../DK_TaiKhoan.dart';

class QL_TaiKhoan extends StatefulWidget {
  const QL_TaiKhoan({super.key});

  @override
  State<QL_TaiKhoan> createState() => _QL_TaiKhoanState();
}

class _QL_TaiKhoanState extends State<QL_TaiKhoan> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Số lượng TabBar
      child: Scaffold(
        backgroundColor: Color.fromRGBO(30, 53, 71, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(26, 42, 57, 1),
          title: Text('Profile'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'User Info',
              ),
              Tab(
                text: 'User manage',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 220,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(26, 42, 57, 1),
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.all(20),
                    child: UserInFo(
                      id: "072019",
                      name: "Nguyễn Thanh Kiệt",
                      nickName: "ThanksKiet",
                      position: "Owner",
                      path: "assets/img/avatar.jpg",
                    )),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      child: Container(
                          width: MediaQuery.of(context).size.width / 1.3,
                          height: 35,
                          padding: EdgeInsets.only(top: 8.5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(26, 42, 57, 1),
                          ),
                          child: Text(
                            "Change Your Password",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      child: Container(
                          width: MediaQuery.of(context).size.width / 1.3,
                          height: 35,
                          padding: EdgeInsets.only(top: 8.5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(26, 42, 57, 1),
                          ),
                          child: Text(
                            "Change Your Name",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ],
                )
              ],
            ),

            SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(24, 44, 64, 1),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5))),
                            child: Text(
                              "Member",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ]),
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(26, 42, 57, 1),
                            borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TaiKhoan(
                              Username: "Nguyễn Thanh Kiệt",
                              path: "assets/img/avatar.jpg",
                            ),
                            TaiKhoan(
                                Username: "Nguyễn Tấn Tài",
                                path: "assets/img/avatar.jpg"),
                            TaiKhoan(
                                Username: "Đặng Minh Quân",
                                path: "assets/img/avatar.jpg"),
                            TaiKhoan(
                                Username: "Trương Tăng Chí Vĩnh",
                                path: "assets/img/avatar.jpg"),
                            TaiKhoan(
                                Username: "Nguyễn Bình Dương",
                                path: "assets/img/avatar.jpg")
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ]),
            ),
            // Nội dung Tab 2
          ],
        ),
      ),
    );
  }
}
