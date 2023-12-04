import 'package:flutter/material.dart';
import 'package:smarthome/components/BottomNav.dart';
import 'package:smarthome/components/ProfileDetail.dart';
import 'package:smarthome/components/ProfileAccountManager.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
              const Text('Welcome Home',style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          ),
          bottom: TabBar(
            unselectedLabelColor: const Color.fromRGBO(77, 101, 125, 1.0),
            labelColor: Colors.white,
            splashBorderRadius: BorderRadius.circular(50),
            indicator: BoxDecoration(
                border: Border.all(color: Colors.blue),
                color: Color.fromRGBO(26, 42, 57, 1),
                borderRadius: BorderRadius.circular(50)),
            tabs: const [
              Tab(
                text: 'Account Info',
              ),
              Tab(text: 'Account Manager'),
            ],
          ),
        ),
        body: TabBarView(
          children: [ProfileDetail(), ProfileAccountScreen()],
        ),
        bottomNavigationBar: const BottomAppBarCustom(
          active: 1,
        ),
      ),
    );
  }
}
