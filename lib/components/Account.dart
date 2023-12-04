// import 'package:flutter/material.dart';
// import 'package:smarthome/views/DK_TaiKhoan.dart';

// class TaiKhoan extends StatelessWidget {
//   TaiKhoan({super.key, required this.Username, required this.path});
//   String Username, path = "";
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(35), // Bo góc với bán kính 10
//       ),
//       color: Color.fromRGBO(30, 53, 71, 1),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundImage: AssetImage(path),
//         ),
//         trailing: IconButton(
//           onPressed: () {},
//           icon: Icon(
//             Icons.settings,
//             color: Colors.white,
//           ),
//         ),
//         title: Text(
//           Username,
//           style: TextStyle(color: Colors.white),
//         ),
//         subtitle: Text('Xem thêm',
//             style: TextStyle(color: Color.fromRGBO(77, 101, 125, 1))),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => DkTaiKhoan()),
//           );
//         },
//       ),
//     );
//   }
// }
