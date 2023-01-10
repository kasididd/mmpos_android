import 'package:MMPOS/auth/login_screen.dart';
import 'package:MMPOS/provider/store.dart';
import 'package:MMPOS/setting/setting_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hidden_drawer/flutter_hidden_drawer.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({super.key});

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //APPBAR START
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.red,
              size: 20, // Changing Drawer Icon Size
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingScreen()));
            },
          );
        }),
        backgroundColor: Colors.white,
        toolbarHeight: 35,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'ตั้งค่าร้านแอคเค้าท์',
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
      ),
      //APPBAR STOP

      //BODY START
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Container(
              color: Colors.red,
              width: 150,
              height: 50,
              child: Image.network(
                context.watch<Store>().userData![0]['image'],
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text('ชื่อแอพ'),
          Text(FirebaseAuth.instance.currentUser!.email.toString()),
          SizedBox(
            height: 50,
          ),
          Column(
            children: [
              TextButton(
                onPressed: () {
                  try {
                    FirebaseAuth.instance.signOut();
                  } catch (e) {
                    print(e);
                  }
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
                },
                child: Text(
                  'ออกจากระบบ',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          )
        ],
      ),
      //BODY STOP
    );
  }
}
