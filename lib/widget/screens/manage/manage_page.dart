import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ManagePage extends StatefulWidget {
  const ManagePage({super.key});

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Appbar Start

      appBar: AppBar(
        //
        backgroundColor: Colors.white,
        toolbarHeight: 50,
        elevation: 1,
        //
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: Colors.red,
          ),
        ),
        //
        title: Text(
          'จัดการสินค้า',
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
        centerTitle: true,
        //
        //
      ),

      //Appbar Stop

      //Body Start

      body: Column(),

      //Body Stop
    );
  }
}
