import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:MMPOS/setting/backend/print/printer_screen.dart';
import 'package:MMPOS/setting/setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class BlindPaymentSetting extends StatefulWidget {
  const BlindPaymentSetting({super.key});

  @override
  State<BlindPaymentSetting> createState() => _BlindPaymentSettingState();
}

class _BlindPaymentSettingState extends State<BlindPaymentSetting> {
  //VAL START
  bool logo = false;
  bool q_list = false;
  bool barcode = false;
  bool blind = false;
  bool order = false;
  bool select_blind = false;
  TextEditingController endbill1 = TextEditingController();
  TextEditingController endbill2 = TextEditingController();
  //VAL STOP

  //FUNCTION START
  onChangeFunction1(bool newValue1) {
    setState(() {
      logo = newValue1;
    });
  }

  onChangeFunction2(bool newValue2) {
    setState(() {
      q_list = newValue2;
    });
  }

  onChangeFunction3(bool newValue3) {
    setState(() {
      barcode = newValue3;
    });
  }

  onChangeFunction4(bool newValue4) {
    setState(() {
      blind = newValue4;
    });
  }

  onChangeFunction5(bool newValue5) {
    setState(() {
      order = newValue5;
    });
  }

  onChangeFunction6(bool newValue6) {
    setState(() {
      select_blind = newValue6;
    });
  }

  //FUNCTION STOP

  int select = 0;
  XFile? imagePicked;
  XFile? imagePicked2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //APPBAR STOP
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.red,
              size: 20, // Changing Drawer Icon Size
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingScreen()));
            },
          );
        }),
        backgroundColor: Colors.white,
        toolbarHeight: 35,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'ตั้งค่าใบเสร็จรับเงิน',
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
      ),
      //APPBAR START

      //BODY START

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customSwitch(
                      'พิมพ์โลโก้ร้านค้า', logo, onChangeFunction1),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customSwitch(
                      'เเสดงคิวบนใบเสร็จ', q_list, onChangeFunction2),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customSwitch(
                      'เเสดงบาร์โค้ดบนในเสร็จ', barcode, onChangeFunction3),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customSwitch(
                      'พิมพ์ใบเสร็จหลังชำระเงิน', blind, onChangeFunction4),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customSwitch(
                      'พิมพ์ในออเดอร์หลังชำระเงิน', order, onChangeFunction5),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('รูปแบบชำระเงิน'),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(3)),
                        width: MediaQuery.of(context).size.width * .7,
                        height: 30,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              selecter(context, 0, 'ใบกำกับภาษี'),
                              selecter(context, 1, 'ใบเสร็จรับเงิน'),
                              selecter(context, 2, 'กำหนดเอง'),
                            ]),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("ท้ายบิลบรรทัดที่ 1"),
                      SizedBox(
                        width: 200,
                        height: 30,
                        child: TextField(
                          controller: endbill1,
                          decoration: InputDecoration(
                            labelText: 'THANK YOU FOR YOUR SHOPPING',
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
                      Text("ท้ายบิลบรรทัดที่ 2"),
                      SizedBox(
                        width: 200,
                        height: 30,
                        child: TextField(
                          controller: endbill2,
                          decoration: InputDecoration(
                            labelText: 'Tel. 0888888888',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("รูปท้ายใบเสร็จ 1"),
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
                              : Icon(
                                  Icons.image_outlined,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("รูปท้ายใบเสร็จ 2"),
                      InkWell(
                        onTap: () async {
                          print('takePic');
                          {
                            final newimage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (newimage != null) {
                              final file = newimage;
                              setState(() {
                                imagePicked2 = file;
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
                          child: imagePicked2 != null
                              ? Image.file(
                                  File(imagePicked2!.path),
                                  fit: BoxFit.cover,
                                )
                              : Icon(
                                  Icons.image_outlined,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                        ),
                      )
                    ],
                  ),
                ),
                TextButton(
                    onPressed: generatePdf,
                    child: Text(
                      'เเสดงตัวอย่าง',
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            )
          ],
        ),
      ),

      //BODY STOP
    );
  }

  //WIDGET
  Widget customSwitch(String text, bool val, Function onChangeMethod) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Spacer(),
          CupertinoSwitch(
              trackColor: Colors.grey,
              activeColor: Colors.red,
              value: val,
              onChanged: (NewValue) {
                onChangeMethod(NewValue);
              })
        ],
      ),
    );
  }
  //WIDGET

  //SELECTOR

  GestureDetector selecter(BuildContext context, index, text1) {
    return GestureDetector(
      onTap: () => setState(() {
        select = index;
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

  //SELCTOR
  Future<String> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    return base64Encode(bytes);
  }

  /// more advanced PDF styling
  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.sarabunLight();
    final imgBase64Str =
        await networkImageToBase64('https://i.stack.imgur.com/kslJL.png');
    final image = imagePicked != null
        ? pw.MemoryImage(File(imagePicked!.path).readAsBytesSync())
        : pw.MemoryImage(base64Decode(imgBase64Str));
    final image2 = imagePicked != null
        ? pw.MemoryImage(File(imagePicked2!.path).readAsBytesSync())
        : pw.MemoryImage(base64Decode(imgBase64Str));

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.Column(children: [
                //Logo Start
                pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Image(image,
                          width: 400, height: 150, fit: pw.BoxFit.cover)
                    ]),
                //Logo Stop
                //Title Start
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [pw.Text('MMPOS')]),
                //Title Stop
                pw.SizedBox(height: 10),
                //Bill Start
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text('ใบเสร็จรับเงิน', style: pw.TextStyle(font: font))
                    ]),
                //Bill Stop
                pw.SizedBox(height: 10),
                //สาขา Start
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text('สาขา : Meow', style: pw.TextStyle(font: font))
                    ]),
                //สาขา Stop
                pw.SizedBox(height: 10),
                //--- Start
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text('---------------------------------',
                          style: pw.TextStyle(font: font))
                    ]),
                //--- Stop
                pw.SizedBox(height: 10),
                //--- Start
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text('วันที่ : 4/01/2566 15:54',
                          style: pw.TextStyle(font: font))
                    ]),
                //--- Stop
                pw.SizedBox(height: 10),
                //--- Start
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text('พนักงาน : Admin',
                          style: pw.TextStyle(font: font))
                    ]),
                //--- Stop
                pw.SizedBox(height: 10),
                //--- Start
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text('---------------------------------',
                          style: pw.TextStyle(font: font))
                    ]),
                //--- Stop
                pw.SizedBox(height: 10),
                //--- Start
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('จำนวน', style: pw.TextStyle(font: font)),
                      pw.Text('รายละเอียด', style: pw.TextStyle(font: font)),
                      pw.Text('ราคา', style: pw.TextStyle(font: font)),
                    ]),
                //--- Stop
                //--- Start
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('2', style: pw.TextStyle(font: font)),
                      pw.Text('ชาเขียวปั่น', style: pw.TextStyle(font: font)),
                      pw.Text('130.00', style: pw.TextStyle(font: font)),
                    ]),
                //--- Stop
              ]),
              pw.SizedBox(height: 10),
              //--- Start
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text('---------------------------------',
                    style: pw.TextStyle(font: font))
              ]),
              //--- Stop
              //--- Start
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('จำนวน 2 ชิ้น', style: pw.TextStyle(font: font)),
                    pw.Text('รวมมูลค่า', style: pw.TextStyle(font: font)),
                    pw.Text('130.00', style: pw.TextStyle(font: font)),
                  ]),
              //--- Stop
              pw.SizedBox(height: 10),
              //--- Start
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text('---------------------------------',
                    style: pw.TextStyle(font: font))
              ]),
              //--- Stop
              pw.SizedBox(height: 10),
              //การชำระเงิน Start
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text('การชำระเงิน', style: pw.TextStyle(font: font))
              ]),
              //การชำระเงิน Stop
              pw.SizedBox(height: 10),
              //--- Start
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('เงินสด', style: pw.TextStyle(font: font)),
                    pw.Text('500', style: pw.TextStyle(font: font)),
                  ]),
              //--- Stop
              pw.SizedBox(height: 10),
              //--- Start
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('เงินทอน', style: pw.TextStyle(font: font)),
                    pw.Text('370', style: pw.TextStyle(font: font)),
                  ]),
              //--- Stop
              pw.SizedBox(height: 10),
              //--- Start
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text('---------------------------------',
                    style: pw.TextStyle(font: font))
              ]),
              //--- Stop
              pw.SizedBox(height: 10),
              //--- Start
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.Text(endbill1.text, style: pw.TextStyle(font: font))
              ]),
              //--- Stop
              pw.SizedBox(height: 10),
              //--- Start
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.Text(endbill2.text, style: pw.TextStyle(font: font))
              ]),
              //--- Stop
              pw.SizedBox(height: 10),
              //--- Start
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.Text('รูปภาพ', style: pw.TextStyle(font: font))
              ]),
              //--- Stop
              pw.SizedBox(height: 10),
              //--- Start
              pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Image(image2,
                        width: 400, height: 150, fit: pw.BoxFit.cover)
                  ]),
              //--- Stop
              pw.SizedBox(height: 20),
            ],
          );
        },
      ),
    );
    return pdf.save();
  }

  void generatePdf() async {
    const title = 'สวัสดี';
    await Printing.layoutPdf(onLayout: (format) => _generatePdf(format, title));
  }
}
