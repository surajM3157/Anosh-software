import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../controllers/invoice_controller.dart';
import '../controllers/print_settings_controller.dart';
import '../models/invoice_item.dart';

class InvoicePreviewScreen extends StatefulWidget {
  const InvoicePreviewScreen({super.key});

  @override
  State<InvoicePreviewScreen> createState() => _InvoicePreviewScreenState();
}

class _InvoicePreviewScreenState extends State<InvoicePreviewScreen> {
  final pdf = pw.Document();
  String printSize = 'A4';
  bool showValues = true;
  bool TermCondition = true;
  Orientation pageOrientation = Orientation.portrait;
  bool isTemplate = true;
  final List<String> printSizes = ['A4', 'Letter', 'Legal'];
  String selectedSize = 'A4';

  final List<InvoiceItem> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 300,
            color: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Print Settings',
                      style: Theme.of(context).textTheme.headlineSmall),
                ),
                const Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Template selection
                        Row(
                          children: [
                            Text(
                              'Printable Template',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 8),
                            Icon(
                              Icons.help_outline,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isTemplate = true;
                                    });
                                  },
                                  child: Container(
                                    width: 120,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isTemplate
                                            ? Colors.blue
                                            : Colors.white,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.blue.withOpacity(0.1),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 140,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey[300]!),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: const Center(
                                            child: Icon(Icons.description,
                                                size: 40, color: Colors.grey),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Template1',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isTemplate = false;
                                    });
                                  },
                                  child: Container(
                                    width: 120,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isTemplate
                                            ? Colors.white
                                            : Colors.blue,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.blue.withOpacity(0.1),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 140,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey[300]!),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: const Center(
                                            child: Icon(Icons.description,
                                                size: 40, color: Colors.grey),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Template2',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Text(
                              'Print Size',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 8),
                            const Icon(
                              Icons.help_outline,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: printSize,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          items: ['A4', 'Letter', 'Legal'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              printSize = newValue!;
                            });
                          },
                        ),

                        const SizedBox(height: 16),
                        Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Transform.scale(
                                scale: 0.8, // Smaller checkbox size
                                child: Checkbox(
                                  value: false,
                                  onChanged: (bool? value) {},
                                ),
                              ),
                              title: const Text('Email Address'),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Transform.scale(
                                scale: 0.8, // Smaller checkbox size
                                child: Checkbox(
                                  value: false,
                                  onChanged: (bool? value) {},
                                ),
                              ),
                              title: const Text('Website'),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Transform.scale(
                                scale: 0.8, // Smaller checkbox size
                                child: Checkbox(
                                  value: showValues,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      showValues = value!;
                                    });
                                  },
                                ),
                              ),
                              title: const Text('Show Values'),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Transform.scale(
                                scale: 0.8, // Smaller checkbox size
                                child: Checkbox(
                                  value: TermCondition,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      TermCondition = value!;
                                    });
                                  },
                                ),
                              ),
                              title: const Text('Team & Condition'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Print button
                        ElevatedButton.icon(
                          onPressed: () => _printPdf(),
                          icon: const Icon(Icons.print),
                          label: const Text('Print PDF'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: PdfPreview(
                build: (format) => _generatePdf(),
                initialPageFormat: PdfPageFormat.a4,
                pdfFileName: "invoice.pdf",
                allowPrinting: true,
                allowSharing: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Uint8List> _generatePdf() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PrintSettingsController.printSize.value == 'A4'
            ? PdfPageFormat.a4
            : PrintSettingsController.printSize.value == 'Letter'
            ? PdfPageFormat.letter
            : PdfPageFormat.legal,
        orientation: PrintSettingsController.pageOrientation.value == 'portrait'
            ? pw.PageOrientation.portrait
            : pw.PageOrientation.landscape,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      isTemplate == true
                          ? pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Company Name',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.blue,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                              'ADDRESS : 123 Business Street City, State 12345',
                              style: const pw.TextStyle(
                                  fontSize: 7,
                                  color: PdfColor.fromInt(0x737373))),
                          pw.Text('CONTACT : 1234567890',
                              style: const pw.TextStyle(
                                  fontSize: 7,
                                  color: PdfColor.fromInt(0x737373))),
                          pw.Text(
                            'contact@company.com',
                            style: const pw.TextStyle(
                              fontSize: 8,
                              color: PdfColor.fromInt(0x737373),
                            ),
                          ),
                        ],
                      )
                          : pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Company Name',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.blue,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                              'ADDRESS : 123 Business Street City, State 12345',
                              style: const pw.TextStyle(
                                  fontSize: 7,
                                  color: PdfColor.fromInt(0x737373))),
                        ],
                      ),
                      isTemplate == true
                          ? pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'INVOICE',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.blue,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text('Invoice #: INV-2024-001',
                              style: const pw.TextStyle(
                                  fontSize: 8,
                                  color: PdfColor.fromInt(0x737373))),
                          pw.Text(
                            'Date: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
                            style: const pw.TextStyle(
                                fontSize: 8,
                                color: PdfColor.fromInt(0x737373)),
                          ),
                        ],
                      )
                          : pw.Text(''),
                    ],
                  ),
                  pw.Divider(
                    color: PdfColors.blue,
                    thickness: 1,
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'BILL TO : ',
                            style: pw.TextStyle(
                              fontSize: 8,
                              color: PdfColors.blue,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text('PARTY NAME : AIBC CORPORATION PVT LTD',
                              style: const pw.TextStyle(fontSize: 7)),
                          pw.Text(
                              'ADDRESS : 123 Business Street, City, State - 12345',
                              style: const pw.TextStyle(fontSize: 7)),
                          pw.Text('GST: 2720XPQT0123Z3',
                              style: const pw.TextStyle(fontSize: 7)),
                        ],
                      ),
                      isTemplate == true
                          ? pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'SHIP TO :',
                            style: pw.TextStyle(
                              fontSize: 8,
                              color: PdfColors.blue,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text('PARTY NAME : AIBC CORPORATION PVT LTD',
                              style: const pw.TextStyle(fontSize: 7)),
                          pw.Text(
                              'ADDRESS : 123 Business Street, City, State - 12345',
                              style: const pw.TextStyle(fontSize: 7)),
                        ],
                      )
                          : pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'INVOICE',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.blue,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text('Invoice #: INV-2024-001',
                              style: const pw.TextStyle(
                                  fontSize: 8,
                                  color: PdfColor.fromInt(0x737373))),
                          pw.Text(
                            'Date: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
                            style: const pw.TextStyle(
                                fontSize: 8,
                                color: PdfColor.fromInt(0x737373)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'ITEM DETAILS',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Table(
                children: [
                  pw.TableRow(
                    decoration: pw.BoxDecoration(color: PdfColor.fromInt(0x2E3A59)),
                    children: [
                      _tableCell('SR NO.', isHeader: true),
                      _tableCell('DESCRIPTION', isHeader: true),
                      _tableCell('QTY', isHeader: true),
                      _tableCell('PRICE', isHeader: true),
                      _tableCell('GST', isHeader: true),
                      _tableCell('AMOUNT', isHeader: true),
                    ],
                  ),

                  ...InvoiceController.invoiceItems
                      .asMap()
                      .entries
                      .map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final isEvenRow = index % 2 == 0;
                    return pw.TableRow(
                      decoration: pw.BoxDecoration(
                          color: isEvenRow
                              ? PdfColors.white
                              : PdfColor.fromInt(0xCED7EE)),
                      children: [
                        _tableCell(item.srNo.toString()),
                        _tableCell(item.description),
                        _tableCell(item.quantity.toString()),
                        _tableCell(item.unitPrice.toStringAsFixed(2)),
                        _tableCell(item.gst.toStringAsFixed(2)),
                        _tableCell(item.total.toStringAsFixed(2)),
                      ],
                    );
                  }).toList(),
                ],
              ),
              pw.SizedBox(height: 290),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  showValues == true
                      ? pw.Text(
                    'Total: ${InvoiceController.totalAmount.toStringAsFixed(2)}',
                    style: pw.TextStyle(fontSize: 10),
                  )
                      : pw.Text(""),
                ],
              ),
              pw.Divider(color: PdfColors.blue, thickness: 0.8),

              TermCondition == true
                  ? pw.Align(
                alignment: pw.Alignment.bottomLeft,
                child: pw.RichText(
                  text: pw.TextSpan(
                    text: 'Terms & Conditions: ',
                    style: pw.TextStyle(
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColor.fromInt(0x0021C9),
                    ),
                    children: [
                      pw.TextSpan(
                        text: '\nPayment is due within 30 days.\n',
                        style: pw.TextStyle(
                            fontSize: 7,
                            fontWeight: pw.FontWeight.normal,
                            color: PdfColor.fromInt(0x737373)),
                      ),
                      pw.TextSpan(
                        text: 'Please include invoice number on payment.\n',
                        style: pw.TextStyle(
                            fontSize: 7,
                            fontWeight: pw.FontWeight.normal,
                            color: PdfColor.fromInt(0x737373)),
                      ),
                      pw.TextSpan(
                        text: 'All prices are in USD.',
                        style: pw.TextStyle(
                            fontSize: 7,
                            fontWeight: pw.FontWeight.normal,
                            color: PdfColor.fromInt(0x737373)),
                      ),
                    ],
                  ),
                ),
              )
                  : pw.Text(''),
              pw.Align(
                alignment: pw.Alignment.centerRight,  // Aligns to the right
                child: pw.Container(
                  width: 90,  // Set the desired width
                  child: pw.Divider(
                    color: PdfColors.black,
                    thickness: 0.7,
                  ),
                ),
              ),


              pw.Align(
                alignment: pw.Alignment.bottomRight,
                child: pw.Text(
                  'Authorized Signature',
                  style: pw.TextStyle(
                    fontSize: 8,
                    fontWeight: pw.FontWeight.bold,
                    color: const PdfColor.fromInt(0x0021C9),
                  ),
                ),
              ),

            ],
          );
        },
      ),
    );
    return pdf.save();
  }


  pw.Widget _tableCell(String text, {bool isHeader = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(4),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 8,
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
          color: isHeader ? PdfColors.white : PdfColors.black,
        ),
      ),
    );
  }

  void _printPdf() {
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      return _generatePdf();
    });
  }
}
