import 'package:flutter/material.dart';
import 'package:pos/constants.dart';
import 'package:pos/widgets/appbar.dart';
import 'package:pos/widgets/bottombar.dart';
import 'package:pos/widgets/drawer.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
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
        drawer: AppDrawer(),
      appBar:CustomAppBar(isHome: false)
,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              height: 50,
              color: secondcolor,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_month, color: primaryColor),
                    SizedBox(width: 10),
                    Text('Today 18 Jan',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Total Sales
            _buildReportTile('TOTAL SALES', '200 AED'),
            SizedBox(height: 10),
            // Profits
            _buildReportTile('PROFITS', '50 AED'),
            SizedBox(height: 10),
            // Total Receipt Count
            _buildReportTile('TOTAL RECEIPT COUNT', '25'),
            SizedBox(height: 10),
            // Tax
            _buildReportTile('TAX', '10 AED'),
            SizedBox(height: 10),
            // Discount
            _buildReportTile('DISCOUNT', '15 AED'),
            SizedBox(height: 10),
            // Average Sales Value
            _buildReportTile('AVG SALES VALUE', '8 AED'),
          ],
        ),
      ),
    );
  }

  Widget _buildReportTile(String title, String value) {
    return Container(
      height: 100,
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, color:primaryColor),
          ],
        ),
      ),
    );
  }
}
