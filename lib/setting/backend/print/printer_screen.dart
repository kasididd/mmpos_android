// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:google_fonts/google_fonts.dart';

class PrinterScreen extends StatefulWidget {
  const PrinterScreen({Key? key}) : super(key: key);

  @override
  State<PrinterScreen> createState() => _PrinterScreenState();
}

class _PrinterScreenState extends State<PrinterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: generatePdf,
              child: Text(
                'Generate Advanced PDF',
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// create PDF & print it
  void _createPdf() async {
    final doc = pw.Document();

    /// for using an image from assets
    // final image = await imageFromAssetBundle('assets/image.png');

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Hello eclectify Enthusiast'),
          ); // Center
        },
      ),
    ); // Page

    /// print the document using the iOS or Android print service:
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());

    /// share the document to other applications:
    // await Printing.sharePdf(bytes: await doc.save(), filename: 'my-document.pdf');

    /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
    /// save PDF with Flutter library "path_provider":
    // final output = await getTemporaryDirectory();
    // final file = File('${output.path}/example.pdf');
    // await file.writeAsBytes(await doc.save());
  }

  /// display a pdf document.
  void _displayPdf() {
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: [
            //1
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'MMPOS',
                  style: pw.TextStyle(fontSize: 30),
                ),
              ],
            ),
            //
            pw.SizedBox(height: 10),
            //2
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'ใบเสร็จรับเงิน',
                ),
              ],
            ),
            //3
            pw.SizedBox(height: 15),
            //
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'สาขา : MMPOS',
                  style: pw.TextStyle(fontSize: 30),
                ),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  '-------------------------------------',
                  style: pw.TextStyle(fontSize: 30),
                ),
              ],
            )
          ]);
        },
      ),
    );

    /// open Preview Screen
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewScreen(doc: doc),
        ));
  }

  /// Convert a Pdf to images, one image per page, get only pages 1 and 2 at 72 dpi
  void _convertPdfToImages(pw.Document doc) async {
    await for (var page
        in Printing.raster(await doc.save(), pages: [0, 1], dpi: 72)) {
      final image = page.toImage(); // ...or page.toPng()
      print(image);
    }
  }

  /// print an existing Pdf file from a Flutter asset
  void _printExistingPdf() async {
    // import 'package:flutter/services.dart';
    final pdf = await rootBundle.load('assets/document.pdf');
    await Printing.layoutPdf(onLayout: (_) => pdf.buffer.asUint8List());
  }

  /// more advanced PDF styling
  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.sarabunLight();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.Column(children: [
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
                pw.Text('ข้อความใบเสร็จท้ายบิล1',
                    style: pw.TextStyle(font: font))
              ]),
              //--- Stop
              pw.SizedBox(height: 10),
              //--- Start
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.Text('ข้อความใบเสร็จท้ายบิล2',
                    style: pw.TextStyle(font: font))
              ]),
              //--- Stop
              pw.SizedBox(height: 10),
              //--- Start
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.Text('รูปภาพ',
                    style: pw.TextStyle(font: font))
              ]),
              //--- Stop
              pw.SizedBox(height: 10),
              //--- Start
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.Text('รูปภาพ',
                    style: pw.TextStyle(font: font))
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

class PreviewScreen extends StatelessWidget {
  final pw.Document doc;

  const PreviewScreen({
    Key? key,
    required this.doc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_outlined),
        ),
        centerTitle: true,
        title: Text("Preview"),
      ),
      body: PdfPreview(
        build: (format) => doc.save(),
        allowSharing: true,
        allowPrinting: true,
        initialPageFormat: PdfPageFormat.a4,
        pdfFileName: "mydoc.pdf",
      ),
    );
  }
}
