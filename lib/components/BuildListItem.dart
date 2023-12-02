import 'package:flutter/material.dart';
import 'package:smarthome/components/DeviceItem.dart';
import 'package:smarthome/models/room.dart';

class BuildItem extends StatelessWidget {
  const BuildItem({super.key, required this.list});
  final List<Device>? list;
  @override
  Widget build(BuildContext context) {
    int count = list!.length;
    print(count);
    return Container(
      height: MediaQuery.of(context).size.height - // Set the height explicitly
          AppBar().preferredSize.height - // Consider the app bar height
          MediaQuery.of(context).padding.bottom, // Consider the bottom padding
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(5),
        itemCount: count,
        itemBuilder: (context, index) {
          if (count % 2 != 0 && index == count - 1) {
            return Row(
              children: [DevicceItem(device: list![index * 2])],
            );
          } else {
            return Row(
              children: [
                DevicceItem(device: list![index * 2]),
                DevicceItem(device: list![index * 2 + 1])
              ],
            );
          }
        },
      ),
    );
  }
}
