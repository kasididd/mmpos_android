import 'dart:async';

import 'package:MMPOS/layout/phon_table/phone_table.dart';
import 'package:MMPOS/provider/store.dart';
import 'package:MMPOS/widget/new_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hidden_drawer/flutter_hidden_drawer.dart';
import '../page_backend/service_api.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MediaQuery.of(context).size.width >
                    MediaQuery.of(context).size.height
                ? NewMain()
                : PhoneTable(),
          ));
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    getAPI(context.watch<Store>());
    print('welcome');
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Colors.white,
            Color.fromARGB(255, 224, 108, 99),
          ])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Logo Start
              Center(
                child: Image.asset('assets/images/mmpos_outline_white.png'),
              ),
              //Logo Stop

              //Text Start
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'MMPOS',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                child: Text(
                  'Start Application',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => const LoginScreen()));
                    // print('complete');
                  },
                  child: Text(
                    'กำหลังเข้าสู่หน้าหลัก...',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
              //Text Stop
            ],
          )),
    );
  }

  getAPI(Store provider) async {
    print('open get API');
    try {
      print('trying...');
      List res = await UserStore.select();
      print(res);
      if (res.length > 0) {
        provider.getUserData(res);
        print(provider.userData);
      }
    } catch (e) {
      print("ไม่สามารถ รับค่าUsersจากserver เพราะ:$e");
    }
  }
}
