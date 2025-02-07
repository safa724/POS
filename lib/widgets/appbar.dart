import 'package:flutter/material.dart';
import 'package:pos/barcode.dart';
import 'package:pos/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHome; // Flag to check if it's the home screen
  const CustomAppBar({Key? key, this.isHome = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: primaryColor),
      backgroundColor: Colors.white,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Open drawer
            },
          );
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications, color: primaryColor),
          onPressed: () {
            // Handle notifications
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings, color: primaryColor),
          onPressed: () {
            // Handle settings
          },
        ),
      ],
      bottom: isHome
          ? PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: const Icon(Icons.search, color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: secondcolor, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: secondcolor, width: 2.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: primaryColor,
                      ),
                      width: 60,
                      height: 45,
                      child: IconButton(
                        icon: Image.asset(
                          'images/bar.png',
                          height: 30,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Barcode()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => isHome ? const Size.fromHeight(120) : const Size.fromHeight(kToolbarHeight);
}
