import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pos/constants.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class InvoiceGenerator extends StatelessWidget {
  final List<Map<String, String>> items;
  final double subtotal;
  final double tax;
  final double discount;
  final double total;

  const InvoiceGenerator({
    Key? key,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.discount,
    required this.total,
  }) : super(key: key);

  Widget _buildInvoiceContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Store Information
        Text('Store Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text('Store Address', style: TextStyle(fontSize: 12)),
        Text('Store Contact', style: TextStyle(fontSize: 12)),
        SizedBox(height: 10),
        
        // Invoice Header
        Text('Invoice #12345', style: TextStyle(fontSize: 12)),
        Text('Date: ${DateTime.now().toLocal()}', style: TextStyle(fontSize: 12)),
        SizedBox(height: 10),
        
        // Table Header with Grey Background
        Container(
          color: Colors.grey[300],
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Item', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              Text('Qty', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              Text('Price', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              Text('Total', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        
        // List of Items
        ...items.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: Text(item['name']!, style: TextStyle(fontSize: 12))),
                SizedBox(width: 10,),
                Expanded(child: Text(item['quantity']!, style: TextStyle(fontSize: 12))),
                Expanded(child: Text(item['price']!, style: TextStyle(fontSize: 12))),
                Expanded(child: Text(item['total']!, style: TextStyle(fontSize: 12))),
              ],
            ),
          );
        }).toList(),
        
        SizedBox(height: 10),
        
        // Subtotal, Tax, Discount, and Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            Text('\AED ${subtotal.toStringAsFixed(2)}', style: TextStyle(fontSize: 12)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax (15%)', style: TextStyle(fontSize: 12)),
            Text('\AED ${tax.toStringAsFixed(2)}', style: TextStyle(fontSize: 12)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Discount', style: TextStyle(fontSize: 12)),
            Text('-\AED ${discount.toStringAsFixed(2)}', style: TextStyle(fontSize: 12)),
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text('\AED ${total.toStringAsFixed(2)}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 10),

        // Thank You Message
        SizedBox(height: 10),
        Text('Thank you for your purchase!', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        Text('Visit Again!', style: TextStyle(fontSize: 12)),
        SizedBox(height: 10),
      ],
    );
  }

  Future<void> _printInvoice() async {
    final pdf = pw.Document();

    // Add page to the document
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              // Store Information
              pw.Text('Store Name', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Text('Store Address', style: pw.TextStyle(fontSize: 12)),
              pw.Text('Store Contact', style: pw.TextStyle(fontSize: 12)),
              pw.SizedBox(height: 10),
              
              // Invoice Header
              pw.Text('Invoice #12345', style: pw.TextStyle(fontSize: 12)),
              pw.Text('Date: ${DateTime.now().toLocal()}', style: pw.TextStyle(fontSize: 12)),
              pw.SizedBox(height: 10),
              
              // Table Header with Grey Background
              pw.Container(
                color: PdfColors.grey300,
                padding: pw.EdgeInsets.all(8.0),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  children: [
                    pw.Text('Item', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
             
                    pw.Text('Qty', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                    pw.Text('Price', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                    pw.Text('Total', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                  ],
                ),
              ),
              
              // List of Items
              ...items.map((item) {
                return pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 4.0),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Expanded(child: pw.Text(item['name']!, style: pw.TextStyle(fontSize: 12))),
                      pw.Expanded(child: pw.Text(item['quantity']!, style: pw.TextStyle(fontSize: 12))),
                      pw.Expanded(child: pw.Text(item['price']!, style: pw.TextStyle(fontSize: 12))),
                      pw.Expanded(child: pw.Text(item['total']!, style: pw.TextStyle(fontSize: 12))),
                    ],
                  ),
                );
              }).toList(),
              
              pw.SizedBox(height: 10),
              
              // Subtotal, Tax, Discount, and Total
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Subtotal', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('\AED ${subtotal.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 12)),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Tax (15%)', style: pw.TextStyle(fontSize: 12)),
                  pw.Text('\AED ${tax.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 12)),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Discount', style: pw.TextStyle(fontSize: 12)),
                  pw.Text('-\AED ${discount.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 12)),
                ],
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Total', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                  pw.Text('\AED ${total.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                ],
              ),
              
              // Thank You Message
              pw.SizedBox(height: 10),
              pw.Text('Thank you for your purchase!', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
              pw.Text('Visit Again!', style: pw.TextStyle(fontSize: 12)),
              pw.SizedBox(height: 10),
            ],
          );
        },
      ),
    );

    // Print the document
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 40),
              // Display the invoice content directly
              _buildInvoiceContent(),
              
              // Print button at the bottom
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white
                ),
                onPressed: _printInvoice,
                child: Text('Print'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
