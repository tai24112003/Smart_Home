import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:smarthome/main.dart';

class BottomAppBarCustom extends StatefulWidget {
  const BottomAppBarCustom({super.key, required this.active});
  final int active;
  @override
  State<BottomAppBarCustom> createState() => _BottomAppBarCustomState();
}

final DatabaseReference _databaseReference =
    FirebaseDatabase.instance.reference();

class _BottomAppBarCustomState extends State<BottomAppBarCustom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        child: BottomAppBar(
            color: const Color.fromRGBO(57, 87, 110, 1),
            height: MediaQuery.of(context).size.height / 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      if (widget.active != 0)
                        Navigator.pushReplacementNamed(context, "/home");
                    },
                    icon: Icon(
                      Icons.home,
                      color: widget.active == 0
                          ? const Color.fromRGBO(19, 44, 66, 1)
                          : Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      if (widget.active != 1)
                        Navigator.pushReplacementNamed(context, "/profile");
                    },
                    icon: Icon(
                      Icons.account_balance,
                      color: widget.active == 1
                          ? const Color.fromRGBO(19, 44, 66, 1)
                          : Colors.white,
                    )),
              ],
            )),
      ),
    );
  }

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
    _databaseReference.child('baodong').onValue.listen((event) {
      var snapshot = event.snapshot;
      print('Giá trị từ Firebase: ${snapshot.value}');
      if (snapshot.value == true) {
        Future.delayed(Duration(seconds: 1), () {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 3,
              channelKey: 'basic_channel',
              title: "Khẩn cấp",
              body:"Tới công chuyện rồi thí chủ ơi!!! Cháy nhà",
              color: Colors.red,
            ),
          );
        });
        _showCustomDialog(context);
      }
    });
  }

  Future<void> _showCustomDialog(BuildContext context) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.red,
          title: Center(
              child: Text(
            "Khẩn Cấp",
            style: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Tới công chuyện rồi thí chủ ơi!!! Cháy nhà",
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              Image.asset("assets/img/baochay.jpg")
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _databaseReference.child('baodong').once().then((event) {
                  var snapshot = event.snapshot;
                  if (snapshot.value == false) {
                    Navigator.of(context).pop();
                  }
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
}

void main() async {
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
      )
    ],
    debug: true,
  );
}