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
      height:
          125.0 * (list!.length / 2).ceil() + 20, // Consider the bottom padding
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(5),
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
