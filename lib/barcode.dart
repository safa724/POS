import 'package:flutter/material.dart';
import 'package:pos/constants.dart';


class Barcode extends StatefulWidget {
  const Barcode({super.key});

  @override
  State<Barcode> createState() => _BarcodeState();
}

class _BarcodeState extends State<Barcode> {
  String barcodeResult = "Barcode Scanning Area";

  // Function to start scanning barcode
  // Future<void> scanBarcode() async {
  //   String scanResult = await FlutterBarcodeScanner.scanBarcode(
  //     '#ff6666', // The color of the scan line
  //     'Cancel',  // Button text for cancel
  //     true,      // Show flash icon (for flashlight)
  //     ScanMode.BARCODE,  // Scanning mode for barcode
  //   );

  //   if (scanResult != '-1') {
  //     setState(() {
  //       barcodeResult = scanResult; // Update with scanned barcode
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Barcode Scanner",
          style: TextStyle(color: primaryColor),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // 1/4th of the screen for barcode scanning area
          Container(
            height: MediaQuery.of(context).size.height / 2,
            color: Colors.grey[200], // Placeholder for barcode scanning
            child: Center(
              child: Text(
                barcodeResult, 
                style: TextStyle(color: Colors.black, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Red container with text
        
          // Rest of the screen white body
          Expanded(
            child: Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Scan The Barcode to add',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                     Text('Item / Product to counter',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
