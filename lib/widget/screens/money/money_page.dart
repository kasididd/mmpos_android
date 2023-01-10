import 'package:MMPOS/provider/store.dart';
import 'package:MMPOS/widget/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hidden_drawer/flutter_hidden_drawer.dart';

class MoneyPage extends StatefulWidget {
  const MoneyPage({super.key});

  @override
  State<MoneyPage> createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  @override
  Widget build(BuildContext context) {
    Store provider = context.watch<Store>();
    return Scaffold(
      drawer: Drawer(
        child: DrawerWidget(provider: provider),
      ),
      //APPBAT START
      appBar: AppBar(
        //
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        //
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.red),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
          'จัดการเงินสด',
          style: TextStyle(color: Colors.black54, fontSize: 17),
        ),
        centerTitle: true,
      ),
      //APPBAR STOP

      //Body Start
      body: Column(
        children: [
          //
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 320,
                    height: 165,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'รอบการขายที่',
                                style: TextStyle(color: Colors.black54),
                              ),
                              Text(
                                '1',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          //
                          SizedBox(
                            height: 15,
                          ),
                          //
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'เงินทอนเริ่มต้น',
                                style: TextStyle(color: Colors.black54),
                              ),
                              Text(
                                '50',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          //
                          SizedBox(
                            height: 15,
                          ),
                          //
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'เวลาเปิดรอบขาย',
                                style: TextStyle(color: Colors.black54),
                              ),
                              Text(
                                'วันที่',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          //
                          SizedBox(
                            height: 15,
                          ),
                          //
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'เปิดรอบขายโดย',
                                style: TextStyle(color: Colors.black54),
                              ),
                              Text(
                                'พนักงาน',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          //
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),

          //Body 1 Stop

          SizedBox(
            height: 25,
          ),

          //Body 2 Start

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 320,
                    height: 155,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ยอดขายด้วยเงินสด',
                                style: TextStyle(color: Colors.black54),
                              ),
                              Text(
                                '0.00',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          //
                          SizedBox(
                            height: 15,
                          ),
                          //
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ยอดรวมเงินเข้า',
                                style: TextStyle(color: Colors.black54),
                              ),
                              Text(
                                '0.00',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          //
                          SizedBox(
                            height: 15,
                          ),
                          //
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ยอมรวมเงินออก',
                                style: TextStyle(color: Colors.black54),
                              ),
                              Text(
                                '0.00',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          //
                          SizedBox(
                            height: 15,
                          ),
                          //
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'จำนวนเงินที่ควรมีในลิ้นชัก',
                                style: TextStyle(color: Colors.black54),
                              ),
                              Text(
                                '0.00',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          //
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),

          //Body 2 Stop

          //Button Start

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'นำเงินเข้าลิ้นชัก',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                //
                //
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'นำเงินออกจากลิ้นชัก',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                //
              ],
            ),
          ),

          //Button Stop

          //
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: Colors.red[400]),
                        onPressed: () {},
                        child: Text('ปิดรอบการขาย')))
              ],
            ),
          )
          //
        ],
      ),
      //Body Stop
    );
  }
}
