// ignore: file_names
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:smarthome/models/room.dart';

class HomeScreenDetail extends StatefulWidget {
  const HomeScreenDetail({required this.rooms, Key? key}) : super(key: key);
  final Room rooms;

  @override
  State<HomeScreenDetail> createState() => _HomeScreenDetailState();
}

class _HomeScreenDetailState extends State<HomeScreenDetail> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: const Color.fromRGBO(30, 53, 71, 1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(123, 122, 114, 0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                border: Border.all(color: Colors.blue, width: 2.0),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.wifi,
                    color: Colors.yellow,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(123, 122, 114, 0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: Colors.yellowAccent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: MediaQuery.of(context).size.width * 0.48,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Tổng số thiết bị: ${widget.rooms.devices.length}",
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            OutlinedButton(
              onPressed: () {},
              child: Text(
                "Xem chi tiết",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
