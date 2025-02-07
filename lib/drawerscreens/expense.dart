import 'package:flutter/material.dart';
import 'package:pos/constants.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  Widget _buildSummaryCard(String title, String amount, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1)],
        ),
        child: Column(
          children: [
            Text(title, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text('AED $amount', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildTransaction(String label, String amount, Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: color, child: Text(label[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
          const SizedBox(width: 10),
          Text(label),
          const Spacer(),
          Text(amount, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: primaryColor,
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Text('Add Expense/Income', style: TextStyle(color: Colors.white, fontSize: 18)),
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          Container(
            height: 50,
            color: Colors.white,
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_left), Spacer(), Icon(Icons.calendar_month, color: primaryColor),
                  SizedBox(width: 10), Text('Today : 7 February', style: TextStyle(fontWeight: FontWeight.bold)),
                  Spacer(), Icon(Icons.arrow_right),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildSummaryCard('Income', '100', Colors.green),
                const SizedBox(width: 20),
                _buildSummaryCard('Expense', '200', Colors.red),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('07-February-25', style: TextStyle(color: Colors.blue)),
                      Row(
                        children: [
                          Text('Income : 100.00', style: TextStyle(color: Colors.green)),
                          Spacer(),
                          Text('Expense : 200.00', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                _buildTransaction('Salary', '100', Colors.green),
                const Divider(),
                _buildTransaction('Commissions', '200', Colors.red),
              ],
            ),
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        // Add action here
          Navigator.pushNamed(context, '/addExpense');
      },
      backgroundColor: primaryColor,
      child: const Icon(Icons.add, color: Colors.white),
    ),
  );
}
}