import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:receipt_generator/Model/invoice.dart';

class PDFExport {
  Future<Uint8List> makePdf(Invoice invoice) async {
    final image =
        (await rootBundle.load('Images/ogabassey.jpg')).buffer.asUint8List();
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(build: (context) {
        return pw.Column(
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  children: [
                    pw.Text("Attention to: ${invoice.customer}"),
                    pw.Text(invoice.address),
                  ],
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                ),
                pw.SizedBox(
                    height: 150,
                    width: 150,
                    child: pw.Image(pw.MemoryImage(image)))
              ],
            ),
            pw.Table(
              border: const pw.TableBorder(
                left: pw.BorderSide(color: PdfColors.black),
                right: pw.BorderSide(color: PdfColors.black),
                top: pw.BorderSide(color: PdfColors.black),
                bottom: pw.BorderSide(color: PdfColors.black),
                horizontalInside: pw.BorderSide(color: PdfColors.black),
                verticalInside: pw.BorderSide(color: PdfColors.black),
              ),
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(20),
                      child: pw.Text(
                        'INVOICE FOR PAYMENT',
                        style: pw.Theme.of(context).header4,
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                  ],
                ),
                ...invoice.items.map(
                  (e) => pw.TableRow(
                    children: [
                      pw.Expanded(child: PaddedText(e.description), flex: 3),
                      pw.Expanded(child: PaddedText("${e.cost}"), flex: 1)
                    ],
                  ),
                ),
                pw.TableRow(
                  children: [
                    PaddedText('TAX', align: pw.TextAlign.right),
                    PaddedText(
                        '\$${(invoice.totalCost() * 0.1).toStringAsFixed(2)}'),
                  ],
                ),
                pw.TableRow(
                  children: [
                    PaddedText('TOTAL', align: pw.TextAlign.right),
                    PaddedText("\$${invoice.totalCost()}"),
                  ],
                )
              ],
            ),
            pw.Padding(
              child: pw.Text(
                "THANK YOU FOR YOUR BUSINESS!",
                style: pw.Theme.of(context).header2,
              ),
              padding: const pw.EdgeInsets.all(20),
            ),
            pw.Text(
              "Please forward the slip below to the Accounts payable department",
            ),
            pw.Divider(
              height: 1,
              borderStyle: pw.BorderStyle.dashed,
            ),
            pw.SizedBox(
              height: 50,
            ),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(
                  children: [
                    PaddedText('Account Number'),
                    PaddedText('0522800345'),
                  ],
                ),
                pw.TableRow(
                  children: [
                    PaddedText('Account Name'),
                    PaddedText("Ogabassey"),
                  ],
                ),
                pw.TableRow(
                  children: [
                    PaddedText('Total Amounts to be paid'),
                    PaddedText('${invoice.totalCost()}'),
                  ],
                ),
              ],
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(30),
              child: pw.Text(
                'Please ensure all checks are payable to OGABASSEY.',
                style: pw.Theme.of(context).header3.copyWith(
                      fontStyle: pw.FontStyle.italic,
                    ),
                textAlign: pw.TextAlign.center,
              ),
            ),
          ],
        );
      }),
    );
    return pdf.save();
  }
}

// ignore: non_constant_identifier_names
pw.Widget PaddedText(final String text,
        {final pw.TextAlign align = pw.TextAlign.left}) =>
    pw.Padding(
      padding: const pw.EdgeInsets.all(10),
      child: pw.Text(
        text,
        textAlign: align,
      ),
    );
