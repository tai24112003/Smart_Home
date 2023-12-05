import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:smarthome/models/db_reader.dart';

class Device {
  final String id;
  final String type;
  final String description;

  Device({
    required this.id,
    required this.type,
    required this.description,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      type: json['type'],
      description: json['description'] ?? '',
    );
  }
}

class Room {
  final String id;
  final String name;
  final List<Device> devices;
  final String img;

  Room(
      {required this.id,
      required this.name,
      required this.devices,
      required this.img});

  factory Room.fromJson(Map<String, dynamic> json) {
    try {
      var devicesList = json['devices'] as List;
      List<Device> devices =
          devicesList.map((device) => Device.fromJson(device)).toList();

      return Room(
          id: json['id'],
          name: json['name'],
          devices: devices,
          img: json['img']);
    } catch (e) {
      print("Lỗi khi ánh xạ JSON: $e");
      rethrow;
    }
  }

  static List<Room> rooms = [];
  static Future<void> getData() async {
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    try {
      DatabaseEvent snap = await reference.once();
      String str = jsonEncode(snap.snapshot.value);
      Map<String, dynamic> data = jsonDecode(str);
      rooms.clear();
      for (var entry in data['room']) {
        if (entry != null) {
          rooms.add(Room.fromJson(entry));
        }
      }
    } catch (error) {
      print('Error reading data: $error');
    }
  }
}
