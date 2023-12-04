import 'package:flutter/material.dart';
import 'package:smarthome/components/BottomNav.dart';
import 'package:smarthome/components/HomeDetail.dart';
import 'package:smarthome/models/room.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List lstroom = List.filled(
      0,
      Room(
          id: '',
          name: '',
          devices: List.filled(0, Device(id: '', type: '', description: ''))));
  _loadata() {
    Room.getData().then((value) {
      setState(() {
        lstroom = Room.rooms;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadata();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: lstroom.length,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(30, 53, 71, 1),
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromRGBO(30, 53, 71, 1.0),
          title: Row(
            children: [
              Image.asset(
                'root/assets/img/logo.jpg', 
                height: 60,
                width: 60, 
              ),
              const SizedBox(width: 10), 
              const Text('Welcome Home',style: TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
          bottom: TabBar(
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            labelPadding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            isScrollable: true,
            unselectedLabelColor: const Color.fromRGBO(77, 101, 125, 1.0),
            labelColor: Colors.white,
            splashBorderRadius: BorderRadius.circular(50),
            indicator: BoxDecoration(
                border: Border.all(color: Colors.blue),
                color: Color.fromRGBO(26, 42, 57, 1),
                borderRadius: BorderRadius.circular(50)),
            tabs: lstroom.map((room) => Tab(text: room.name)).toList(),
          ),
        ),
        body: TabBarView(
          children:
              lstroom.map((room) => HomeScreenDetail(rooms: room)).toList(),
        ),
        bottomNavigationBar: const BottomAppBarCustom(
          active: 0,
        ),
      ),
    );
  }
}
