// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: camel_case_types, duplicate_ignore, file_names

import 'package:flutter/material.dart';
class HomeScreen_Detail extends StatefulWidget {
  const HomeScreen_Detail({super.key});

  @override
  State<HomeScreen_Detail> createState() => _HomeScreen_DetailState();
}

// ignore: camel_case_types
class _HomeScreen_DetailState extends State<HomeScreen_Detail> {
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
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(123, 122, 114, 0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ], border: Border.all(color: Colors.blue, width: 2.0)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.lightbulb_sharp,
                    color: Colors.green,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(123, 122, 114, 0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15)),
                  width: MediaQuery.of(context).size.width * 0.48,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "Số thiết bị đang hoạt động: 15",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
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
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.yellowAccent,
                      borderRadius: BorderRadius.circular(15)),
                  width: MediaQuery.of(context).size.width * 0.48,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "Tổng số thiết bị: 15",
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            OutlinedButton(onPressed: (){}, child: Text("Xem chi tiết",style: TextStyle(color: Colors.white),),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),)
          ],
          
        ),
      ),
    );
  }
}
