import 'package:MMPOS/page_backend/service_api.dart';
import 'package:MMPOS/provider/store.dart';
import 'package:MMPOS/setting/backend/product/3_product_screen.dart';
import 'package:MMPOS/widget/drawer_widget.dart';
import 'package:MMPOS/widget/screens/customer/add_customer_page.dart';
import 'package:MMPOS/widget/screens/productall/add_product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hidden_drawer/flutter_hidden_drawer.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProductPages extends StatefulWidget {
  const ProductPages({super.key});

  @override
  State<ProductPages> createState() => _ProductPagesState();
}

class _ProductPagesState extends State<ProductPages> {
  String head = "สินค้าทั้งหมด";
  List table = [];
  bool mode = true;
  bool checkOpen = true;
  double modeFont = 24;
  @override
  Widget build(BuildContext context) {
    Store provider = context.watch<Store>();
    Size size = MediaQuery.of(context).size;
    if (checkOpen) selectCate(provider);
    bool phone = size.height > size.width;
    if (phone) modeFont = 16;
    return Scaffold(
      drawer: Drawer(
        child: DrawerWidget(provider: provider),
      ),
      //Appbar Stop
      appBar: AppBar(
        //
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        //
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.red),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
          'จัดการสินค้า',
          style: TextStyle(color: Colors.black54, fontSize: 17),
        ),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () => setState(() {
                    mode = !mode;
                  }),
              child: Text(
                'โหมด ${mode ? '📃' : '🖼️'}',
                style: TextStyle(color: Colors.red, fontSize: modeFont),
              )),
          TextButton(
              onPressed: () => showBarModalBottomSheet(
                    expand: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => AddProductPages(),
                  ),
              child: Text(
                'เพิ่มกลุ่มสินค้า 🗂️',
                style: TextStyle(color: Colors.red, fontSize: modeFont),
              )),
          TextButton(
              onPressed: () => showProduct(provider, null),
              child: Text(
                'เพิ่มสินค้า📦',
                style: TextStyle(color: Colors.red, fontSize: modeFont),
              ))
        ],
      ),
      //Appbar Stop

      body: Row(
        children: [
          //
          phone
              ? Text('')
              : Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right:
                            BorderSide(width: 2.0, color: Colors.grey.shade300),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'กลุ่มสินค้าทั้งหมด',
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            child: ListView(
                          children: [
                            InkWell(
                              onTap: () => {
                                setState(() {
                                  head = "สินค้าทั้งหมด";
                                }),
                                selectCate(provider)
                              },
                              child: ListTile(
                                leading: ClipOval(
                                    child: ShaderMask(
                                  child: Icon(
                                    Icons.all_inbox,
                                    size: 35,
                                  ),
                                  blendMode: BlendMode.srcATop,
                                  shaderCallback: (bounds) => LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [Colors.red, Colors.blue],
                                  ).createShader(bounds),
                                )),
                                title: Text('ทั้งหมด'),
                              ),
                            ),
                            for (int i = 0; i < provider.cate.length; i++)
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () => setState(() {
                                      head = provider.cate[i]['name'];
                                      selectCate(provider);
                                    }),
                                    child: ListTile(
                                      leading: ClipOval(
                                          child: Container(
                                        width: 30,
                                        height: 30,
                                        color: Colors.red,
                                      )),
                                      title: Text(provider.cate[i]['name']),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 2,
                                    color: Colors.grey.shade300,
                                  )
                                ],
                              )
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
          //
          //
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  !phone
                      ? Text('')
                      : Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  for (int i = 0; i < provider.cate.length; i++)
                                    InkWell(
                                      onTap: () => setState(() {
                                        head = provider.cate[i]['name'];
                                        selectCate(provider);
                                      }),
                                      child: Card(
                                          child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: Center(
                                            child:
                                                Text(provider.cate[i]['name'])),
                                      )),
                                    ),
                                ],
                              )),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      head,
                      style: TextStyle(
                          color: Colors.grey[500], fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text('ชื่อ'),
                  //         Text('ราคา'),
                  //         Text('ชนิด'),
                  //         Text('หมวดหมู่'),
                  //         Text('กำลังโชว์'),
                  //         Text('น้ำหนัก'),
                  //         Text('จำนวนในสต๊อก'),
                  //       ],
                  //     )),
                  Expanded(
                      child: mode
                          ? ListView(
                              children: [
                                size.width > size.height
                                    ? Table(
                                        defaultColumnWidth:
                                            FixedColumnWidth(120.0),
                                        border: TableBorder.all(
                                            color: Colors.black,
                                            style: BorderStyle.solid,
                                            width: 1),
                                        children: [
                                          TableRow(children: [
                                            Column(children: [
                                              Text('ชื่อ',
                                                  style:
                                                      TextStyle(fontSize: 20.0))
                                            ]),
                                            Column(children: [
                                              Text('ราคา',
                                                  style:
                                                      TextStyle(fontSize: 20.0))
                                            ]),
                                            Column(children: [
                                              Text('ต้นทุน',
                                                  style:
                                                      TextStyle(fontSize: 20.0))
                                            ]),
                                            Column(children: [
                                              Text('หมวดหมู่',
                                                  style:
                                                      TextStyle(fontSize: 20.0))
                                            ]),
                                            Column(children: [
                                              Text('กำลังขาย',
                                                  style:
                                                      TextStyle(fontSize: 20.0))
                                            ]),
                                            Column(children: [
                                              Text('น้ำหนัก',
                                                  style:
                                                      TextStyle(fontSize: 20.0))
                                            ]),
                                            Column(children: [
                                              Text('สต๊อก',
                                                  style:
                                                      TextStyle(fontSize: 20.0))
                                            ]),
                                            Column(children: [
                                              Text('U_ID',
                                                  style:
                                                      TextStyle(fontSize: 20.0))
                                            ]),
                                          ]),
                                          TableRow(children: [
                                            Column(children: [
                                              for (int i = 0;
                                                  i < table.length;
                                                  i++)
                                                Text(table[i]['name'])
                                            ]),
                                            Column(children: [
                                              for (int i = 0;
                                                  i < table.length;
                                                  i++)
                                                Text(table[i]['price'])
                                            ]),
                                            Column(children: [
                                              for (int i = 0;
                                                  i < table.length;
                                                  i++)
                                                Text(table[i]['cost'])
                                            ]),
                                            Column(children: [
                                              for (int i = 0;
                                                  i < table.length;
                                                  i++)
                                                Text(table[i]['category'])
                                            ]),
                                            Column(children: [
                                              for (int i = 0;
                                                  i < table.length;
                                                  i++)
                                                Text(table[i]['is_use'] == "1"
                                                    ? "✅"
                                                    : "❌")
                                            ]),
                                            Column(children: [
                                              for (int i = 0;
                                                  i < table.length;
                                                  i++)
                                                Text(table[i]['weight'])
                                            ]),
                                            Column(children: [
                                              for (int i = 0;
                                                  i < table.length;
                                                  i++)
                                                Text(table[i]['quantity'])
                                            ]),
                                            Column(children: [
                                              for (int i = 0;
                                                  i < table.length;
                                                  i++)
                                                Text(table[i]['u_id'])
                                            ]),
                                          ]),
                                        ],
                                      )
                                    : Table(
                                        defaultColumnWidth:
                                            FixedColumnWidth(120.0),
                                        border: TableBorder.all(
                                            color: Colors.black,
                                            style: BorderStyle.solid,
                                            width: 1),
                                        children: [
                                          TableRow(children: [
                                            Column(children: [
                                              Text('ชื่อ',
                                                  style:
                                                      TextStyle(fontSize: 20.0))
                                            ]),
                                            Column(children: [
                                              Text('ราคา',
                                                  style:
                                                      TextStyle(fontSize: 20.0))
                                            ]),
                                          ]),
                                          TableRow(children: [
                                            Column(children: [
                                              for (int i = 0;
                                                  i < table.length;
                                                  i++)
                                                Text(table[i]['name'])
                                            ]),
                                            Column(children: [
                                              for (int i = 0;
                                                  i < table.length;
                                                  i++)
                                                Text(table[i]['price'])
                                            ]),
                                          ]),
                                        ],
                                      )
                              ],
                            )
                          : GridView.count(
                              childAspectRatio:
                                  size.width > size.height ? 3.4 : 4.6,
                              crossAxisCount: size.width > size.height ? 3 : 1,
                              children: [
                                for (int i = 0; i < table.length; i++)
                                  Slidable(
                                    endActionPane: ActionPane(
                                        motion: BehindMotion(),
                                        children: [
                                          Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )
                                        ]),
                                    child: Card(
                                      child: ListTile(
                                          leading: Container(
                                              color: double.tryParse(table[i]
                                                          ['image'][0]) ==
                                                      null
                                                  ? Colors.red
                                                  : myDecoder.readColor(
                                                      table[i]['image']),
                                              width: 60,
                                              height: 60,
                                              child:
                                                  double.tryParse(table[i]['image'][0]) ==
                                                          null
                                                      ? Image.network(
                                                          table[i]['image'],
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Text('')),
                                          title: Text(
                                              "${table[i]['name']}\n฿${table[i]['price']} ต้นทุน:${table[i]['price']}"),
                                          subtitle: Text(
                                              "ภาษี:${table[i]['check_list'][0] == "1" ? "✅" : "❌"} ประเภทสินค้า:${table[i]['type'][0]}"),
                                          trailing: InkWell(
                                              onTap: () => showProduct(
                                                  provider, table[i]),
                                              child: Icon(Icons.edit))),
                                    ),
                                  )
                              ],
                            ))
                ],
              ),
            ),
          ),
          //
        ],
      ),
    );
  }

  selectCate(Store provider) {
    print('หาของ');
    List res = head != "สินค้าทั้งหมด"
        ? provider.item!
            .where((element) => element['category'] == head)
            .toList()
        : provider.item!;
    // print(res);
    if (res.length > 0) {
      setState(() {
        table = res;
        print(table);
        checkOpen = false;
      });
    } else {
      setState(() {
        table = [];
        checkOpen = false;
      });
    }
  }

  showProduct(provider, data) async {
    await showBarModalBottomSheet(
      expand: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ProductScreen(getIn: data),
    );
    await GetRefress.selectAll(provider);
    await selectCate(provider);
    // Navigator.pop(context);
  }
}
