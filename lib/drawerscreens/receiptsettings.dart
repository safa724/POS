import 'package:flutter/material.dart';
import 'package:pos/constants.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ReceiptSettingsScreen extends StatefulWidget {
  @override
  _ReceiptSettingsScreenState createState() => _ReceiptSettingsScreenState();
}

class _ReceiptSettingsScreenState extends State<ReceiptSettingsScreen> {
  bool showBusinessName = true;
  bool showBusinessAddress = true;
  bool showTaxNumber = true;
  bool showTitle = true;
  bool showWebsite = true;
  bool showReceiptTitle = true;

  bool showRate = false;
  bool showTotalSaved = false;
  bool showCashierName = false;
  bool showCustomerPhone = false;
  bool showTotalItemCount = false;
  bool showChangeReturn = false;
  bool showPaymentDetails = false;

  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController taxNumberController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController receiptTitleController = TextEditingController();
  TextEditingController thankYouNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt Settings',style: TextStyle(color: primaryColor),),
      
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
       
            _buildBusinessField('Business Name', businessNameController, showBusinessName, (value) {
              setState(() => showBusinessName = value);
            }),
            _buildBusinessField('Business Address', businessAddressController, showBusinessAddress, (value) {
              setState(() => showBusinessAddress = value);
            }),
            _buildBusinessField('Tax Number', taxNumberController, showTaxNumber, (value) {
              setState(() => showTaxNumber = value);
            }),
            _buildBusinessField('Title', titleController, showTitle, (value) {
              setState(() => showTitle = value);
            }),
            _buildBusinessField('Website', websiteController, showWebsite, (value) {
              setState(() => showWebsite = value);
            }),
            _buildBusinessField('Receipt Title', receiptTitleController, showReceiptTitle, (value) {
              setState(() => showReceiptTitle = value);
            }),

            SizedBox(height: 20),

            _buildSectionTitle('Receipt Options'),
            _buildCard([
              _buildToggle('Show Rate on Receipt', showRate, (value) {
                setState(() => showRate = value);
              }),
              _buildToggle('Show Total Money Saved', showTotalSaved, (value) {
                setState(() => showTotalSaved = value);
              }),
              _buildToggle('Show Cashier Name', showCashierName, (value) {
                setState(() => showCashierName = value);
              }),
              _buildToggle('Show Customer Phone Number', showCustomerPhone, (value) {
                setState(() => showCustomerPhone = value);
              }),
              _buildTextField('Thank You Note', thankYouNoteController),
              _buildToggle('Show Total Item Count', showTotalItemCount, (value) {
                setState(() => showTotalItemCount = value);
              }),
              _buildToggle('Show Change Return Amount', showChangeReturn, (value) {
                setState(() => showChangeReturn = value);
              }),
              _buildToggle('Show Payment Details', showPaymentDetails, (value) {
                setState(() => showPaymentDetails = value);
              }),
            ]),

            SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  // Save settings logic
                },
                child: Text(
                  'Save Settings',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Business Detail with Checkbox
  Widget _buildBusinessField(String label, TextEditingController controller, bool isChecked, Function(bool) onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
    
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,),
          TextField(
            controller: controller,
            decoration: InputDecoration(
             
         
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
          SizedBox(height: 8),
          Row(
          mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Show in Receipt", style: TextStyle(fontSize: 16)),
              Checkbox(
                value: isChecked,
                onChanged: (value) => onChanged(value!),
                activeColor: primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Section Title Widget
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
      ),
    );
  }

  // Card for Sections
  Widget _buildCard(List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
      ),
      child: Column(
        children: children.map((child) => Padding(padding: EdgeInsets.symmetric(vertical: 6), child: child)).toList(),
      ),
    );
  }

  // Toggle Switch Widget
Widget _buildToggle(String label, bool value, Function(bool) onChanged) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87, // Adjust for dark mode if needed
          fontWeight: FontWeight.w500,
        ),
      ),
      FlutterSwitch(
        width: 40,
        height: 20,
        toggleSize: 20,
        value: value,
        borderRadius: 15,
        padding: 2,
        activeColor: Colors.blue, // Instagram uses a subtle blue tint
        inactiveColor: Colors.grey[400]!,
        activeToggleColor: Colors.white,
        inactiveToggleColor: Colors.white,
        toggleBorder: Border.all(color: Colors.grey.shade300, width: 1),
        onToggle: onChanged,
      ),
    ],
  );
}
  // Text Field Widget for Thank You Note
  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
