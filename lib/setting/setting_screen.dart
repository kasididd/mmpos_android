import 'package:MMPOS/layout/phon_table/phone_table.dart';
import 'package:MMPOS/setting/backend/account/account_screen.dart';
import 'package:MMPOS/setting/backend/bill/bill_setting.dart';
import 'package:MMPOS/setting/backend/payment/payment_setting.dart';
import 'package:MMPOS/setting/backend/print/printer_screen.dart';
import 'package:MMPOS/setting/backend/print/printer_setting.dart';
import 'package:MMPOS/setting/backend/shop/shop_setting.dart';
import 'package:MMPOS/widget/new_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

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
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MediaQuery.of(context).size.width >
                        MediaQuery.of(context).size.height
                    ? NewMain()
                    : PhoneTable(),
              ));
            },
          );
        }),
        backgroundColor: Colors.white,
        toolbarHeight: 35,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'ตั้งค่าร้านค้า',
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
      ),
      //APPBAR STOP
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: Container(
                width: 25,
                height: 25,
                child: Image.asset('assets/icons/shop.png'),
              ),
              title: Text('หน้าร้าน'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ShopScreen(),
                ));
              },
            ),
            ListTile(
              leading: Container(
                width: 25,
                height: 25,
                child: Image.asset('assets/icons/language.png'),
              ),
              title: Text('ตั้งค่าภาษา'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Scaffold(),
                ));
              },
            ),
            ListTile(
              leading: Container(
                width: 25,
                height: 25,
                child: Image.asset('assets/icons/bill.png'),
              ),
              title: Text('ใบเสร็จรับเงิน'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BlindPaymentSetting(),
                ));
              },
            ),
            ListTile(
              leading: Container(
                width: 25,
                height: 25,
                child: Image.asset('assets/icons/credit.png'),
              ),
              title: Text('การชำระเงิน'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PaymentSetting(),
                ));
              },
            ),
            ListTile(
              leading: Container(
                width: 25,
                height: 25,
                child: Image.asset('assets/icons/dollar.png'),
              ),
              title: Text('จัดการเงินสด'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Scaffold(),
                ));
              },
            ),
            ListTile(
              leading: Container(
                width: 25,
                height: 25,
                child: Image.asset('assets/icons/printer.jpg'),
              ),
              title: Text('เครื่องพิมพ์และเครื่องอ่านบาร์โค้ด'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PrinterSetting(),
                ));
              },
            ),
            ListTile(
              leading: Container(
                width: 25,
                height: 25,
                child: Image.asset('assets/icons/display.png'),
              ),
              title: Text('จอแสดงผลฝั่งลูกค้า'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Scaffold(),
                ));
              },
            ),
            ListTile(
              leading: Container(
                width: 25,
                height: 25,
                child: Image.asset('assets/icons/account.png'),
              ),
              title: Text('พนักงาน'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Scaffold(),
                ));
              },
            ),
            ListTile(
              leading: Container(
                width: 25,
                height: 25,
                child: Image.asset('assets/icons/cloud.png'),
              ),
              title: Text('สำรองข้อมูล & กู้คืนข้อมูล'),
              onTap: () {},
            ),
            ListTile(
              leading: Container(
                width: 25,
                height: 25,
                child: Image.asset('assets/icons/connect.png'),
              ),
              title: Text('การเชื่อมต่อข้อมูล'),
              onTap: () {},
            ),
            ListTile(
              leading: Container(
                width: 25,
                height: 25,
                child: Image.asset('assets/icons/account_setting.png'),
              ),
              title: Text('บัญชีร้านค้า'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AccountSetting(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
