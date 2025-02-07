import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pos/invoice.dart';

class LoaderPage extends StatefulWidget {
  final List<Map<String, String>> items;
  final double subtotal;
  final double tax;
  final double discount;
  final double total;

  const LoaderPage({
    super.key,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.discount,
    required this.total,
  });

  @override
  _LoaderPageState createState() => _LoaderPageState();
}

class _LoaderPageState extends State<LoaderPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // Simulate a 3-second loading process
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false; // Stop loader and show check mark
      });

      // After showing the check mark, navigate to the next screen
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => InvoiceGenerator(
              items: widget.items,
              subtotal: widget.subtotal,
              tax: widget.tax,
              discount: widget.discount,
              total: widget.total,
            ),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SpinKitCircle(
                    color: Colors.green,
                    size: 50.0,
                  ),
                  const SizedBox(height: 20),
                  const Text('Processing payment...', style: TextStyle(fontSize: 18)),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.check_circle, color: Colors.green, size: 50),
                  SizedBox(height: 20),
                  Text('Payment Successful', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                ],
              ),
      ),
    );
  }
}
