import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos/constants.dart';

class Customers extends StatefulWidget {
  const Customers({super.key});

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  List<Map<String, dynamic>> customers = [
    {"name": "John Doe", "phone": "9876543210"},
    {"name": "Alice Brown", "phone": "8765432109"},
    {"name": "Michael Smith", "phone": "7654321098"},
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  DateTime? _selectedDate;
 String _selectedGender = "Male"; // Default selection


  // Function to show Add Customer Popup
  void _showAddCustomerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Customer",style: TextStyle(color: primaryColor),),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(_nameController, "Full Name"),
                _buildTextField(_phoneController, "Mobile Number", keyboardType: TextInputType.phone),
                _buildTextField(_emailController, "Email Address", keyboardType: TextInputType.emailAddress),
                _buildGenderSelection(),
                _buildDatePicker(),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close the dialog
              child: const Text("Cancel",style: TextStyle(color: Colors.black),),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white
              ),
              onPressed: _addCustomer,
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  // Function to create Text Fields
  Widget _buildTextField(TextEditingController controller, String label, {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  // Function to create Gender Selection
  Widget _buildGenderSelection() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text("Gender:"),
      Row(
        children: [
          Radio(
            value: "Male",
            groupValue: _selectedGender,
            activeColor: Colors.green, // Change selected radio color to green
            onChanged: (value) {
              setState(() {
                _selectedGender = value.toString();
              });
            },
          ),
          const Text("Male"),
          Radio(
            value: "Female",
            groupValue: _selectedGender,
            activeColor: Colors.green, // Change selected radio color to green
            onChanged: (value) {
              setState(() {
                _selectedGender = value.toString();
              });
            },
          ),
          const Text("Female"),
        ],
      ),
    ],
  );
}


  // Function to create Date Picker
  Widget _buildDatePicker() {
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedDate == null ? "Select Date of Birth" : DateFormat('yyyy-MM-dd').format(_selectedDate!),
              style: const TextStyle(fontSize: 16),
            ),
            const Icon(Icons.calendar_today, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // Function to add customer to the list
  void _addCustomer() {
    if (_nameController.text.isNotEmpty && _phoneController.text.isNotEmpty) {
      setState(() {
        customers.add({"name": _nameController.text, "phone": _phoneController.text});
      });
      Navigator.pop(context); // Close the dialog
      _nameController.clear();
      _phoneController.clear();
      _emailController.clear();
      _selectedDate = null;
      _selectedGender = "Male";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Customers",style: TextStyle(color: primaryColor),)),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: secondcolor,
                child: Text(customer['name'][0], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              title: Text(customer['name']),
              subtitle: Text(customer['phone']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCustomerDialog,
        backgroundColor: primaryColor,
        child: const Icon(Icons.person_add_alt, color: Colors.white),
      ),
    );
  }
}
