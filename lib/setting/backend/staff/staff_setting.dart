import 'package:MMPOS/pages/add_staff_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class StaffSetting extends StatefulWidget {
  const StaffSetting({super.key});

  @override
  State<StaffSetting> createState() => _StaffSettingState();
}

class _StaffSettingState extends State<StaffSetting> {
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
              Navigator.of(context).pop();
            },
          );
        }),
        backgroundColor: Colors.white,
        toolbarHeight: 35,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'จัดการสินค้า',
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserSetting(),
                ));
              },
              child: Text(
                'เพิ่มพนักงาน',
                style: TextStyle(color: Colors.red),
              ))
        ],
      ),
      //APPBAR STOP
    );
  }
}
