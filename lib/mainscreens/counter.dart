import 'package:flutter/material.dart';
import 'package:pos/constants.dart';
import 'package:pos/mainscreens/home.dart';
import 'package:pos/invoice.dart';
import 'package:pos/loader.dart';
import 'package:pos/model/paymentypes.dart';
import 'package:pos/widgets/appbar.dart';
import 'package:pos/widgets/bottombar.dart';
import 'package:pos/widgets/drawer.dart';
import 'package:pos/widgets/paymentoprioncard.dart';

class Counter extends StatefulWidget {
  final List<Map<String, String>> items; // Receive cart items

  const Counter({super.key, required this.items});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
   double taxRate = 0.15; // Initial tax rate (15%)
  double discount = 10.0; // Initial discount (10)

  // Method to show a popup to enter tax value
  void _showTaxPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController taxController = TextEditingController();
        return AlertDialog(
          title: Text('Enter Tax',style: TextStyle(),),
          content: TextField(
            controller: taxController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Enter tax rate (e.g., 0.20 for 20%)'),
          ),
         actions: [
  Container(
    height: 40, // Adjust the height as needed
    decoration: BoxDecoration(
      color: primaryColor, // Button background color
      borderRadius: BorderRadius.circular(12), // Round the corners
    ),
    child: TextButton(
      onPressed: () {
        setState(() {
          taxRate = double.tryParse(taxController.text) ?? 0.15; // Default to 15% if invalid
        });
        Navigator.of(context).pop();
      },
      child: Text(
        'Submit',
        style: TextStyle(color: Colors.white), // White text color
      ),
    ),
  ),
],

        );
      },
    );
  }

  // Method to show a popup to enter discount value
  void _showDiscountPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController discountController = TextEditingController();
        return AlertDialog(
          title: Text('Enter Discount'),
          content: TextField(
            controller: discountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Enter discount amount'),
          ),
        actions: [
  Container(
    height: 40, // Adjust the height as needed
    decoration: BoxDecoration(
      color: primaryColor, // Button background color
      borderRadius: BorderRadius.circular(12), // Round the corners
    ),
    child: TextButton(
      onPressed: () {
        setState(() {
          discount = double.tryParse(discountController.text) ?? 10.0; // Default to 10 if invalid
        });
        Navigator.of(context).pop();
      },
      child: Text(
        'Submit',
        style: TextStyle(color: Colors.white), // White text color
      ),
    ),
  ),
],

        );
      },
    );
  }

  double getSubtotal() {
    double subtotal = 0.0;
    for (var item in widget.items) {
      subtotal += double.parse(item['price']!);
    }
    return subtotal;
  }

  double getTax(double subtotal) {
    return subtotal * taxRate;
  }

  double getTotal() {
    double subtotal = getSubtotal();
    double tax = getTax(subtotal);
    return subtotal + tax - discount;
  }
  bool isNameExpanded = false;
 String selectedPayment = "Cash";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

 



 @override
Widget build(BuildContext context) {
  double subtotal = getSubtotal();
    double tax = getTax(subtotal);
    double total = getTotal();

final List<String> staff = ['Staff 1', 'Staff 2', 'Staff 3'];
  String? selectedStaff;

  void showNewSalePopup(BuildContext context) {
  TextEditingController balanceController = TextEditingController(text: '500.00'); // Initial value of opening balance

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Opening balance and amount
              Text(
                'Opening Balance',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 10),
              // Editable opening balance
              TextFormField(
                controller: balanceController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Enter Balance',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              SizedBox(height: 20),

              // Staff dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Choose Staff',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                value: selectedStaff,
                items: staff.map((String staffMember) {
                  return DropdownMenuItem<String>(
                    value: staffMember,
                    child: Text(staffMember),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedStaff = value;
                  });
                },
              ),
              SizedBox(height: 20),

              // Button to go to next screen
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  'NEXT',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}


  return Scaffold(
    appBar: CustomAppBar(isHome: false),
  drawer: AppDrawer(),
    bottomNavigationBar: CustomBottomNavigationBar(
      currentIndex: 2,
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
    body: widget.items.isEmpty
        ? Center(
            child: InkWell(
              onTap: () {
                  showNewSalePopup(context);
                },
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Center(
                          child: Icon(Icons.add,color: Colors.white,),
                        ),
                      ),
              SizedBox(height: 20,),
                      Text(
                        'NEW SALE',
                        style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      // Display the cart items
                       Text(
            "Customer Details",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold,fontSize: 20),
          ),
          SizedBox(height: 10,),
                Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Customer Details Section with TextFields
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Customer Details Section with TextFields
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Customer Name',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const SizedBox(width: 8),
                        // Phone Number field
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              border: UnderlineInputBorder(),
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                
                    // Address and Email fields (only show when expanded)
                    if (isNameExpanded) ...[
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          border: UnderlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
          
                // Toggle arrow at the bottom
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isNameExpanded = !isNameExpanded;
                    });
                  },
                  child: Center(
                    child: Icon(
                      isNameExpanded
                          ? Icons.arrow_drop_up // Up arrow when expanded
                          : Icons.arrow_drop_down, // Down arrow when collapsed
                      size: 30,
                      color: primaryColor
                    ),
                  ),
                ),
              ],
            ),
          )
          
            ]
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Add new item button
                        SizedBox(height: 10),
                      // Display the cart items
                       Text(
            "CheckOut Overview",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold,fontSize: 20),
          ),
         
                      SizedBox(height: 20),
                      // Display order summary
                  Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Section: Item List
            Column(
              children: widget.items.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['name']!),
                      Row(
                        children: [
                          Text(
                            item['quantity']!,
                            style: TextStyle(color: Colors.green),
                          ),
                          Text("${item['price']!}"),
                          Spacer(),
                          Text('${item['total']!}'),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            Divider(),
            // Second Section: SubTotal, Tax, Discount, Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('SubTotal', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('\AED ${subtotal.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tax at ${taxRate * 100}%', style: TextStyle(color: Colors.grey)),
                Text('\AED ${tax.toStringAsFixed(2)}', style: TextStyle(color: Colors.grey)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Discount', style: TextStyle(color: Colors.grey)),
                Text('-\AED ${discount.toStringAsFixed(2)}', style: TextStyle(color: Colors.red)),
              ],
            ),
            Divider(),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('\AED ${total.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Divider(),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: _showTaxPopup,
                  child: Text(
                    'ADD TAX',
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: _showDiscountPopup,
                  child: Text(
                    'ADD DISCOUNT',
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
                      SizedBox(height: 20),
                      // Add new item button
                        SizedBox(height: 10),
                      // Display the cart items
                       Text(
            "Select Payment Mode",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold,fontSize: 20),
          ),
         
                      SizedBox(height: 20),
                     Container(
  padding: const EdgeInsets.all(16.0),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8.0),
    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 6)],
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute cards evenly
    children: List.generate(paymentOptions.length, (index) {
      return PaymentOptionCard(
        title: paymentOptions[index].title,
        image: paymentOptions[index].image,
        isSelected: selectedPayment == paymentOptions[index].title,
        onTap: () {
          setState(() {
            selectedPayment = paymentOptions[index].title;
          });
        },
      );
    }),
  ),
),

                      SizedBox(height: 100,)
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: ElevatedButton(
                    onPressed: () {
            if (selectedPayment == null || selectedPayment.isEmpty) {
              // Show a Snackbar if no payment option is selected
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select a payment option!'),
                  backgroundColor: Colors.red,
                ),
              );
            } else {
              // Navigate to the loader page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoaderPage(
                    items: widget.items,
                    subtotal: subtotal,
                    tax: tax,
                    discount: discount,
                    total:total,
                  ),
                ),
              );
            }
          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'PROCEED',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
  );
}
}