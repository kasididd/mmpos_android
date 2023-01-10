import 'package:MMPOS/provider/store.dart';
import 'package:flutter/material.dart';

int sumAll = 0;
Padding Foods(
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
            child: Image.network(
              imageLink,
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
            height: 40,
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //TEXT
                Text(
                  "$menuCount",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                //TEXT
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

sumFunc(count, price, provider) {
  sumAll = 0;
  for (int i = 0; i < provider.menuList.length; i++) {
    int price = provider.menuList[i][2] * provider.menuList[i][3];
    sumAll += price;
  }
  provider.priceSum(sumAll);
  print(sumAll);
}
