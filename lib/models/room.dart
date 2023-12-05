import 'dart:convert';

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
    try {
      InfoRender render = InfoRender();
      String jsonString = await render.getInfo();

      List<dynamic> jsonData = json.decode(jsonString);
      // print("Dữ liệu JSON: $jsonData");

      rooms = jsonData.map((room) {
        var roomInstance = Room.fromJson(room);
        // print("Room ID: ${roomInstance.id}");
        // print("Room Name: ${roomInstance.name}");

        roomInstance.devices.forEach((device) {
          // print("  Device ID: ${device.id}");
          // print("  Device Type: ${device.type}");
          // print("  Device Description: ${device.description}");
        });

        return roomInstance;
      }).toList();
      // print(rooms[0].id);
    } catch (e) {
      print("Lỗi khi lấy dữ liệu: $e");
    }
  }
}
