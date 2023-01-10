import 'dart:convert';

import 'package:MMPOS/page_backend/service_api.dart';
import 'package:MMPOS/provider/store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hidden_drawer/flutter_hidden_drawer.dart';
import 'package:http/http.dart' as http;

class PhonePayment extends StatefulWidget {
  const PhonePayment({super.key});

  @override
  State<PhonePayment> createState() => _PhonePaymentState();
}

class _PhonePaymentState extends State<PhonePayment> {
  bool err = false;
  bool barcode = false;
  bool amount = false;
  bool onStream = true;

  List rgb = ["156", "39", "176"];
  String rgbSt = "156, 39, 176";
  TextEditingController nameCate = TextEditingController();
  TextEditingController searcBarcode = TextEditingController();
  var sell = new TextEditingController();
  TextEditingController search = TextEditingController();
  String? prompayImage;
  String? grSlect;
  bool prompay = true;
  int setSideBar = 0;
  int priceSum = 0;
  bool onOff = true;
  var colorsPicked = Color(0xfff44336);
  List getItem = [];
  List getSlip = [];
  List grCustomer = [];
  List customerInfo = [];
  List getCate = [
    // {"name": "cate"}
  ];
  List sideBar = [
    {"color": Colors.red, "name": "Hello"}
  ];
  @override
  void initState() {
    noneStop();
    print('hello');
    selectAll();
    slipSlect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Store provider = context.watch<Store>();
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 1,
                    height: 1,
                    child: streamData(),
                  ),
                  // topbar
                  Container(
                    color: Colors.grey.shade100,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                        // Icon...
                      ],
                    ),
                  ),
                  // displays
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'รวมก่อนลด',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  '$priceSum',
                                  style: TextStyle(color: Colors.black54),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'THB',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  '$priceSum',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.black54),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(provider.table == null
                                ? ''
                                : provider.table.toString()),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  onPressed: err
                                      ? null
                                      : () async {
                                          await promPay();
                                          await showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return payments(size);
                                            },
                                          );
                                        },
                                  child: Text("ชำระเงิน")),
                            )
                          ]),
                    ),
                  ),
                  // list
                  sideBarOrder(size),
                ],
              ),
              // button
              Container(
                width: double.infinity,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'ลบทั้งหมด',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            content: Text(
                                'คุณต้องการลบสินค้าที่เลือกทั้งหมดหรือไม่?'),
                            actions: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Slip.deleteAll();
                                          setState(() {
                                            priceSum = 0;
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'ลบทั้งหมด',
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.red),
                                        )),
                                    //
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'ยกเลิก',
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.blue),
                                        )),
                                  ],
                                ),
                              ),
                            ]),
                      );
                    },
                    child: Text(
                      'ลบทั้งหมด',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView sideBarOrder(Size size) {
    slip(i) {
      // print(getSlip[i]['u_id']);
      return getItem.firstWhere(
          (element) => element['name'] == getSlip[i]['name_item'],
          orElse: () => print('No matching element.'));
    }

    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height * .6,
                  child: (getSlip.length > 0 &&
                          getItem.length > 0 &&
                          slip(0) != null)
                      ? ListView(
                          children: [
                            for (int i = 0; i < getSlip.length; i++)
                              ListTile(
                                  leading: Container(
                                      color: double.tryParse(
                                                  slip(i)['image'][0]) ==
                                              null
                                          ? Colors.red
                                          : readColor(slip(i)['image']),
                                      width: 60,
                                      height: 60,
                                      child: double.tryParse(
                                                  slip(i)['image'][0]) ==
                                              null
                                          ? Image.network(
                                              slip(i)['image'],
                                              fit: BoxFit.cover,
                                            )
                                          : Text('')),
                                  title: Text(slip(i)['name']),
                                  subtitle: Text(slip(i)['price']),
                                  trailing: GestureDetector(
                                    onTap: () =>
                                        Slip.delete(u_id: getSlip[i]['u_id']),
                                    child: Icon(
                                      Icons.delete,
                                    ),
                                  )),
                          ],
                        )
                      : Text(''),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  selled() {
    if (amount && sell.text.length > 0 && int.parse(sell.text) > 0) {
      if ((priceSum - int.parse(sell.text)) >= 0) {
        setState(() {
          err = false;
        });
        return priceSum - int.parse(sell.text);
      }
      setState(() {
        err = true;
      });
      return "ส่วนลดมีค่ามากกว่าสินค้า!";
    }
    if (!amount && sell.text.length > 0 && int.parse(sell.text) > 0) {
      if (int.parse(sell.text) <= 100) {
        setState(() {
          err = false;
        });
        return priceSum - (priceSum * (int.parse(sell.text)) / 100);
      }
      setState(() {
        err = true;
      });
      return "ส่วนลดมีค่ามากกว่าสินค้า!";
    } else {
      setState(() {
        err = false;
      });
      return priceSum;
    }
  }

  readColor(res) {
    String rgbSt = res;
    List get = rgbSt.split(",");
    // print("get   $get");
    return Color.fromARGB(
        255, int.parse(get[0]), int.parse(get[1]), int.parse(get[2]));
  }

  // openIcon() {
  //   print(selectByCate());
  //   print(getCate[setSideBar]['name']);
  // }
  promPay() async {
    String res = await GetAPI.genQrProm(name: priceSum.toString());
    setState(() {
      prompayImage = res;
      prompay = true;
    });
  }

  AlertDialog payments(Size size) {
    return AlertDialog(
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            width: size.width * .5,
            height: size.height * .6,
            child: Column(
              children: [
                // appbar
                Container(
                  width: double.infinity,
                  height: 50,
                  child: Center(child: Text("ชำระเงิน")),
                ),
                Expanded(
                  child: Container(
                      child: Column(
                    children: [
                      // left
                      Container(
                        width: 150,
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      prompay = true;
                                    });
                                  },
                                  child: Text('ชำระเงินสด')),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      prompay = false;
                                    });
                                  },
                                  child: Text('ชำระพร้อมเพย์')),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  onPressed: () {
                                    setState(() {
                                      prompay = false;
                                    });
                                  },
                                  child: Text('ยืนยันการชำระเงิน')),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                        height: double.infinity,
                        child: !prompay
                            ? Image.memory(base64Decode(prompayImage!))
                            : Text('สด'),
                      ))
                    ],
                  )),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  slipSlect() async {
    var req = await http
        .post(Uri.parse("http://$config/mmposAPI/slip_crud.php"), body: {
      "action": "GET_ALL",
      "email": FirebaseAuth.instance.currentUser!.email
    });
    var resSlip = jsonDecode(req.body);
    if (resSlip != getSlip) {
      setState(() {
        getSlip = resSlip;
      });
    }
  }

  selectAll() async {
    if (search.text.length != 0) {
      print(search.text.length);
      await Future<void>.delayed(Duration(hours: 1));
    }
    await Future.delayed(Duration(milliseconds: 482));

    try {
      print("fecting data");
      var request = await http
          .post(Uri.parse('http://$config/mmposAPI/items_crud.php'), body: {
        "action": "GET_ALL",
        "email": FirebaseAuth.instance.currentUser!.email
      });
      var res = jsonDecode(request.body);
      if (res != getItem) {
        setState(() {
          getItem = res;
        });
      }
      // slipCrude

      await slipSlect();
      sumCheck(0);
    } catch (e) {
      print("netwrok is err $e");
    }
  }

  noneStop() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      print("hello there..");
    }
  }

  sumCheck(index) {
    var toint = getSlip.map((e) => int.parse(e['sum'])).toList();
    if (getItem.length != 0 && getSlip.length != 0) {
      priceSum = int.parse(getItem[index]['price']);
    }
    // print(toint);
    priceSum = 0;
    for (int i = 0; i < toint.length; i++) {
      priceSum += toint[i];
    }
  }

  StreamBuilder<dynamic> streamData() {
    return StreamBuilder(
      stream: duration(),
      builder: (context, snapshot) => Expanded(
          child: FutureBuilder(
        future: selectAll(),
        builder: (context, snapshot) => Text(''),
      )),
    );
  }

  duration() async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 8000));
      yield '';
    }
  }
}
