import 'package:MMPOS/layout/phon_table/phone_table.dart';
import 'package:MMPOS/widget/screens/bill/bill_page.dart';
import 'package:MMPOS/widget/screens/stock/stock.dart';
import 'package:MMPOS/setting/setting_screen.dart';
import 'package:MMPOS/widget/new_main.dart';
import 'package:MMPOS/widget/screens/customer/customer_page.dart';
import 'package:MMPOS/widget/screens/money/money_page.dart';
import 'package:MMPOS/widget/screens/productall/product_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key, required this.provider});
  final provider;
  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String? emailuser;
  @override
  void initState() {
    setState(() {
      emailuser = FirebaseAuth.instance.currentUser!.email.toString();
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context),
              buildMenuItem(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        child: (DrawerHeader(
          child: Container(
              // color: Color.fromARGB(255, 240, 240, 240),
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text('ไม่พบฐานข้อมูล'),
              ),
              Divider(),
              Center(
                child: Text(
                  'Admin',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              ),
              Center(
                child: Text(emailuser!),
              )
            ],
          )),
        )),
      );

  Widget buildMenuItem(BuildContext context) => Column(
        children: [
          //
          //
          ListTile(
            leading: Container(
              width: 25,
              height: 25,
              child: Image.asset('assets/icons/shop.png'),
            ),
            title: const Text('หน้าร้าน'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MediaQuery.of(context).size.width >
                        MediaQuery.of(context).size.height
                    ? NewMain()
                    : PhoneTable(),
              ));
            },
          ),
          ListTile(
            leading: Container(
              width: 25,
              height: 25,
              child: Image.asset('assets/icons/bill.png'),
            ),
            title: const Text('การจัดการบิล'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => BillPage()
                      // HistoryScreen(),
                      ));
            },
          ),
          ListTile(
            leading: Container(
              width: 25,
              height: 25,
              child: Image.asset('assets/icons/dashboard.png'),
            ),
            title: const Text('รายงาน'),
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
              child: Image.asset('assets/icons/stock.png'),
            ),
            title: const Text('คลังสินค้า'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StockPage(),
              ));
            },
          ),
          ListTile(
            leading: Container(
              width: 25,
              height: 25,
              child: Image.asset('assets/icons/account.png'),
            ),
            title: const Text('ลูกค้า'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CustomerPages(),
              ));
            },
          ),
          ListTile(
            leading: Container(
              width: 25,
              height: 25,
              child: Image.asset('assets/icons/all_stock.png'),
            ),
            title: const Text('สินค้าทั้งหมด'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductPages(),
              ));
            },
          ),
          ListTile(
            leading: Container(
              width: 25,
              height: 25,
              child: Image.asset('assets/icons/coins.png'),
            ),
            title: const Text('จัดการเงินสด'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MoneyPage(),
              ));
            },
          ),
          ListTile(
            leading: Container(
              width: 25,
              height: 25,
              child: Image.asset('assets/icons/setting.png'),
            ),
            title: const Text('การตั้งค่า'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SettingScreen(),
              ));
            },
          ),

          // //
          // ListTile(
          //   leading: const Icon(CupertinoIcons.square_arrow_left),
          //   title: const Text('ออกจากระบบ'),
          //   onTap: () {
          //     widget.provider.logOut();
          //     Navigator.of(context).push(MaterialPageRoute(
          //       builder: (context) => MyApp(),
          //     ));
          //   },
          // ),
          // //
        ],
      );
}
