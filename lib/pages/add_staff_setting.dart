import 'package:MMPOS/setting/setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserSetting extends StatefulWidget {
  const UserSetting({super.key});

  @override
  State<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  //VAL START
  bool val1 = false;
  bool val2 = false;
  bool val3 = false;
  bool val4 = false;
  bool val5 = false;
  bool val6 = false;
  bool val7 = false;
  bool val8 = false;
  bool val9 = false;
  bool val10 = false;
  bool val11 = false;
  bool val12 = false;
  bool val13 = false;
  bool val14 = false;
  bool val15 = false;

  //VAL STOP

  //FUNCTION START
  onChangeFunction1(bool newValue1) {
    setState(() {
      val1 = newValue1;
    });
  }

  onChangeFunction2(bool newValue2) {
    setState(() {
      val2 = newValue2;
    });
  }

  onChangeFunction3(bool newValue3) {
    setState(() {
      val3 = newValue3;
    });
  }

  onChangeFunction4(bool newValue4) {
    setState(() {
      val4 = newValue4;
    });
  }

  onChangeFunction5(bool newValue5) {
    setState(() {
      val5 = newValue5;
    });
  }

  onChangeFunction6(bool newValue6) {
    setState(() {
      val6 = newValue6;
    });
  }

  onChangeFunction7(bool newValue7) {
    setState(() {
      val7 = newValue7;
    });
  }

  onChangeFunction8(bool newValue8) {
    setState(() {
      val8 = newValue8;
    });
  }

  onChangeFunction9(bool newValue9) {
    setState(() {
      val9 = newValue9;
    });
  }

  onChangeFunction10(bool newValue10) {
    setState(() {
      val10 = newValue10;
    });
  }

  onChangeFunction11(bool newValue11) {
    setState(() {
      val11 = newValue11;
    });
  }

  onChangeFunction12(bool newValue12) {
    setState(() {
      val12 = newValue12;
    });
  }

  onChangeFunction13(bool newValue13) {
    setState(() {
      val13 = newValue13;
    });
  }

  onChangeFunction14(bool newValue14) {
    setState(() {
      val14 = newValue14;
    });
  }

  onChangeFunction15(bool newValue15) {
    setState(() {
      val15 = newValue15;
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
            Column(
              children: [
                //
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Center(
                          child: Center(
                              // child: Image.network(
                              //     'https://i.imgur.com/BwenN4o.png'),
                              ),
                        ),
                      )
                    ],
                  ),
                ),
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ชื่อพนักงาน"),
                    SizedBox(
                      width: 200,
                      height: 30,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Admin',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("รหัสผ่าน"),
                    SizedBox(
                      width: 200,
                      height: 30,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Admin',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                //
                SizedBox(
                  height: 50,
                ),
                //
                customSwitch('จัดการสินค้า', val1, onChangeFunction1),
                customSwitch('จัดการบิล', val2, onChangeFunction2),
                customSwitch('ยกเลิกการขาย', val3, onChangeFunction3),
                customSwitch('จัดการคลังสินค้า', val4, onChangeFunction4),
                customSwitch('เรียกดูรายงาน', val5, onChangeFunction5),
                customSwitch(
                  'ลูกค้า',
                  val6,
                  onChangeFunction6,
                ),
                customSwitch(
                  'การตั้งค่า',
                  val7,
                  onChangeFunction7,
                ),
                customSwitch(
                  'เปิดลิ้นชักเก็บเงิน',
                  val8,
                  onChangeFunction8,
                ),
                customSwitch(
                  'พนักงาน',
                  val9,
                  onChangeFunction9,
                ),
                customSwitch(
                  'แสดงกำไรที่ได้',
                  val10,
                  onChangeFunction10,
                ),
                //
                SizedBox(
                  height: 50,
                ),
                //
                customSwitch(
                  'สร้างเอกสารรับเข้า',
                  val11,
                  onChangeFunction11,
                ),
                customSwitch(
                  'แก้ไขเอกสารรับเข้า',
                  val12,
                  onChangeFunction12,
                ),
                customSwitch(
                  'สร้างเอกสารจ่ายออก',
                  val13,
                  onChangeFunction13,
                ),
                customSwitch(
                  'แก้ไขเอกสาราจ่ายออก',
                  val14,
                  onChangeFunction14,
                ),
                customSwitch(
                  'ปรับปรุงสต๊อก',
                  val15,
                  onChangeFunction15,
                ),
                //
                SizedBox(
                  height: 50,
                ),
                //
              ],
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
              onChanged: (newValue) {
                onChangeMethod(newValue);
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
