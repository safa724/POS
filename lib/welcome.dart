import 'package:flutter/material.dart';
import 'package:pos/constants.dart';
import 'package:pos/login.dart';
import 'package:pos/register.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Stack(
      children: [
        Center(
          child: Image.asset(
            'images/billing.png',
            height: 250,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0), // Adjust the bottom padding as needed
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(), // Replace with your target screen widget
                      ),
                    );
                  },
                  child: Container(
                    height: 55,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add margin for spacing
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primaryColor
                    ),
                    child: Center(
                      child: Text(
                        'New User',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10), // Space between buttons
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(), // Replace with your target screen widget
                      ),
                    );
                  },
                  child: Container(
                    height: 55,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: secondcolor,
                    ),
                    child: Center(
                      child: Text(
                        'Existing User',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
}




// import 'package:flutter/material.dart';
// import 'package:pos/counter.dart';
// import 'package:pos/model/productmodel.dart';

// class CartActionRow extends StatefulWidget {
//   final Map<int, int> quantities;
//   final List<Product> products;
//   final double totalAmount;
//   final Color primaryColor;
//   final Color secondColor;
//    final Function clearCartCallback;  // Add a callback functio

//   const CartActionRow({
//     Key? key,
//     required this.quantities,
//     required this.products,
//     required this.totalAmount,
//     required this.primaryColor,
//     required this.secondColor,
//     required this.clearCartCallback,
  
//   }) : super(key: key);

//   @override
//   _CartActionRowState createState() => _CartActionRowState();
// }

// class _CartActionRowState extends State<CartActionRow> {
//   late Map<int, int> quantities;

//   @override
//   void initState() {
//     super.initState();
//     quantities = Map<int, int>.from(widget.quantities);
//     print('Initial quantities: $quantities'); // Print initial quantities
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       width: double.infinity,
//       child: Row(
//         children: [
//           // First box - Green (CLEAR ALL)
//           Expanded(
//             flex: 1,
//             child: InkWell(
//             onTap: () {
//                 setState(() {
//                   quantities = {}; // Clear local quantities
//                 });
//                 widget.clearCartCallback();  // Call the callback to update the parent widget
//               },
//               child: Container(
//                 color: widget.primaryColor,
//                 child: Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'CLEAR ALL',
//                       style: TextStyle(
//                         fontSize: 10,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Second box - Red (HOLD)
//           Expanded(
//             flex: 1,
//             child: Container(
//               color: widget.secondColor,
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'HOLD',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Third box - Green (PAY)
//           Expanded(
//             flex: 1,
//             child: InkWell(
//               onTap: () {
//                 print('Quantities on PAY tap: $quantities'); // Print quantities when PAY is tapped
//                 bool isCartEmpty = quantities.values.every((qty) => qty == 0);

//                 if (isCartEmpty) {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: Text("Warning"),
//                         content: Text("Please select at least one item to continue."),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: Text("OK"),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 } else {
//                   List<Map<String, String>> cartItems = widget.products
//                       .where((product) => (quantities[product.id] ?? 0) > 0)
//                       .map((product) {
//                     int quantity = quantities[product.id] ?? 0;
//                     return {
//                       'name': product.title,
//                       'quantity': '${quantity}X',
//                       'price': product.price.toString(),
//                       'total': (product.price * quantity).toString(),
//                     };
//                   }).toList();

//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => Counter(items: cartItems),
//                     ),
//                   );
//                 }
//               },
//               child: Container(
//                 color: widget.primaryColor,
//                 child: Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'PAY',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Fourth box - Red (Total)
//           Expanded(
//             flex: 1,
//             child: Container(
//               color: widget.secondColor,
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(2.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Total',
//                         style: TextStyle(
//                           fontSize: 10,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         '${widget.totalAmount.toStringAsFixed(2)} \AED', // total amount
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
