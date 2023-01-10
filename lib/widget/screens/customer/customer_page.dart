import 'package:MMPOS/provider/store.dart';
import 'package:MMPOS/widget/drawer_widget.dart';
import 'package:MMPOS/widget/screens/customer/add_customer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class CustomerPages extends StatefulWidget {
  const CustomerPages({super.key});

  @override
  State<CustomerPages> createState() => _CustomerPagesState();
}

class _CustomerPagesState extends State<CustomerPages> {
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
          'ลูกค้า',
          style: TextStyle(color: Colors.black54, fontSize: 17),
        ),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () => showBarModalBottomSheet(
                    expand: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => AddCustommerPage(),
                  ),
              child: Text(
                'เพิ่มลูกค้า',
                style: TextStyle(color: Colors.red),
              ))
        ],
      ),
      //APPBAR STOP
    );
  }
}
