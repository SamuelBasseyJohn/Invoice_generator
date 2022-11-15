import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:receipt_generator/Model/invoice.dart';
import 'package:receipt_generator/Pages/invoices.dart';

import 'pdf_preview.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.invoice});
  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(invoice.name),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Customer:",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        invoice.customer,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Invoice Items",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
                ...invoice.items.map(
                  (e) => ListTile(
                    title: Text(e.description),
                    trailing: Text("\$${e.cost}"),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Total:",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  trailing: Text(
                    "\$${invoice.totalCost()}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfPreviewPage(
              invoice: invoice,
            ),
          ),
        ),
        child: const Icon(Icons.picture_as_pdf),
      ),
    );
  }
}
