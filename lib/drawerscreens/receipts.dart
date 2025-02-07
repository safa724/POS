import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:pos/constants.dart';

class ReceiptsScreen extends StatefulWidget {
  const ReceiptsScreen({super.key});

  @override
  State<ReceiptsScreen> createState() => _ReceiptsScreenState();
}

class _ReceiptsScreenState extends State<ReceiptsScreen> {
  DateTime? fromDate;
  DateTime? toDate;

  List<Map<String, dynamic>> transactions = [
    {
      'image': 'images/money.webp',
      'title': 'RC-2',
      'method': 'By Cash',
      'details': 'Transaction ID: 12345',
      'amount': '\AED 120.00',
      'date': DateTime(2024, 2, 1),
    },
    {
      'image': 'images/money.webp',
      'title': 'RC-1',
      'method': 'By Cssh',
      'details': 'Transaction ID: 67890',
      'amount': '\AED 30.00',
      'date': DateTime(2024, 1, 25),
    },
  ];

  // Function to pick a date
  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    DateTime initialDate = isFromDate ? (fromDate ?? DateTime.now()) : (toDate ?? DateTime.now());
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != initialDate) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipts', style: TextStyle(color: primaryColor, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Filter Row with Date Pickers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDateBox(context, "From Date", fromDate, true),
                  _buildDateBox(context, "To Date", toDate, false),
                ],
              ),
              const SizedBox(height: 10), // Space before the list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      color: Colors.white,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(transaction['image'], height: 30),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  transaction['title'],
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                                Text(transaction['method'], style: const TextStyle(fontSize: 12)),
                                Text(transaction['details'], style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              transaction['amount'],
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build Date Box
  Widget _buildDateBox(BuildContext context, String label, DateTime? date, bool isFromDate) {
    return GestureDetector(
      onTap: () => _selectDate(context, isFromDate),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45, // 45% of screen width
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: primaryColor,
       borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date != null ? DateFormat('yyyy-MM-dd').format(date) : label,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
            const Icon(Icons.calendar_today, size: 16, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
