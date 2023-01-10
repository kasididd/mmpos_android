import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:MMPOS/page_backend/service_api.dart';
import 'package:MMPOS/widget/food.dart';
import 'package:http/http.dart' as http;

class AddProductPages extends StatefulWidget {
  const AddProductPages({super.key});

  @override
  State<AddProductPages> createState() => _AddProductPagesState();
}

class _AddProductPagesState extends State<AddProductPages> {
  //
  var colorsPicked = Color(0xfff44336);
  TextEditingController nameCate = TextEditingController();
  bool onOff = true;
  List sideBar = [
    {"color": Colors.red, "name": "Hello"}
  ];
  List getCate = [];
  //
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close, color: Colors.red,)),
              Text('เพิ่มกลุ่มสินค้า'),
              TextButton(
                  onPressed: () async {
                    if (nameCate.text.length > 0) {
                      print(nameCate.text);
                      sideBar.add({
                        "color":
                            "${colorsPicked.red},${colorsPicked.green},${colorsPicked.blue}",
                        "name": nameCate.text
                      });
                      print(colorsPicked);
                      await Cate.insertU(
                          that_is: "cate",
                          name: nameCate.text,
                          color:
                              "${colorsPicked.red},${colorsPicked.green},${colorsPicked.blue}");

                      await cateSelect();
                      Navigator.of(context).pop();
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            AlertDialog(title: Text("โปรดใส่ชื่อ!")),
                      );
                    }
                  },
                  child: Text('บันทึก', style: TextStyle(color: Colors.red),))
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ชื่อกลุ่มสินค้า'),
                SizedBox(
                  width: 200,
                  height: 30,
                  child: TextField(
                    controller: nameCate,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.blueAccent),
                    )),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('เลือกสีพื้นหลัง'),
                GestureDetector(
                  onTap: () => showDialog(
                      context: context,
                      builder: (
                        BuildContext context,
                      ) {
                        return AlertDialog(
                          title: SingleChildScrollView(
                            child: SizedBox(
                              width: size.width * .3,
                              height: size.height * .5,
                              child: SingleChildScrollView(
                                child: BlockPicker(
                                  pickerColor: Colors.red,
                                  onColorChanged: (color) {
                                    setState(() {
                                      colorsPicked = color;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  layoutBuilder: (context, colors, child) {
                                    return GridView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 100,
                                        childAspectRatio: 1.0,
                                        crossAxisSpacing: 10,
                                        mainAxisExtent: 100,
                                        mainAxisSpacing: 10,
                                      ),
                                      children: [
                                        for (Color color in colors) child(color)
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  child: Container(
                    width: 50,
                    height: 50,
                    color:
                        colorsPicked != null ? colorsPicked : Colors.green[600],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('เปิดใช้งาน'),
                SizedBox(
                    width: 20,
                    height: 20,
                    child: Switch(
                      value: onOff,
                      onChanged: (value) {
                        setState(() {
                          onOff = !onOff;
                        });
                      },
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  cateSelect() async {
    try {
      var response = await http.post(Uri.parse(cateLink), body: {
        "action": "GET_ALL",
        "email": FirebaseAuth.instance.currentUser!.email,
        "that_is": "cate"
      });
      if (response.statusCode == 200) {
        // print(response.body);
        setState(() {
          getCate = jsonDecode(response.body);
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
