import 'package:flutter/material.dart';
import 'package:pos/barcode.dart';
import 'package:pos/constants.dart';
import 'package:pos/mainscreens/counter.dart';
import 'package:pos/model/list.dart';
import 'package:pos/model/productmodel.dart';
import 'package:pos/newitem.dart';
import 'package:pos/widgets/appbar.dart';
import 'package:pos/widgets/bottombar.dart';
import 'package:pos/widgets/drawer.dart';

import 'package:pos/widgets/homebottombar.dart';

class HomeScreen extends StatefulWidget {
 HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String userName = "User"; // Replace with dynamic user name if needed 
 
  List<Product> products = []; // Filtered products based on category
  int selectedCategoryId = 1; // Default selected category ID
  Map<int, int> quantities = {}; // Track quantities for each product
  Map<int, double> productPrices = {}; // Map for quick price lookup

   @override
  void initState() {
    super.initState();
    // Populate productPrices map and quantities map
    for (var product in allProducts) {
      productPrices[product.id] = product.price;
      quantities[product.id] = 0; // Initialize all products with 0 quantity
    }
    _filterProductsByCategory(); // Filter products for the default category
  }

  void _filterProductsByCategory() {
  products = allProducts.where((p) => p.categoryId == selectedCategoryId).toList();
}


  void clearCart() {
    setState(() {
      quantities = {};  // Clear the cart
    });
  }
  double get totalAmount {
    double total = 0.0;
    quantities.forEach((id, qty) {
      total += (productPrices[id]! * qty); // Access price from the map
    });
    return total;
  }

  int get totalItemCount {
    int count = 0;
    quantities.forEach((id, qty) {
      if (qty > 0) count += 1;
    });
    return count;
  }
Widget _buildInfoBox(String text, Color color, {bool isTitle = false}) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          bottomLeft: isTitle ? Radius.circular(10) : Radius.zero,
          bottomRight: !isTitle ? Radius.circular(10) : Radius.zero,
        ),
      ),
      height: 50,
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: isTitle ? 10 : 10),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     drawer: AppDrawer(), 
      backgroundColor: Colors.white,
    appBar: CustomAppBar(isHome: true),

        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: 3,
          onTap: (int index) {
            if (index == 0) {
              Navigator.pushReplacementNamed(context, '/reports');
            } else if (index == 1) {
              Navigator.pushReplacementNamed(context, '/today');
            } else if (index == 2) {
              Navigator.pushReplacementNamed(context, '/counter');
            } else if (index == 3) {
              Navigator.pushReplacementNamed(context, '/home');
            }
            else if (index == 4) {
              Navigator.pushReplacementNamed(context, '/more');
            }
          },
        ),
   
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(
              height: 55,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category.id == selectedCategoryId;
                  final boxColor = index.isEven ? primaryColor : secondcolor;
        
                  return GestureDetector(
                   onTap: () {
  setState(() {
    selectedCategoryId = category.id;
    _filterProductsByCategory(); // This should filter only `products`, not `quantities`.
  });
},

                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: boxColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            height: 55,
                            width: 90,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  category.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight:
                                        isSelected ? FontWeight.bold : FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'QTY 20',
                                  style: TextStyle(fontSize: 8, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
        
            
            // Items Section
            Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Items',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
            ),
            SizedBox(height: 10),
        
            // GridView for Products
          Expanded(
  child: GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 0.2,
      mainAxisSpacing: 0,
      childAspectRatio: MediaQuery.of(context).size.width > 600 ? 1.0 : 0.8,
    ),
    itemCount: products.length + 1,
    itemBuilder: (context, index) {
      if (index == products.length) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewItem()),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Container(
                  height: 130,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: primaryColor,
                          child: Icon(Icons.add, color: Colors.white, size: 20),
                        ),
                        SizedBox(height: 6),
                        Text("Add New Item", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      final product = products[index];
      final quantity = quantities[product.id] ?? 0;

      return GestureDetector(
        onTap: () => setState(() => quantities[product.id] = quantity + 1),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  // Product Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      product.image,
                      height: 130,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Name and Price Row
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      children: [
                        _buildInfoBox(product.title, primaryColor, isTitle: true),
                        _buildInfoBox("${product.price} AED", secondcolor),
                      ],
                    ),
                  ),
                  // Quantity Overlay
                  if (quantity > 0)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withOpacity(0.6),
                        ),
                        child: Center(
                          child: Text(
                            'x$quantity',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  ),
),
            SizedBox(height: 10,),
            // Item Details Bottom Container
            if (totalItemCount > 0)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
            height: 150,
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Heading row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    Text(
                      'Qty',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    Text(
                      'Price',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    SizedBox(width: 40),
                  ],
                ),
                // Scrollable product list with edit and delete buttons
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...quantities.entries.map((entry) {
                          if (entry.value > 0) {
                            final product = allProducts.firstWhere((p) => p.id == entry.key);
                            final totalPrice = product.price * entry.value;
        
                            return Padding(
                              padding: EdgeInsets.only(bottom: 0.0),
                              child: Row(
                                children: [
                                  // Product name
                                  Expanded(
                                    child: Text(
                                      product.title,
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  // Quantity as "x1", "x2", etc.
                                  Text(
                                    'x${entry.value}',
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                  ),
                                  // Price for the quantity
                                  SizedBox(width: 30),
                                  Text(
                                    '${totalPrice.toStringAsFixed(2)} AED',
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                  ),
                                  // Edit and Delete buttons
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit, color: Colors.blue),
                                        onPressed: () {
                                          // Implement edit functionality here
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        onPressed: () {
                                          setState(() {
                                            quantities[product.id] = 0; // Reset the quantity to 0
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
                          return Container();
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
            // CartActionRow at the bottom
           CartActionRow(
  quantities: quantities,
  products: allProducts, // Pass all products here
  totalAmount: totalAmount,
  primaryColor: primaryColor,
  secondColor: secondcolor,
  clearCartCallback: clearCart,
),

          ],
        ),
      )
);
  }
}