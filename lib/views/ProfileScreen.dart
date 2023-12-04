import 'package:flutter/material.dart';
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
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromRGBO(30, 53, 71, 1.0),
          title: const Text('Welcome Home'),
          bottom: TabBar(
            unselectedLabelColor:const Color.fromRGBO(77, 101, 125, 1.0),
            labelColor: Colors.white,
            splashBorderRadius: BorderRadius.circular(50),
            indicator: BoxDecoration(
              border: Border.all(color: Colors.blue),
              color:Color.fromRGBO(26, 42, 57, 1),
              borderRadius: BorderRadius.circular(50)
              
            ),
            tabs: const [
              Tab(text: 'Account Info',),
              Tab(text: 'Account Manager'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
              ProfileDetail(),
              ProfileAccountScreen()
          ],
          
        ),
      ),
    );
  }
}
