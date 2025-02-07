import 'package:flutter/material.dart';
import 'package:pos/constants.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: _buildIcon('images/reports.webp', 0),
          label: 'Reports',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon('images/today.webp', 1),
          label: 'Today',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon('images/counter.png', 2),
          label: 'Counter',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon('images/items.png', 3),
          label: 'Items',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon('images/more.webp', 4),
          label: 'More',
        ),
      ],
    );
  }

  Widget _buildIcon(String assetPath, int index) {
    return ImageIcon(
      AssetImage(assetPath),
      size: 25,
      color: currentIndex == index ? primaryColor : Colors.grey,
    );
  }
}
