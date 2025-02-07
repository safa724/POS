import 'package:flutter/material.dart';
import 'package:pos/constants.dart';
import 'package:share_plus/share_plus.dart';

class AppDrawer extends StatelessWidget {
  void _shareApp() {
  Share.share('Check out this amazing app: https://yourappurl.com');
}
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      child: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildBusinessInfo(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('Management'),
            ),
            _buildMenuItem("images/chat.webp", 'Help Chat', context, () {
              Navigator.pushNamed(context, '/helpChat');
            }),
            _buildMenuItem("images/counter.png", 'Add Expense', context, () {
              Navigator.pushNamed(context, '/Expense');
            }),
            _buildMenuItem("images/recipts.webp", 'Receipts', context, () {
              Navigator.pushNamed(context, '/receipts');
            }),
            _buildMenuItem(
                "images/customers.png", 'Customers Management', context, () {
              Navigator.pushNamed(context, '/customersManagement');
            }),
            // _buildMenuItem("images/shop.webp", 'Shop Front', context, () {
            //   Navigator.pushNamed(context, '/shopFront');
           // }),
            const SizedBox(height: 5),
            Divider(),
            const SizedBox(height: 5),
          _buildMenuItem("images/refer.webp", 'Refer App', context, _shareApp),

            _buildMenuItem("images/returned.webp", 'Returned Receipts', context,
                () {
              Navigator.pushNamed(context, '/returnedReceipts');
            }),
            const SizedBox(height: 5),
            Divider(),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('Settings'),
            ),
            _buildMenuItem("images/lan.webp", 'Language', context, () {
              Navigator.pushNamed(context, '/language');
            }),
            _buildMenuItem("images/set.webp", 'Receipt Settings', context, () {
              Navigator.pushNamed(context, '/receiptSettings');
            }),
            // _buildMenuItem("images/general.webp", 'General Settings', context,
            //     () {
            //   Navigator.pushNamed(context, '/generalSettings');
            // }),
            _buildMenuItem("images/logoutt.webp", 'LogOut', context, () {
              // Show a confirmation dialog before logging out
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Log Out"),
                    content: Text("Are you sure you want to log out?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          // Perform logout action
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text("Log Out"),
                      ),
                    ],
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 140,
      color: primaryColor,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text('POS APP',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            Text('v 1.0.0',
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset('images/gal.webp', height: 80),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 10),
          Text('Demo Business',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  fontSize: 20)),
          Text('+971 1234567',
              style: TextStyle(color: primaryColor, fontSize: 15)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionButton('SWITCH BUSINESS', primaryColor),
              _buildActionButton('CREATE BUSINESS', secondcolor),
            ],
          ),
        ],
      ),
    );
  }

  String formatText(String text) {
    List<String> words = text.split(' ');
    if (words.length == 2) {
      return "${words[0]}\n${words[1]}";
    }
    return text;
  }

  Widget _buildActionButton(String text, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              formatText(text),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String imagePath, String title, BuildContext context,
      VoidCallback onTap) {
    return ListTile(
      leading: Image.asset(
        imagePath,
        width: 24,
        height: 24,
        fit: BoxFit.contain,
        color: primaryColor,
      ),
      title: Text(title),
      onTap: onTap,
    );
  }
}
