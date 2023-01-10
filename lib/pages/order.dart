import 'dart:io';

import 'package:MMPOS/provider/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrederScreen extends StatelessWidget {
  final int sumAll = 0;
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<Store>();

    return Scaffold(
      appBar: AppBar(
        title: Text('รายการอาหาร'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //ตั้งค่า
            // AppBarWidget(),

            //สินค้า
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: provider.menuList.length,
                itemBuilder: (context, index) =>
                    provider.menuList[index][3] == 0
                        ? Text('')
                        : fools(
                            provider,
                            provider.menuList[index][3],
                            provider.menuList[index][0],
                            provider.menuList[index][1],
                            provider.menuList[index][2],
                            index,
                          ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: Offset(0, 3)),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ราคา ทั้งหมด : ',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                '${provider.sumAllResult}',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        //--------------------
                        Divider(
                          color: Colors.black,
                        ),
                        //--------------------
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ยอดชำระ :',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                '${provider.sumAllResult}',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[500]),
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrederScreen(),
                          )),
                      child: Text(
                        'ชำระเงิน',
                        style: TextStyle(fontSize: 24),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
      //
      // drawer: AccountWidget(),
      // bottomNavigationBar: OrderComplete(),
      //
    );
  }

  Padding fools(
    Store provider,
    int menuCount,
    String imageLink,
    String name,
    int price,
    int index,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 9),
      child: Container(
        width: 350,
        height: 120,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 255, 245, 222),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.file(
                File(imageLink),
                height: 80,
                width: 150,
              ),
            ),
            Container(
              width: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, //start
                mainAxisAlignment: MainAxisAlignment.center, //spzceAround
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'ราคา $price บาท',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(0),
              height: 120,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      provider.remove(index);
                      provider.sumFunc();
                    },
                    icon: Icon(Icons.remove),
                    color: Colors.white,
                  ),
                  //TEXT
                  Text(
                    "$menuCount",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  //TEXT
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      provider.add(index);

                      provider.sumFunc();
                    },
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
