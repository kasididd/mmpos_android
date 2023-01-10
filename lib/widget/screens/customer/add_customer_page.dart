import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddCustommerPage extends StatefulWidget {
  const AddCustommerPage({super.key});

  @override
  State<AddCustommerPage> createState() => _AddCustommerPageState();
}

class _AddCustommerPageState extends State<AddCustommerPage> {
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
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.close,
            color: Colors.red,
          ),
        ),
        //
        title: Text(
          'เพิ่มลูกค้า',
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
        centerTitle: true,
        //
      ),
      
      //Appbar Stop

      //Body Start

      

      //Body Stop

    );
  }
}
