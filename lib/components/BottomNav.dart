import 'package:flutter/material.dart';

class BottomAppBarCustom extends StatefulWidget {
  const BottomAppBarCustom({super.key, required this.active});
  final int active;
  @override
  State<BottomAppBarCustom> createState() => _BottomAppBarCustomState();
}

class _BottomAppBarCustomState extends State<BottomAppBarCustom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        child: BottomAppBar(
            color: const Color.fromRGBO(57, 87, 110, 1),
            height: MediaQuery.of(context).size.height / 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      if (widget.active != 0)
                        Navigator.pushReplacementNamed(context, "/home");
                    },
                    icon: Icon(
                      Icons.home,
                      color: widget.active == 0
                          ? const Color.fromRGBO(19, 44, 66, 1)
                          : Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      if (widget.active != 1)
                        Navigator.pushReplacementNamed(context, "/profile");
                    },
                    icon: Icon(
                      Icons.account_balance,
                      color: widget.active == 1
                          ? const Color.fromRGBO(19, 44, 66, 1)
                          : Colors.white,
                    )),
              ],
            )),
      ),
    );
  }
}
