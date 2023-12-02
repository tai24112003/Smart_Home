import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smarthome/models/room.dart';

class DevicceItem extends StatefulWidget {
  const DevicceItem({super.key, required this.device});
  final Device device;
  @override
  State<DevicceItem> createState() => _DevicceItemState();
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

class _DevicceItemState extends State<DevicceItem> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width / 2) - 20,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: status == false
              ? Colors.white.withOpacity(0.8)
              : Colors.blueGrey.withOpacity(0.8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.lightbulb, size: 50),
                  Text(
                    "LED",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 100,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(status == false ? "Off" : "On",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange)),
                      Switch(
                        value: status,
                        onChanged: (value) {
                          setState(() {
                            status = value;
                          });
                          _updateFirebaseStatus(widget.device.id, status);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
