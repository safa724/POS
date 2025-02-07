import 'package:flutter/material.dart';

class PaymentOptionCard extends StatelessWidget {
  final String title;
  final Image image;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentOptionCard({
    required this.title,
    required this.image,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: isSelected ? Colors.green.shade100 : Colors.white,
        child: SizedBox(
  width: 70, // Make each card smaller horizontally
  child: Padding(
    padding: const EdgeInsets.all(8.0), // Adjust padding as needed
    child: Column(
   
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image,
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14, // Smaller font size
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.green : Colors.black,
          ),
        ),
        if (isSelected) const Icon(Icons.check_circle, color: Colors.green),
      ],
    ),
  ),
),

      ),
    );
  }
}
