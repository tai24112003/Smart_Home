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

Future<void> _updateFirebaseStatusI(String key, int status) async {
  try {
    await _databaseReference.update({key: status});
    print("Firebase update successful");
  } catch (error) {
    print("Error updating Firebase: $error");
  }
}

class _DevicceItemState extends State<DevicceItem> {
  bool status = false;
  double _sliderValue = 255;
  @override
  Widget build(BuildContext context) {
    IconData iconW = Icons.lightbulb;
    switch (widget.device.type) {
      case "led":
        iconW = Icons.lightbulb;
        break;
      case "servo":
        iconW = Icons.settings;
        break;
      case "btn":
        iconW = Icons.radio_button_checked;
        break;
      case "screen":
        iconW = Icons.screenshot_monitor_rounded;
    }
    return Container(
      height: 125,
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
                  Icon(
                    iconW,
                    size: 50,
                    color: Color.fromRGBO(0, 0, 0, _sliderValue / 255),
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
              child: widget.device.type != "btn"
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        widget.device.type.contains("screen")
                            ? Text("")
                            : !widget.device.id.contains("ngu")
                                ? Text(
                                    !status ? "Off" : "On",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange),
                                    maxLines: 1,
                                  )
                                : Text(
                                    _sliderValue.ceil().toString(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange),
                                    maxLines: 1,
                                  ),
                        widget.device.type.contains("screen")
                            ? Text(
                                widget.device.description,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                
                              )
                            : !widget.device.id.contains("ngu")
                                ? Switch(
                                    value: status,
                                    onChanged: (value) {
                                      setState(() {
                                        status = value;
                                      });
                                      _updateFirebaseStatus(
                                          widget.device.id, status);
                                    },
                                  )
                                : SizedBox(
                                    child: Slider(
                                      min: 0,
                                      max: 255,
                                      value: _sliderValue,
                                      onChanged: (value) {
                                        setState(() {
                                          _sliderValue = value;
                                        });
                                      },
                                      onChangeEnd: (a) {
                                        _updateFirebaseStatusI(
                                            widget.device.id, a.round());
                                      },
                                    ),
                                  ),
                        Text(
                          maxLines: 1,
                          widget.device.id.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                      maxLines: 1,
                      widget.device.description,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _databaseReference.child(widget.device.id).onValue.listen((event) {
      var snapshot = event.snapshot;
      if (mounted)
        setState(() {
          // Ensure the value is not null before parsing
          if (snapshot.value != null) {
            try {
              !widget.device.id.contains("ngu")
                  ? status = snapshot.value == true
                  : _sliderValue = double.parse(snapshot.value.toString());
            } catch (e) {
              print("Error parsing double: $e");
              // Handle the error (e.g., set a default value)
              _sliderValue =
                  255; // Set a default value or handle it according to your requirements
            }
          } else {
            // Handle the case where the snapshot value is null
            _sliderValue =
                255; // Set a default value or handle it according to your requirements
          }
        });
      else {
        // Handle the case where the snapshot value is null
        _sliderValue =
            0.0; // Set a default value or handle it according to your requirements
      }
    });
  }
}
