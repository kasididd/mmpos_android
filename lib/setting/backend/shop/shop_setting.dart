import 'dart:convert';
import 'dart:io';
import 'package:MMPOS/page_backend/service_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hidden_drawer/flutter_hidden_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../../provider/store.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  List? data;
  String? imageAdd;
  String? image;
  String type_store = "ร้านค้าทั่วไป";
  TextEditingController name = TextEditingController(text: "MMPOS");
  TextEditingController tax_id = TextEditingController();
  TextEditingController pos_id = TextEditingController();
  TextEditingController branch = TextEditingController();
  TextEditingController m_id = TextEditingController();
  TextEditingController time_open = TextEditingController();
  TextEditingController time_close = TextEditingController();
  TextEditingController tax_val = TextEditingController();
  TextEditingController service_chage = TextEditingController();
  TextEditingController adress1 = TextEditingController();
  TextEditingController adress2 = TextEditingController();
  TextEditingController tel = TextEditingController();
  int is_doble = 0;
  bool check = true;
  int select = 0;
  XFile? imagePicked;

  @override
  Widget build(BuildContext context) {
    Store provider = context.watch<Store>();

    if (check) getData(provider);

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
              Navigator.of(context).pop();
            },
          );
        }),
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'ตั้งค่าร้านค้า',
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              onPressed: () async {
                await uploadImage();
                if (image != null ||
                    data![0]['image'].length > 10 &&
                        type_store != null &&
                        tax_id.text.length > 0 &&
                        pos_id.text.length > 0 &&
                        branch.text.length > 0 &&
                        m_id.text.length > 0 &&
                        time_open.text.length > 0 &&
                        time_close.text.length > 0 &&
                        tax_val.text.length > 0 &&
                        service_chage.text.length > 0 &&
                        adress1.text.length > 0 &&
                        adress2.text.length > 0 &&
                        tel.text.length > 0 &&
                        name.text.length > 0 &&
                        tel.text.length > 0) {
                  String adress1_2 = "${adress1.text},${adress2.text}";
                  await UserStore.update(
                    setting: type_store,
                    u_id: data![0]['u_id'],
                    image: image != null ? image : data![0]['image'],
                    type_store: select.toString(),
                    tax_id: tax_id.text,
                    pos_id: pos_id.text,
                    branch: branch.text,
                    m_id: m_id.text,
                    time_open: time_open.text,
                    time_close: time_close.text,
                    tax_val: tax_val.text,
                    service_chage: service_chage.text,
                    is_doble: is_doble.toString(),
                    adress1_2: adress1_2,
                    tel: tel.text,
                    name_store: name.text,
                    tel_promt: tel.text,
                  );
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                        title: Text(
                      "สำเร็จ!",
                      style: TextStyle(fontSize: 24),
                    )),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                        title: Text(
                      "กรุณาใส่ข้อมูลให้ครบ!",
                      style: TextStyle(fontSize: 24),
                    )),
                  );
                }
              },
              icon: Icon(
                Icons.save,
                size: 40,
              ),
              color: Colors.green,
            ),
          )
        ],
      ),
      //APPBAR STOP

      //BODY START
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 0,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("โลโก้"),
                        InkWell(
                          onTap: () async {
                            print('takePic');
                            {
                              final newimage = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (newimage != null) {
                                final file = newimage;
                                setState(() {
                                  imagePicked = file;
                                });
                              } else {
                                return;
                              }
                            }
                          },
                          child: Container(
                            color: Colors.grey.shade200,
                            width: 200,
                            height: 60,
                            child: imagePicked != null
                                ? Image.file(
                                    File(imagePicked!.path),
                                    fit: BoxFit.cover,
                                  )
                                : data != null
                                    ? Image.network(
                                        data![0]['image'],
                                        fit: BoxFit.cover,
                                      )
                                    : Icon(
                                        Icons.image,
                                        size: 50,
                                      ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("ชื่อร้าน"),
                        SizedBox(
                          width: 200,
                          height: 30,
                          child: TextField(
                            controller: name,
                            decoration: InputDecoration(
                              labelText: 'MMPOS',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("ประเภทร้านค้า"),
                        SizedBox(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(3)),
                            width: MediaQuery.of(context).size.width * .6,
                            height: 30,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  selecter(context, 0, 'ร้านค้าทั่วไป'),
                                  selecter(context, 1, 'ร้านอาหาร'),
                                  selecter(context, 2, 'โฮสเทล'),
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("เลขประจำตัวผู้เสียภาษี"),
                        SizedBox(
                          width: 200,
                          height: 30,
                          child: TextField(
                            controller: tax_id,
                            decoration: InputDecoration(
                              labelText: '',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("POS ID"),
                        SizedBox(
                          width: 200,
                          height: 30,
                          child: TextField(
                            controller: pos_id,
                            decoration: InputDecoration(
                              labelText: '',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //
            Card(
              elevation: 0,
              color: Colors.white,
              child: Column(
                children: [
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("สาขา"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 100,
                          height: 30,
                          child: TextField(
                            controller: branch,
                            decoration: InputDecoration(
                              labelText: 'Mquaeties',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Text("เลขประจำเครื่อง"),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          width: 80,
                          height: 30,
                          child: TextField(
                            controller: m_id,
                            decoration: InputDecoration(
                              labelText: '001',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("เวลาเปิดร้าน"),
                        SizedBox(
                          width: 80,
                          height: 30,
                          child: TextField(
                            controller: time_open,
                            decoration: InputDecoration(
                              labelText: '09:00',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Text("เวลาปิดร้าน"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 80,
                            height: 30,
                            child: TextField(
                              controller: time_close,
                              decoration: InputDecoration(
                                labelText: '22:00',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //
                ],
              ),
            ),
            //
            Card(
              elevation: 0,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("ภาษีมูลค่าเพิ่ม"),
                          SizedBox(
                            width: 100,
                            height: 30,
                            child: TextField(
                              controller: tax_val,
                              decoration: InputDecoration(
                                labelText: '7',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("ค่าบริการ"),
                          SizedBox(
                            width: 100,
                            height: 30,
                            child: TextField(
                              controller: service_chage,
                              decoration: InputDecoration(
                                labelText: '0',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("การปัดเศษ"),
                          SizedBox(
                              // width: 100,
                              // height: 30,
                              child: TextButton(
                            onPressed: () {
                              setState(() {
                                if (is_doble == 0) {
                                  is_doble = 1;
                                } else {
                                  is_doble = 0;
                                }
                              });
                            },
                            child: Text(
                              is_doble == 0 ? 'ไม่ปัดเศษ' : "ปัดเศษ",
                              style: TextStyle(
                                  color: is_doble == 0
                                      ? Colors.grey
                                      : Colors.green),
                            ),
                          )),
                        ]),
                  )
                ],
              ),
            ),
            //
            Card(
              elevation: 0,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("ที่อยู่บรรทัดที่ 1"),
                          SizedBox(
                            width: 150,
                            height: 30,
                            child: TextField(
                              controller: adress1,
                              decoration: InputDecoration(
                                labelText: 'Nakhon Pathom',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("ที่อยู่บรรทัดที่ 2"),
                          SizedBox(
                            width: 150,
                            height: 30,
                            child: TextField(
                              controller: adress2,
                              decoration: InputDecoration(
                                labelText: 'Kampangsan',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("เบอร์โทรศัพท์"),
                          SizedBox(
                            width: 150,
                            height: 30,
                            child: TextField(
                              controller: tel,
                              decoration: InputDecoration(
                                labelText: '086xxxxxxx สำหรับพร้อมเพย์*',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ]),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      //BODY SYOP
    );
  }

  //SELECTOR
  GestureDetector selecter(BuildContext context, index, String text1) {
    return GestureDetector(
      onTap: () => setState(() {
        select = index;
        type_store = text1;
      }),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: (MediaQuery.of(context).size.width * .7 / 4) - 6,
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

  getData(Store provider) async {
    setState(() {
      data = provider.userData;
    });
    try {
      setState(() {
        print('เริ่ม...');
        List adress = data![0]['adress1_2'].toString().split(",");
        name = TextEditingController(text: data![0]['name_store']);
        tax_id = TextEditingController(text: data![0]['tax_id']);
        pos_id = TextEditingController(text: data![0]['pos_id']);
        branch = TextEditingController(text: data![0]['branch']);
        m_id = TextEditingController(text: data![0]['m_id']);
        time_open = TextEditingController(text: data![0]['time_open']);
        time_close = TextEditingController(text: data![0]['time_close']);
        tax_val = TextEditingController(text: data![0]['tax_val']);
        service_chage = TextEditingController(text: data![0]['service_chage']);
        is_doble = int.parse(data![0]['is_doble']);
        adress1 = TextEditingController(text: adress[0]);
        adress2 = TextEditingController(text: adress[1]);
        tel = TextEditingController(text: data![0]['tel_promt']);
        // name.value = TextEditingValue(text: "ANY TEXT");
        check = false;
        print('อัปเดทข้อมูลแล้ว➕');
      });
    } catch (e) {
      print("ไม่สามารถดึงข้อมูลจากUserStoreได้เพราะ: $e");
    }
  }

  Future<void> uploadImage() async {
    try {
      List<int> imageBytes =
          File(imagePicked!.path.toString()).readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      // print('$imageName');
      imageAdd = "${name.text}.${imagePicked!.path.split('.').last}";
      var response = await http.post(
          Uri.parse('http://$config/mmposAPI/crud_mmpos.php'),
          body: {'image': baseimage, 'name': imageAdd});
      if (response.statusCode == 200) {
        print(response.body);
        setState(() {
          image = "http://$config/mmposAPI/image/$imageAdd";
        });
      } else {
        print("Error during connection to server");
      }
    } catch (e) {
      print("$e");
    }
  }
}
