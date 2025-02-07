import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; // For formatting dates
import 'package:pos/barcode.dart';
import 'package:pos/constants.dart';

class NewVariant extends StatefulWidget {
  const NewVariant({super.key});

  @override
  State<NewVariant> createState() => _NewVariantState();
}

class _NewVariantState extends State<NewVariant> {
  File? _image;
  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;
  bool isInclusive = false;
  DateTime selectedDate = DateTime.now(); // Initial date
  String expiryAlertDays = '';
  String taxAmount = '';
 final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemPriceController = TextEditingController();
   final TextEditingController itemStockController = TextEditingController();
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Widget _buildAnimatedContainer({
    required String title,
    required String imagePath,
    required bool isChecked,
    required ValueChanged<bool?> onChanged,
    required Widget child,
  }) {
    return AnimatedContainer(
      color: isChecked ? Colors.transparent : Colors.white,
      duration: const Duration(milliseconds: 300),
      height: isChecked ? 160 : 80,
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  color: primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(2.5),
                    child: Image.asset(imagePath, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20),
                Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
                Spacer(),
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: primaryColor,
                  value: isChecked,
                  onChanged: onChanged,
                ),
              ],
            ),
            if (isChecked)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: child,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Variant"),
         actions: [
  GestureDetector(
    onTap: () {
      Map<String, dynamic> variantData = {
       "variantName": itemNameController.text,
    "sellingPrice": itemPriceController.text,  // Add this line
   // "costPrice": costPriceController.text,        // Add this line
    "stockAvailable": itemStockController.text,  // Add this line
    "expiryDate": selectedDate,
    "expiryAlertDays": expiryAlertDays,
    "taxAmount": taxAmount,
    "isInclusive": isInclusive,
      };

      Navigator.pop(context, variantData); // Return data to the previous screen
    },
    child: Container(
      height: 40,
      width: 100,
      color: Colors.green,
      child: const Center(
        child: Text(
          'ADD',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  ),
  const SizedBox(width: 20),
],

        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildImagePicker(),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextFieldSection(
                        controller: itemNameController,
                        label: 'Variant Name',
                        hintText: 'Ex: 500gm, blue, 1kg, 1ltr',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildTextFieldSection(
                  controller: itemPriceController,
                    label: 'Selling Price', hintText: 'AED 0.00'),
                const SizedBox(height: 10),
                _buildTextFieldSection(
                  controller: itemStockController,
                    label: 'Stock Available', hintText: '0'),
                const SizedBox(height: 10),
                _buildAnimatedContainer(
                  imagePath: 'images/bar.webp',
                  title: 'Barcode?',
                  isChecked: isChecked,
                  onChanged: (value) => setState(() => isChecked = value!),
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Barcode()),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    child:
                        const Text('Scan', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 10),
                _buildAnimatedContainer(
                  imagePath: 'images/track.webp',
                  title: 'Track Expiry?',
                  isChecked: isChecked1,
                  onChanged: (value) => setState(() => isChecked1 = value!),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: _pickDate,
                              child: Container(
                                color: Colors.white,
                                height: 80,
                                child: Center(
                                  child: Text(
                                    'Expiry Date: ${DateFormat('dd/MM/yyyy').format(selectedDate)}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              height: 80,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Enter Alert Days',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                              TextField(
  keyboardType: TextInputType.number,
  onChanged: (value) => expiryAlertDays = value,
  cursorColor: primaryColor,
  decoration: InputDecoration(
    border: InputBorder.none, // No border
    contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0), // Smaller padding
  ),
)

                                
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                _buildAnimatedContainer(
                  imagePath: 'images/tax.png',
                  title: 'Add Tax',
                  isChecked: isChecked2,
                  onChanged: (value) => setState(() => isChecked2 = value!),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                            height: 80,
                              color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                   Text('Enter Tax Amount',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) => taxAmount = value,
                                 decoration: InputDecoration(
    border: InputBorder.none, // No border
    contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0), // Smaller padding
  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: 80,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: isInclusive,
                                onChanged: (value) {
                                  setState(() => isInclusive = value!);
                                },
                              ),
                                const Text('Inclusive'),
                            ],
                          ),
                        ),
                      ),
                    
                    ],
                  ),
                ),
                    const SizedBox(height: 10),
                _buildAnimatedContainer(
                  imagePath: 'images/notes.webp',
                  title: 'Internal notes',
                  isChecked: isChecked3,
                  onChanged: (value) => setState(() => isChecked3 = value!),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                            height: 80,
                              color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                   Text('Internal Notes',style: TextStyle(fontSize: 10),),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) => taxAmount = value,
                                 decoration: InputDecoration(
    border: InputBorder.none, // No border
    contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0), // Smaller padding
  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    
                    
                    ],
                  ),
                ),
                           const SizedBox(height: 10),
                _buildAnimatedContainer(
                  imagePath: 'images/tag.webp',
                  title: 'Add Compare price / AED',
                  isChecked: isChecked4,
                  onChanged: (value) => setState(() => isChecked4 = value!),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                            height: 80,
                              color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                   Text('Compare (or) Display Price',style: TextStyle(fontSize: 10),),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) => taxAmount = value,
                                 decoration: InputDecoration(
    border: InputBorder.none, // No border
    contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0), // Smaller padding
  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                       
                
                   
                    
                    ],
                  ),
                ),
                   const SizedBox(width: 10),
                       const SizedBox(height: 10),
                _buildAnimatedContainer(
                  imagePath: 'images/sku.webp',
                  title: 'SKU',
                  isChecked: isChecked5,
                  onChanged: (value) => setState(() => isChecked5 = value!),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                            height: 80,
                              color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                   Text('sku',style: TextStyle(fontSize: 10),),
                                TextField(
                                  
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) => taxAmount = value,
                                 decoration: InputDecoration(
    border: InputBorder.none, // No border
    contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0), // Smaller padding
  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    
                    
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

Widget _buildTextFieldSection({
  required String label,
  required String hintText,
  required TextEditingController controller, // Add controller parameter
}) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.black)),
        const SizedBox(height: 8),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(color: Colors.grey[200]),
          child: TextField(
            controller: controller, // Assign controller here
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );
}


  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(75),
        ),
        child: _image == null
            ? CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.camera_alt,
                    color: primaryColor, size: 20),
              )
            : ClipOval(
                child: Image.file(
                  _image!,
                  fit: BoxFit.cover,
                  width: 150,
                  height: 150,
                ),
              ),
      ),
    );
  }
}
