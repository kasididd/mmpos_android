import 'package:MMPOS/provider/store.dart';
import 'package:MMPOS/widget/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hidden_drawer/flutter_hidden_drawer.dart';


class BillPage extends StatefulWidget {
  const BillPage({super.key});

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  @override
  Widget build(BuildContext context) {
    Store provider = context.watch<Store>();
    return SafeArea(
        child: Scaffold(
      //
      drawer: DrawerWidget(provider: context.watch<Store>()),
      appBar: AppBar(toolbarHeight: 40,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.red,
                size: 20, // Changing Drawer Icon Size
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Row(
          children: [
            Text(
              'ประวัติการขาย',
              style: TextStyle(color: Colors.grey.shade800, fontSize: 20),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .1,
            ),
            Text(
              'รายละเอียด',
              style: TextStyle(color: Colors.grey.shade800),
            )
          ],
        ),
      ),
      body: SafeArea(
          child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .4,
            color: Colors.grey.shade200,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 30,
                  color: Colors.white,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.arrow_back_ios , size: 15, color: Colors.red,),
                        Container(
                            width: 50,
                            child: Center(
                                child: Text(
                              'วันนี้',
                              style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 255, 101, 91)),
                            ))),
                        Icon(Icons.arrow_forward_ios, size: 15, color: Colors.red,),
                      ]),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            color: Colors.grey.shade400,
          ))
        ],
      )),
    ));
  }
}
