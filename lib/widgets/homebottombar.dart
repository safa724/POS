import 'package:flutter/material.dart';
import 'package:pos/mainscreens/counter.dart';
import 'package:pos/model/productmodel.dart';

class CartActionRow extends StatefulWidget {
  final Map<int, int> quantities;
  final List<Product> products;
  final double totalAmount;
  final Color primaryColor;
  final Color secondColor;
  final Function clearCartCallback;

  const CartActionRow({
    Key? key,
    required this.quantities,
    required this.products,
    required this.totalAmount,
    required this.primaryColor,
    required this.secondColor, required this.clearCartCallback,
  }) : super(key: key);

  @override
  _CartActionRowState createState() => _CartActionRowState();
}

class _CartActionRowState extends State<CartActionRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        // Optional: Add decorations if needed
      ),
      child: Row(
        children: [
          // First box - Green (CLEAR ALL)
           Expanded(
            flex: 1,
            child: InkWell(
           onTap: () {
      widget.clearCartCallback(); // Call the callback to clear the cart in the parent widget
    },
              child: Container(
                color: widget.primaryColor,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'CLEAR ALL',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Second box - Red (HOLD)
          Expanded(
            flex: 1,
            child: Container(
              color: widget.secondColor,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'HOLD',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Third box - Green (PAY)
          Expanded(
            flex: 1,
            child: InkWell(
             onTap: () {
  // Ensure quantities are updated after clearing the cart
  bool isCartEmpty = widget.quantities.values.every((qty) => qty == 0 || qty == null);

  if (isCartEmpty) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Warning"),
          content: Text("Please select at least one item to continue."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  } else {
    // Filter out null or zero quantities
    List<Map<String, String>> cartItems = widget.products
        .where((product) => widget.quantities[product.id] != null && widget.quantities[product.id]! > 0)
        .map((product) {
      return {
        'name': product.title,
        'quantity': '${widget.quantities[product.id]}X',
        'price': product.price.toString(),
        'total': (product.price * widget.quantities[product.id]!).toString(),
      };
    }).toList();

    // Print all items being sent to the next screen
    print("Cart Items being sent to Counter screen:");
    for (var item in cartItems) {
      print(item); // Log each item
    }

    // Navigate to the Counter screen with valid cart items
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Counter(items: cartItems),
      ),
    );
  }
},


    // Navigate to the Counter screen with valid cart items
  

              child: Container(
                color: widget.primaryColor,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'PAY',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Fourth box - Red (Total)
          Expanded(
            flex: 1,
            child: Container(
              color: widget.secondColor,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${widget.totalAmount.toStringAsFixed(2)} \AED ', // total amount
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
