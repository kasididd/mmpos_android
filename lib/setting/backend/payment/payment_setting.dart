
import 'package:MMPOS/setting/setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PaymentSetting extends StatefulWidget {
  const PaymentSetting({super.key});

  @override
  State<PaymentSetting> createState() => _PaymentSettingState();
}

class _PaymentSettingState extends State<PaymentSetting> {
  //VAL START
  bool credit = false;
  bool promtpay = false;
  bool cupong = false;
  bool mudjum = false;
  //VAL STOP

  //FUNCTION START
  onChangeFunction1(bool newValue1) {
    setState(() {
      credit = newValue1;
    });
  }

  onChangeFunction2(bool newValue1) {
    setState(() {
      promtpay = newValue1;
    });
  }

  onChangeFunction3(bool newValue1) {
    setState(() {
      cupong = newValue1;
    });
  }

  onChangeFunction4(bool newValue1) {
    setState(() {
      mudjum = newValue1;
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
          'การชำระเงิน',
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
      ),
      //APPBAR START

      //BODY START

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('ประเภทชำระเงิน'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customSwitch(
                      'บัตรเครดิต/เดบิต', credit, onChangeFunction1),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customSwitch('พร้อมเพย์', promtpay, onChangeFunction2),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customSwitch('คูปอง', cupong, onChangeFunction3),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customSwitch('มัดจำ', mudjum, onChangeFunction4),
                ),
              ],
            ),
          ),
        ],
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
              onChanged: (NewValue) {
                onChangeMethod(NewValue);
              })
        ],
      ),
    );
  }
  //WIDGET
}
