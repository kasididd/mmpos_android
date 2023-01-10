import 'dart:convert';

import 'package:MMPOS/page_backend/service_api.dart';
import 'package:MMPOS/provider/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/food.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool prompay = false;
  String prompayImage = '';
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<Store>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('ชำระเงิน'),
        ),
        backgroundColor: Colors.grey,
        body: Row(
          children: [
            // display
            Container(
              color: Color.fromARGB(255, 255, 255, 255),
              width: MediaQuery.of(context).size.width / 1.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // content
                  Container(
                    color: Color.fromARGB(255, 245, 245, 245),
                    width: double.infinity,
                    height: 90,
                    child: prompay
                        ? SizedBox(
                            width: 400,
                            height: 90,
                            child: Container(
                                child: prompayImage != ''
                                    // false
                                    ? Image.memory(base64Decode(prompayImage))
                                    : Center(
                                        child: CircularProgressIndicator())))
                        : Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'รวมสุทธิ ',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        provider.sumAllResult.toString(),
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                        provider.sumAllResult.toString(),
                                        style: TextStyle(
                                            fontSize: 24, color: Colors.red),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: provider.menuList.length,
                                  itemBuilder: (context, index) =>
                                      provider.menuList[index][3] != 0
                                          ? Foods(
                                              provider,
                                              provider.menuList[index][3],
                                              provider.menuList[index][0],
                                              provider.menuList[index][1],
                                              provider.menuList[index][2],
                                              index,
                                            )
                                          : Text(''),
                                ),
                              ),
                            ],
                          ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              prompay = false;
                            });
                          },
                          child: Text('เงินสด')),
                      SizedBox(
                        height: 150,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            String res = await GetAPI.genQrProm(name: "400");

                            setState(() {
                              prompayImage = res;
                              prompay = true;
                            });
                            print('image $prompayImage');
                          },
                          child: Text('พร้อมพย์'))
                    ],
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: Text(
                        'ยืนยันการชำระ',
                        style: TextStyle(fontSize: 24),
                      ))
                ],
              ),
            ),
            // calculate
            Expanded(
              child: Container(
                color: Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 60,
                            width: 120,
                            color: Colors.grey[400],
                            child: Center(child: Text('ล้าง'))),
                        SizedBox(
                          width: 2,
                        ),
                        Expanded(
                          child: Container(
                              height: 60,
                              color: Colors.grey[400],
                              child: Container(
                                  height: 60,
                                  width: 60,
                                  color: Colors.grey[400],
                                  child: Icon(Icons.remove_circle))),
                        ),
                      ],
                    ),
                    Expanded(
                      child: GridView.count(
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                        crossAxisCount: 4,
                        children: [
                          for (int i = 0; i < 10; i++)
                            Material(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {},
                                child: Text('$i'),
                              ),
                            )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
