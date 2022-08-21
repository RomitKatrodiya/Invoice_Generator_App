import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:invoice_generator_app/resource/colors.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../resource/colors.dart';
import '../resource/global.dart';
import '../resource/global_style.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({Key? key}) : super(key: key);

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  DateTime dateToday = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour,
    DateTime.now().minute,
    DateTime.now().second,
    DateTime.now().millisecond,
  );
  DateTime dueToday = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day + 30,
    DateTime.now().hour,
    DateTime.now().minute,
    DateTime.now().second,
    DateTime.now().millisecond,
  );
  final pdf = pw.Document();

  var pdfColor = PdfColorsGlobal.pdfColor;
  var pdfColorLight = PdfColorsGlobal.pdfColorLight;

  var pdfColor2 = PdfColors.grey;
  var pdfColor3 = PdfColors.black;

  var style1 = pw.TextStyle(
    fontSize: 12,
    fontWeight: pw.FontWeight.bold,
    color: PdfColors.black,
  );
  var style2 = const pw.TextStyle(
    fontSize: 12,
    color: PdfColors.grey,
  );
  final image = pw.MemoryImage(
    File(Global.image!.path).readAsBytesSync(),
  );

  getPdf(res) {
    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Text(
            "INVOICE",
            style: pw.TextStyle(
              fontSize: 15,
              color: pdfColor2,
            ),
          ),
          pw.Divider(color: pdfColor2),
          pw.SizedBox(height: 5),
          pw.Row(
            children: [
              pw.Container(
                height: 50,
                width: 50,
                child: pw.ClipRRect(
                  horizontalRadius: 25,
                  verticalRadius: 25,
                  child: pw.Image(image, fit: pw.BoxFit.cover),
                ),
              ),
              pw.Spacer(),
              pw.Column(
                children: [
                  pw.Text(
                    "${Global.companyName}",
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      color: pdfColor,
                    ),
                  ),
                  pw.SizedBox(height: 5),
                  pw.Text(
                    "${Global.companyName}, ${Global.companyAddress}, ${Global.companyAddress2}, ${Global.companyAddress3}.",
                    style: pw.TextStyle(
                      fontSize: 12,
                      color: pdfColor2,
                    ),
                  ),
                ],
              ),
              pw.Spacer(),
              pw.Container(
                height: 50,
                width: 50,
                child: pw.ClipRRect(
                  horizontalRadius: 25,
                  verticalRadius: 25,
                  child: pw.Image(image, fit: pw.BoxFit.cover),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 5),
          pw.Divider(color: pdfColor2),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                flex: 2,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(height: 5),
                    pw.Text("BILL TO", style: style1),
                    pw.SizedBox(height: 2),
                    pw.Text("${Global.appCustomersList[res].customerName}",
                        style: style2),
                    pw.SizedBox(height: 2),
                    pw.Text("${Global.appCustomersList[res].customerNumber}",
                        style: style2),
                  ],
                ),
              ),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(height: 5),
                    pw.Text("Issue Date and Time", style: style1),
                    pw.SizedBox(height: 2),
                    pw.Text("$dateToday", style: style2),
                    pw.SizedBox(height: 5),
                    pw.Text("Due Date and Time", style: style1),
                    pw.SizedBox(height: 2),
                    pw.Text("$dueToday", style: style2),
                  ],
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Container(
            color: pdfColorLight,
            height: 25,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Expanded(
                  flex: 8,
                  child: pw.Text("Description", style: style1),
                ),
                pw.Expanded(
                  child: pw.Text("Qty.", style: style1),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Text("Unit Price", style: style1),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Text("Amount", style: style1),
                ),
              ],
            ),
          ),
          pw.Divider(color: pdfColor3, thickness: 1),
          ...indexList.map(
            (e) => pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Expanded(
                  flex: 8,
                  child:
                      pw.Text("${showProducts[e].productName}", style: style2),
                ),
                pw.Expanded(
                  child: pw.Text("${showCounter[e]}", style: style2),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Text("${showProducts[e].price}", style: style2),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Text("${showTotalList[e]}", style: style2),
                ),
              ],
            ),
          ),
          pw.Divider(color: pdfColor3, thickness: 1),
          pw.Container(
            color: pdfColorLight,
            height: 25,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Expanded(
                  flex: 8,
                  child: pw.Text("Total Amount", style: style1),
                ),
                pw.Expanded(
                  child: pw.Text("$totalCount", style: style1),
                ),
                pw.Expanded(flex: 2, child: pw.Text("")),
                pw.Expanded(
                  flex: 2,
                  child: pw.Text("Rs. ${Global.total}", style: style1),
                ),
              ],
            ),
          ),
          pw.Divider(
            color: pdfColor3,
            thickness: 1,
            borderStyle: const pw.BorderStyle(phase: 2),
          ),
          pw.Text(
              "Total Tax : ${(Global.total * int.parse(Global.initialTaxValue.toString())) / 100}",
              style: style2),
          pw.Spacer(),
          pw.Divider(color: pdfColor2),
          pw.Row(children: [
            pw.Text("GST No : ", style: style1),
            pw.Text("${Global.companyGSTNo}", style: style2),
            pw.SizedBox(width: 10),
            pw.Text("Phone Number : ", style: style1),
            pw.Text("${Global.companyNumber}", style: style2),
          ]),
          pw.Row(
            children: [
              pw.Text("Email : ", style: style1),
              pw.Text("${Global.companyEmail}", style: style2),
            ],
          ),
        ],
      ),
    );
  }

  List showProducts = [];
  List showTotalList = [];
  List<int> showCounter = [];

  List indexList = [];
  int index = 0;
  int totalCount = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < Global.totalList.length; i++) {
      if (Global.counter[i] != 0) {
        showProducts.add(Global.appProductsList[i]);
        showTotalList.add(Global.totalList[i]);
        showCounter.add(Global.counter[i]);
        indexList.add(index++);
      }
    }
    // ignore: avoid_function_literals_in_foreach_calls
    showCounter.forEach((element) {
      totalCount = totalCount + element;
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;
    getPdf(res);

    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Tools"),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const Spacer(),
            Icon(
              Icons.save_alt,
              size: 50,
              color: AppColors.primary.withOpacity(0.8),
            ),
            ElevatedButton(
              onPressed: () async {
                Directory? dir = await getExternalStorageDirectory();

                File file = File(
                    "${dir!.path}/${Global.appCustomersList[res].customerName}$dateToday.pdf");

                await file.writeAsBytes(await pdf.save());

                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("PDF Save Successfully..."),
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                        label: "Open",
                        onPressed: () async {
                          await OpenFile.open(file.path);
                        }),
                  ),
                );
              },
              style: AppStyle.elevatedButtonStyle,
              child: const Text("Save Invoice PDF"),
            ),
            const Spacer(),
            Icon(
              Icons.file_open_outlined,
              size: 50,
              color: AppColors.primary.withOpacity(0.8),
            ),
            ElevatedButton(
              onPressed: () async {
                Directory? dir = await getExternalStorageDirectory();

                File file = File(
                    "${dir!.path}/${Global.appCustomersList[res].customerName}$dateToday.pdf");

                await file.writeAsBytes(await pdf.save());

                await OpenFile.open(file.path);
              },
              style: AppStyle.elevatedButtonStyle,
              child: const Text("Open Invoice PDF"),
            ),
            const Spacer(),
            Icon(
              Icons.local_printshop_outlined,
              size: 50,
              color: AppColors.primary.withOpacity(0.8),
            ),
            ElevatedButton(
              onPressed: () async {
                Uint8List bytes = await pdf.save();

                await Printing.layoutPdf(onLayout: (format) => bytes);
              },
              style: AppStyle.elevatedButtonStyle,
              child: const Text("Print Invoice PDF"),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
