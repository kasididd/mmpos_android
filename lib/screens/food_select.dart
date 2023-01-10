import 'dart:io';

import 'package:MMPOS/pages/payment.dart';
import 'package:MMPOS/provider/store.dart';
import 'package:MMPOS/setting/backend/product/3_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class FoodSelect extends StatefulWidget {
  const FoodSelect({Key? key, required this.cate}) : super(key: key);
  final String cate;
  @override
  State<FoodSelect> createState() => _FoodSelectState();
}

class _FoodSelectState extends State<FoodSelect> {
  int sumAll = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var provider = context.watch<Store>();
    List getList = provider.itemList
        .where((element) => element['cate'] == widget.cate)
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 14,
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount: provider.itemList
                          .where((element) => element['cate'] == widget.cate)
                          .length +
                      1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 4 / 5, crossAxisCount: 5),
                  itemBuilder: (context, index) {
                    return provider.itemList
                                .where(
                                    (element) => element['cate'] == widget.cate)
                                .length ==
                            index
                        ? InkWell(
                            onTap: () {
                              showBarModalBottomSheet(
                                expand: true,
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) => ProductScreen(),
                              );
                            },
                            child: Card(
                              color: Colors.white,
                              child: Icon(
                                Icons.add,
                                size: 40,
                                color: Colors.red,
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              await provider.additemOrdeList(
                                  getList[index], index);
                              provider.countSum();
                              setState(() {
                                sumAll = provider.sumAllResult;
                              });
                              print(index);
                            },
                            child: _item(
                              image: getList[index]['image'],
                              title: getList[index]['title'],
                              price: getList[index]['price'].toString(),
                            ));
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.itemOrdeList.length,
                  itemBuilder: (context, index) => _itemOrder(
                      image: provider.itemOrdeList[index]['image'],
                      title: provider.itemOrdeList[index]['title'],
                      qty: provider.itemOrdeList[index]['qty'].toString(),
                      price: provider.itemOrdeList[index]['price'].toString(),
                      provider: provider,
                      index: index),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Color.fromARGB(255, 218, 218, 218),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ราคา :',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            '${sumAll}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade800,
                                fontSize: 26),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ภาษี :',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            '${(sumAll * .07).toStringAsFixed(2)}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 24),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        height: 2,
                        width: double.infinity,
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'จำนวนชำระ :',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            '${(sumAll + sumAll * .07).toStringAsFixed(2)}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green.shade400,
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Payment()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.money, size: 16),
                              SizedBox(width: 6),
                              Text('ชำระเงิน')
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _itemOrder(
      {required String image,
      required String title,
      required String qty,
      required String price,
      required Store provider,
      required int index}) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xff1f2029),
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              // image: DecorationImage(
              //   image: AssetImage(image),
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '$price บาท',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              provider.addQty(index);
              provider.countSum();
              setState(() {
                sumAll = provider.sumAllResult;
              });
            },
            icon: Icon(Icons.add),
            color: Colors.amber,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            '$qty x',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              provider.removeQty(index);
              provider.countSum();
              setState(() {
                sumAll = provider.sumAllResult;
              });
            },
            icon: Icon(Icons.remove),
            color: Colors.amber,
          ),
        ],
      ),
    );
  }

  Widget _item({
    required String image,
    required String title,
    required String price,
  }) {
    final height = MediaQuery.of(context).size.height;
    return Card(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.file(
              File(image),
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$price',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemTab(
      {required String icon, required String title, required bool isActive}) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 26),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xff1f2029),
        border: isActive
            ? Border.all(color: Colors.deepOrangeAccent, width: 3)
            : Border.all(color: const Color(0xff1f2029), width: 3),
      ),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 38,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
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
}
