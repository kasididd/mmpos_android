import 'package:MMPOS/setting/setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StaffSetting extends StatefulWidget {
  const StaffSetting({super.key});

  @override
  State<StaffSetting> createState() => _StaffSettingState();
}

class _StaffSettingState extends State<StaffSetting> {
  //VAL START
  bool val1 = false;

  //VAL STOP

  //FUNCTION START
  onChangeFunction1(bool newValue1) {
    setState(() {
      val1 = newValue1;
    });
  }
  //FUNCTION STOP

  int select = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //APPBAR STOP
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
          'พนักงาน',
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
      ),
      //APPBAR START

      //BODY START

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 150,
              ),
              child: Column(
                children: [
                  //
                  SizedBox(
                    height: 50,
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Card(
                      elevation: 0,
                      child: customSwitch(
                          'เปิดระบบพนักงาน', val1, onChangeFunction1),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),

      //BODY STOP
    );
  }

  //WIDGET
  Widget customSwitch(String text, bool val, Function onChangeMethod) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Spacer(),
          CupertinoSwitch(
              trackColor: Colors.grey,
              activeColor: Colors.red,
              value: val,
              onChanged: (neValue) {
                onChangeMethod(neValue);
              })
        ],
      ),
    );
  }
  //WIDGET

  //SELECTOR

  GestureDetector selecter(BuildContext context, index, text1) {
    return GestureDetector(
      onTap: () => setState(() {
        select = index;
      }),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: (MediaQuery.of(context).size.width * .2 / 4) - 6,
          height: double.infinity,
          decoration: BoxDecoration(
              color: select == index ? Colors.white : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(3)),
          child: Center(
              child: Text(
            text1,
            style: TextStyle(fontSize: 10),
          )),
        ),
      ),
    );
  }

  //SELCTOR

}
