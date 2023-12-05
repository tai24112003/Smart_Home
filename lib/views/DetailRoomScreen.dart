import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smarthome/components/BuildListItem.dart';
import 'package:smarthome/components/DeviceItem.dart';
import 'package:smarthome/models/room.dart';

class DetailRoomScreen extends StatefulWidget {
  
  const DetailRoomScreen({super.key, required this.id});
  final id;
  @override
  State<DetailRoomScreen> createState() => _DetailRoomScreenState();
}

class _DetailRoomScreenState extends State<DetailRoomScreen> {
  Room?
      rooms; // Use nullable type since it might not find a room with the specified id
  List<Device> led = [];
  List<Device> motor = [];
  List<Device> btn = [];
  List<Device> lcd = [];
  void _loadData() {
    Room.getData().then((value) {
      setState(() {
        // Filter the room based on the condition
        rooms = Room.rooms.firstWhere((element) => element.id == "phongngu1",
            orElse: () => Room(id: "", name: "", img: "", devices: []));

        // Check if the room was found before accessing its devices
        if (rooms != null) {
          lcd = rooms!.devices
              .where((e) => e.type == "screen")
              .map((e) => Device(
                    id: e.id,
                    type: e.type,
                    description: e.description,
                  ))
              .toList();
          led = rooms!.devices
              .where((e) => e.type == "led")
              .map((e) => Device(
                    id: e.id,
                    type: e.type,
                    description: e.description,
                  ))
              .toList();
          btn = rooms!.devices
              .where((e) => e.type == "btn")
              .map((e) => Device(
                    id: e.id,
                    type: e.type,
                    description: e.description,
                  ))
              .toList();
          // motor = rooms!.devices
          //     .where((e) => e.type == "servo")
          //     .map((e) => Device(
          //           id: e.id,
          //           type: e.type,
          //           description: e.description,
          //         ))
          //     .toList();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(rooms?.devices);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(30, 53, 71, 1),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromRGBO(30, 53, 71, 1),
          height: MediaQuery.of(context).size.height,
          child: rooms != null
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 100,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Tổng các thiết bị",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    rooms!.devices.length.toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      BuildItem(list: led),
                      BuildItem(list: motor),
                      BuildItem(list: btn),
                      BuildItem(list: lcd)
                    ],
                  ),
                )
              : Center(
                  child: Text("Loading",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Set up a listener for real-time updates
    _loadData();
  }
}
