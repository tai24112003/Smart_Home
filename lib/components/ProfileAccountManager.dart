import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:smarthome/components/ProfileAccountCard.dart';

class ProfileAccountScreen extends StatefulWidget {
  const ProfileAccountScreen({super.key});

  @override
  State<ProfileAccountScreen> createState() => _ProfileAccountScreenState();
}

class _ProfileAccountScreenState extends State<ProfileAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(30, 53, 71, 1.0),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Icon(Icons.add,color: Colors.white,size: 50,),
              )
            ],),
              PhysicalModel(
                 elevation: 8.0,
                color: const Color.fromRGBO(26, 42, 57, 1.0),
                borderRadius: BorderRadius.circular(15),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  height: 500,
                  width: MediaQuery.of(context).size.width*0.8,
                  
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                       ProfileAccountCard()
                        
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}