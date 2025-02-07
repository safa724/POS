import 'package:flutter/material.dart';
import 'package:pos/widgets/appbar.dart';
import 'package:pos/widgets/bottombar.dart';

class MorePage extends StatelessWidget {
  final List<Map<String, String>> gridItems = [
    {'title': '100', 'subtitle': 'All Customers'},
    {'title': '0', 'subtitle': 'Due Customers'},
    {'title': '0', 'subtitle': 'Expense-Income'},
    {'title': '0', 'subtitle': 'Low Stocks'},
    {'title': '20', 'subtitle': 'Staff and Partners'},
    {'title': '4', 'subtitle': 'Items and Subitems'},
    {'title': '0', 'subtitle': 'Stock Value Cost Price'},
    {'title': '0', 'subtitle': 'Stock Value Selling Price'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(isHome: false)
,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 4,
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 2, // Adjust for container size
          ),
          itemCount: gridItems.length,
          itemBuilder: (context, index) {
            final item = gridItems[index];

            // Determine the color for the number based on the title
            Color numberColor = Colors.blue; // Default color
            if (item['subtitle'] == 'Due Customers') {
              numberColor = Colors.green;
            } else if (item['subtitle'] == 'Low Stocks') {
              numberColor = Colors.red;
            }

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
             
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item['title']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: numberColor, // Dynamic color
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    item['subtitle']!,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
