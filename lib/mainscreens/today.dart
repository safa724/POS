import 'package:flutter/material.dart';
import 'package:pos/constants.dart';
import 'package:pos/widgets/appbar.dart';
import 'package:pos/widgets/bottombar.dart';
import 'package:pos/widgets/drawer.dart';

class Todays extends StatefulWidget {
  const Todays({super.key});

  @override
  State<Todays> createState() => _TodaysState();
}

class _TodaysState extends State<Todays> {
  final List<Map<String, dynamic>> transactions = [
    {
      'title': 'RC2',
      'method': 'By Cash',
      'details': '1 Item 7 hours ago',
      'amount': 'AED 10',
      'image': 'images/money.webp',
    },
    {
      'title': 'RC3',
      'method': 'By Card',
      'details': '2 Items 5 hours ago',
      'amount': 'AED 25',
      'image': 'images/money.webp',
    },
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(isHome: false)
,
  drawer: AppDrawer(),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (int index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/reports');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/today');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/counter');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 4) {
            Navigator.pushReplacementNamed(context, '/more');
          }
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true, // Ensures it takes only as much space as needed
                physics: const NeverScrollableScrollPhysics(), // Disables inner scrolling
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      color: Colors.white,
                      height: 100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(transaction['image'], height: 40),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                transaction['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                transaction['method'],
                                style: const TextStyle(fontSize: 15),
                              ),
                              Text(
                                transaction['details'],
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            transaction['amount'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20), // Spacing before the button
              GestureDetector(
                onTap: () {
                  // Action when "GET OLD RECEIPTS" is tapped
                  print("Get Old Receipts tapped");
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  color: Colors.white,
                  child: const Text(
                    "GET OLD RECEIPTS",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
