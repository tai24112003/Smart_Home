import 'package:flutter/material.dart';

class UserInFo extends StatelessWidget {
  UserInFo(
      {super.key,
      required this.id,
      required this.name,
      required this.nickName,
      required this.position,
      required this.path});
  String name, nickName, position, id, path = " ";
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage(path),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text(
                    "Name: " + name,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Row(
                children: [
                  Text("NickName: " + nickName,
                      style: TextStyle(color: Colors.white))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Position: " + position,
                      style: TextStyle(color: Colors.white))
                ],
              ),
              Row(
                children: [
                  Text("ID USER: " + id, style: TextStyle(color: Colors.white))
                ],
              )
            ],
          )
        ]);
  }
}
