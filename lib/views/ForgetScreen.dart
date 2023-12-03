import 'package:flutter/material.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('root/assets/img/backgroundlogin.jpg'),
                fit: BoxFit.cover)),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Container(
                width: 450,
                height: 300,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Forget Password",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone_android_sharp,
                            color: Colors.white,
                          ),
                          label: Text(
                            'NumberPhone',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(95, 232, 219, 219)),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(95, 232, 219, 219),
                                  width: 2.0)),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.security,
                              color: Colors.white,
                            ),
                            label: Text(
                              'OTP',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(95, 232, 219, 219),
                                    width: 2.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(95, 232, 219, 219),
                                    width: 2.0))),
                      ),
                    ),
                    Padding(
                      padding:const EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                Colors.white.withOpacity(0.8),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all(const Size(139.0, 40.0)),
                            ),
                            onPressed: () => {},
                            child: const Text(
                              'Enter',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                         const SizedBox(width: 16.0),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                Colors.white.withOpacity(0.8),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            onPressed: () => {
                              Navigator.pushNamed(context, "/LoginScreen")
                            },
                            child: const Text(
                              'Back SignIn',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
