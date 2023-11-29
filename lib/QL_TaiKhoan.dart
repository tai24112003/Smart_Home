import 'package:flutter/material.dart';
import 'DK_TaiKhoan.dart';

class QL_TaiKhoan extends StatefulWidget {
  const QL_TaiKhoan({super.key});

  @override
  State<QL_TaiKhoan> createState() => _QL_TaiKhoanState();
}

class _QL_TaiKhoanState extends State<QL_TaiKhoan> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/img/1.jpg"),
              ),
              title: Text('Nguyễn Thanh Kiệt'),
              subtitle: Text('Xem thêm'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DkTaiKhoan()),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
