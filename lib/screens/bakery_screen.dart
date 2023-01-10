import 'dart:io';

import 'package:MMPOS/pages/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/store.dart';

class BakeryScreen extends StatefulWidget {
  const BakeryScreen({Key? key, required this.cate}) : super(key: key);
  final String cate;
  @override
  State<BakeryScreen> createState() => _BakeryScreenState();
}

class _BakeryScreenState extends State<BakeryScreen> {
  int sumAll = 0;
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<Store>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 10,
          child: Column(
            children: [
              Text(widget.cate),
              provider.menuList.length == 0
                  ? Text(
                      'ไม่มีข้อมูล -จำนวนข้อมูลที่พบ: ${provider.menuList.length}')
                  : Expanded(
                      child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1),
                          itemCount: provider.menuList.length,
                          itemBuilder: (context, index) => provider
                                      .menuList[index][4] ==
                                  widget.cate
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: GestureDetector(
                                    onTap: () => provider.add(index),
                                    child: Card(
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(children: [
                                            Image.file(
                                              File(provider.menuList[index][0]),
                                              fit: BoxFit.cover,
                                              height: 150,
                                              width: double.infinity,
                                            ),
                                            Positioned(
                                              bottom: 2,
                                              right: 2,
                                              child: ClipOval(
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  color: Colors.amber,
                                                  child: Center(
                                                    child: Text(
                                                      provider.menuList[index]
                                                              [3]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                top: 0,
                                                right: 0,
                                                child: IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.delete,
                                                    size: 30,
                                                    color: Colors.red,
                                                  ),
                                                )),
                                          ]),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                    provider.menuList[index][1],
                                                    style: TextStyle(
                                                        fontSize: 24)),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Text(''))),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OrederScreen(),
                                ));
                                provider.sumFunc();
                              },
                              child: Text(
                                'ตระกร้า',
                                style: TextStyle(fontSize: 24),
                              ))),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _itemOrder({
    required String image,
    required String title,
    required String qty,
    required String price,
  }) {
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
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
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
                  price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Text(
            '$qty x',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
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
    return Container(
      margin: const EdgeInsets.only(right: 20, bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color(0xff1f2029),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ],
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
}
