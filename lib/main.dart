import 'package:flutter/material.dart';
import 'package:pos/drawerscreens/addexpense.dart';
import 'package:pos/drawerscreens/customers.dart';
import 'package:pos/drawerscreens/expense.dart';
import 'package:pos/drawerscreens/helpchat.dart';
import 'package:pos/drawerscreens/receipts.dart';
import 'package:pos/drawerscreens/receiptsettings.dart';
import 'package:pos/drawerscreens/returnedreceipts.dart';
import 'package:pos/mainscreens/counter.dart';
import 'package:pos/mainscreens/more.dart';
import 'package:pos/mainscreens/reports.dart';
import 'package:pos/mainscreens/today.dart';
import 'package:pos/welcome.dart';
import 'package:pos/mainscreens/home.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      
      theme: ThemeData(
        fontFamily: 'Nexa',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/home': (context) =>  HomeScreen(),
        '/counter': (context) => const Counter(items: [],),
        '/reports': (context) => const Reports(),
        '/today': (context) => const Todays(),
        '/more': (context) =>  MorePage(),
         '/helpChat': (context) =>  HelpChat(),
           '/Expense': (context) =>  Expense(),
           '/addExpense': (context) =>  AddExpense(),
        '/receipts': (context) =>  ReceiptsScreen(),
         '/customersManagement': (context) => Customers(),
         '/returnedReceipts': (context) => ReturnedReceipts(),
         '/receiptSettings': (context) =>ReceiptSettingsScreen()
      },
    );
  }
}
