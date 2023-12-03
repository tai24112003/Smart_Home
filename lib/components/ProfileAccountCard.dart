import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProfileAccountCard extends StatefulWidget {
  const ProfileAccountCard({super.key});

  @override
  State<ProfileAccountCard> createState() => _ProfileAccountCardState();
}
enum SampleItem { itemOne, itemTwo, itemThree }
class _ProfileAccountCardState extends State<ProfileAccountCard> {
  SampleItem? selectedMenu;
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      elevation: 8.0,
      color: const Color.fromRGBO(26, 42, 65, 1.0),
      borderRadius: BorderRadius.circular(15),
            clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.8,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.account_circle_rounded,color: Colors.white,size: 35,),
            Text("Dang Minh Quan | #000001",style: TextStyle(color: Colors.white),),
            PopupMenuButton<SampleItem>(
              
              offset: const Offset(60, 35),
            icon: Icon(Icons.settings,color: Colors.white,size: 35,),
          initialValue: selectedMenu,
          onSelected: (SampleItem item) {
            setState(() {
              selectedMenu = item;
            });
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
            const PopupMenuItem<SampleItem>(
              value: SampleItem.itemOne,
              child: Text('Chỉnh sửa'),
            ),
            const PopupMenuItem<SampleItem>(
              value: SampleItem.itemTwo,
              child: Text('Cấp quyền'),
            ),
            const PopupMenuItem<SampleItem>(
              value: SampleItem.itemThree,
              child: Text('Khóa tài khoản'),
            ),
          ],
        ),
            Icon(Icons.delete,color: Colors.red,size: 35,),
          ],
        ),
      ),
    );
  }
}