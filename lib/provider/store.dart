import 'dart:io';

import 'package:MMPOS/page_backend/service_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Store with ChangeNotifier {
  // iamge
  File? iamge;

  List itemList = [
    // {
    //   "image": 'items/1.png',
    //   "title": 'ข้าวผัด',
    //   "qty": '1',
    //   "price": '50',
    //   "cate": "food"
    // },
    // {
    //   "image": 'items/1.png',
    //   "title": 'ผัดกระเพรา',
    //   "qty": '1',
    //   "price": '50',
    //   "cate": "food"
    // },
    // {
    //   "image": 'items/1.png',
    //   "title": 'ผัดกระเพรา',
    //   "qty": '1',
    //   "price": '50',
    //   "cate": "food"
    // },
    // {
    //   "image": 'items/1.png',
    //   "title": 'ผัดกระเพรา',
    //   "qty": '1',
    //   "price": '50',
    //   "cate": "food"
    // },
    // {
    //   "image": 'items/1.png',
    //   "title": 'ผัดกระเพรา',
    //   "qty": '1',
    //   "price": '50',
    //   "cate": "food"
    // },
    // {
    //   "image": 'items/1.png',
    //   "title": 'ผัดกระเพรา',
    //   "qty": '1',
    //   "price": '50',
    //   "cate": "food"
    // },
  ];
  List itemOrdeList = [
    // {"image": 'items/1.png', "title": 'Orginal Burger', "qty": 2, "price": 5},
    // {"image": 'items/2.png', "title": 'Double Burger', "qty": 3, "price": 10},
    // {
    //   "image": 'items/6.png',
    //   "title": 'Special Black Burger',
    //   "qty": 2,
    //   "price": 8
    // },
    // {
    //   "image": 'items/4.png',
    //   "title": 'Special Cheese Burger',
    //   "qty": 2,
    //   "price": 12
    // }
  ];

  // int menuCount = 0;
  int sumAllResult = 0;
  List menuList = [
    // 'https://i.imgur.com/esFxnxJ.jpg', 'ผัดกระเพรา', 50, , 'history'
  ];
  List cate = [];

  addCate(list) {
    cate = list;
    notifyListeners();
  }

  deleteCate(name) {
    cate.removeWhere(
      (element) => element == name,
    );
    notifyListeners();
  }

  add(index) {
    menuList[index][3]++;
    notifyListeners();
  }

  remove(index) {
    if (menuList[index][3] > 0) {
      menuList[index][3]--;
    }
    notifyListeners();
  }

  addQty(index) {
    itemOrdeList[index]['qty']++;
    notifyListeners();
  }

  removeQty(index) {
    if (itemOrdeList[index]['qty'] > 0) {
      itemOrdeList[index]['qty']--;
    } else {
      itemOrdeList.removeAt(index);
    }
    notifyListeners();
  }

  priceSum(sum) {
    sumAllResult = sum;

    notifyListeners();
  }
// addMenulist
  // addMenuList(image, name, price, cate) {
  //   if (image != null && name != null && price != null && cate != null) {
  //     itemList.add([image, name, int.parse(price), 0, cate]);
  //     print(menuList);
  //     notifyListeners();
  //   }
  // }

  addItems(image, name, price, cate, id) {
    if (image != null && name != null && price != null && cate != null) {
      var data = {
        "image": image,
        "title": name,
        "qty": 1,
        "price": int.parse(price),
        "cate": cate
      };
      hiveInfo(id.toString(), data);
      itemList.add(data);
      print(itemList);
      notifyListeners();
    }
  }

  additemOrdeList(item, index) {
    List<dynamic> have = itemOrdeList
        .where((element) => element['title'] == item['title'])
        .toList();
    have.length != 0
        // ignore: unnecessary_statements
        ? {
            print(have[0]['qty'].runtimeType),
            have[0]['qty'] = (have[0]['qty'] + 1)
          }
        : itemOrdeList.add(item);

    notifyListeners();
  }

  countSum() {
    int sumMultiple = 0;
    for (var item in itemOrdeList) {
      i++;
      int qty = item['qty'];
      int price = item['price'];
      sumMultiple += qty * price;
      print(sumMultiple.toString());
    }
    sumAllResult = sumMultiple;
    print(sumMultiple);
  }

  Future deleteFile(String path) async {
    await File(path).delete();
    notifyListeners();
  }

  sumFunc() {
    int sumAll = 0;
    for (int i = 0; i < menuList.length; i++) {
      int price = menuList[i][2] * menuList[i][3];
      sumAll += price;
    }
    priceSum(sumAll);
    notifyListeners();
  }

// Hive
  hive(data) async {
    await Hive.initFlutter();
    await Hive.openBox('status');
    var statusHive = Hive.box('status');
    statusHive.putAt(0, data);
    state = data;
    notifyListeners();
  }

  hiveInfo(col, data) async {
    await Hive.initFlutter();
    await Hive.openBox(col.toString());
    var statusHive = Hive.box(col);
    try {
      int index = statusHive.length;
      statusHive.put(index, data);
      print('put success');
      return statusHive.length;
    } catch (e) {
      print(e);
      return;
    }
  }

  hiveInfoCate(col) async {
    await Hive.initFlutter();
    await Hive.openBox(col);
    var statusHive = Hive.box(col);
    try {
      while (cate.length > statusHive.length) {
        statusHive.add('2');
      }
      for (int i = 0; i < cate.length; i++) {
        statusHive.put(i, cate[i]);
      }
      print('put cate success');
      return statusHive.length;
    } catch (e) {
      print('cate Hive err  $e');
      return;
    }
  }

  setHive(col) async {
    await Hive.initFlutter();
    await Hive.openBox(col);
    try {
      var statusHive = Hive.box(col);
      print(statusHive.length);
      for (int i = 0; i < 2; i++) {
        print(statusHive.get(i));
        // statusHive.delete(i);
        if (statusHive.get(i) != null) {
          itemList.add(statusHive.get(i));
        }
        notifyListeners();
        print('จำนวน hive ${statusHive.length}');
        return;
      }
    } catch (e) {
      return print('set up Hive err:$e');
    }
  }

  show() async {
    await Hive.initFlutter();
    await Hive.openBox('status');
    var statusHive = Hive.box('status');
    try {
      state = statusHive.get(0);
    } catch (e) {
      statusHive.put(0, '_');
      print(e);
    }
    countC++;
    notifyListeners();
    print('Form Show ${statusHive.get(0)}');
    getList();
  }

  getList() async {
    await Hive.initFlutter();
    await Hive.openBox('list');
    var listHive = Hive.box('list');
    try {
      // state = listHive.get(0);
    } catch (e) {
      listHive.put(0, '_');
      print('Err getList $e');
    }
    countC++;
    notifyListeners();
    print('from getList ${listHive.get(0)}');
  }

  // set cate from Hive
  setHiveCate(col) async {
    await Hive.initFlutter();
    await Hive.openBox(col);
    try {
      var cateHive = Hive.box(col);

      print('จำนวน hive cate  ${cateHive.length}  cate local :${cate.length}');
      for (int i = 0; i < cateHive.length; i++) {
        print('index i : $i   cate leagth :${cateHive.length}');
        // while (cateHive.length >= i && i > (cate.length - 1)) {
        //   print('อัปเดท');
        //   // cate.add(cateHive.get(i));
        //   // print(cateHive.get(i));
        // }
        print(i);
        print(cateHive.get(i));
        printAllHive(cate[i]['id'].toString());
        print(cate);
      }
    } catch (e) {
      return print('set up Hive err:$e');
    }
  }

  // set all item from Hive
  printAllHive(col) async {
    await Hive.initFlutter();
    await Hive.openBox(col);
    try {
      var statusHive = Hive.box(col);

      for (int index = 0; index < statusHive.length; index++) {
        // print('มาจาก Print all Hive : ${statusHive.get(index)}');
        itemList.add(statusHive.get(index));
        // print(itemList);
      }
      return;
    } catch (e) {
      return print('set up Hive err:$e');
    }
  }

// hive delete
  hiveDeleteCate({required int index_}) async {
    await Hive.initFlutter();
    await Hive.openBox(index_.toString());
    await Hive.openBox('cate');

    try {
      Box statusHive = Hive.box(index_.toString());
      for (int index = 0; index < statusHive.length; index++) {
        print('มาจาก Print all Hive : ${statusHive.get(index)}');
        itemList.removeWhere(
          (element) => element == statusHive.get(index),
        );
        print(itemList);
      }
      Hive.box('cate').delete(index_);
      notifyListeners();
    } catch (e) {
      print('can\'t remove $e');
    }
  }

  // login
  int countC = 0;
  String state = '_';
  List users = [
    {"userName": 'admin', "password": "123456"},
    {"userName": 'admin', "password": "123456"},
  ];
  login(String user, String password) {
    for (int i = 0; i < users.length; i++) {
      users[i]['userName'] == user
          // ignore: unnecessary_statements
          ? {
              if (password == users[i]['password'])
                {
                  print('Login success'),
                  state = user,
                  notifyListeners(),
                  hive(user)
                }
              else
                {print('Password is wrong!')}
            }
          : {print('user name is wrong!')};
    }
  }

  register(String user, String password) {
    for (int i = 0; i < users.length; i++) {
      users[i]['userName'] == user
          ? {print('user name is usesed'), state = user, notifyListeners()}
          // ignore: unnecessary_statements
          : {
              users.add({"userName": user, "password": password}),
              print('registed sucsess')
            };
    }
  }

  logOut() {
    hive('_');
    notifyListeners();
  }

  int i = 0;
  int j = 0;

  waitDataHive() async {
    while (i != 1) {
      setHiveCate('cate');
      print(' this is $i');

      i = 1;
      j = 1;
    }
    while (j == 1) {
      for (var col in cate) {
        print(col);
        setHive(col['id'].toString());
      }

      j = 2;
    }
  }

  String base64 = '';
  getPromt() {
    base64 = '';
    print(GetAPI.genQrProm(name: 'name'));
  }

  Color? colorsPicked;
  bool? onOff;

  // mainOrder
  List orderList = [];

  addOrderList(Object) {}

  // setting
  bool secondScreen = false;
  setValSetting(action, val) {
    if (action == "openScreen") {
      bool secondScreen = val;
      print(secondScreen);
    }
  }

  String? table;
  getTable(get) {
    table = get;
    notifyListeners();
  }

  List? item;
  getItem(get) {
    item = get;
    notifyListeners();
  }

  List? userData;
  getUserData(List get) {
    userData = get;
    notifyListeners();
  }

  getCate(List get) {
    cate = get;
    notifyListeners();
  }
}
