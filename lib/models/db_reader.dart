import 'package:flutter/services.dart';

class InfoRender {
  Future<String> getInfo() async {
    String s = "";
    try {
      s = await rootBundle.loadString('data/room.json');
      return s;
    } catch (e) {
      return e.toString();
    }
  }
}
