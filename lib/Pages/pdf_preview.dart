import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:receipt_generator/pdf_export.dart';

import '../Model/invoice.dart';

class PdfPreviewPage extends StatelessWidget {
  PdfPreviewPage({Key? key, required this.invoice}) : super(key: key);
  final Invoice invoice;
  final export = PDFExport();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Invoice'),
      ),
      body: PdfPreview(build: (context) => export.makePdf(invoice)),
    );
  }
}
