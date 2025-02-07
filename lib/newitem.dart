import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/constants.dart';
import 'dart:io';

import 'package:pos/newcategory.dart';
import 'package:pos/newvarient.dart';
import 'package:pos/widgets/newitemwidgets.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  // Controllers for the text fields
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController kgController = TextEditingController();

  // Variable to store the selected image
  File? _image;
  bool isCategorySelected = false;


  // Dropdown value for sell type
  String? _sellType = 'Sell by Unit'; // Default value
  final List<String> _sellTypes = ['Sell by Unit', 'Sell by Fraction'];
String variantName = "Enter Variant Name";
String sellingPrice = "AED 0.00";
String costPrice = "-";
String stockAvailable = "-";
  // Function to pick image from gallery or camera
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery, // Change to ImageSource.camera to use the camera
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  List<Map<String, dynamic>> variantsWithValues = [];
final List<Map<String, String>> _categories = [
    {'name': 'Fruits', 'image': 'images/fruits.jpeg'},
    {'name': 'Vegetables', 'image': 'images/veg.avif'},
    {'name': 'Dairy', 'image': 'images/dairy.avif'},
    {'name': 'Meat', 'image': 'images/meat.jpeg'},
    {'name': 'Bakery', 'image': 'images/bakery.avif'},
    {'name': 'Beverages', 'image': 'images/bev.webp'},
  ];
  // Function to show the bottom sheet for categories
   void _showCategoryBottomSheet() {
    showModalBottomSheet(
      context: context,
     
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            SizedBox(
  width: double.infinity, // Makes the button take full width
  child: ElevatedButton.icon(
    onPressed: () {
      // Logic to add a new category
     
            Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>NewCategory()),
                    );
          
    },
    icon: Icon(Icons.add,color: Colors.white,),
    label: Text('Add New Category'),
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Makes the button rectangular
      ),
    ),
  ),
)
,
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          categoryController.text = category['name']!;
                        });
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey),
                                image: DecorationImage(
                                  image: AssetImage(category['image']!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            category['name']!,
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
   

String _selectedOption = 'Simple'; // Track selected option
List<Map<String, TextEditingController>> variants = []; // Track multiple variants

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Manage Item'),
      actions: [
        Container(
          height: 40,
          width: 100,
          color: secondcolor,
          child: Center(
            child: Text(
              'SAVE',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 20),
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            // Item name input field
            inputField(
              icon: Icons.check_circle,
              label: 'Item name',
              controller: itemNameController,
              hintText: 'Ex: Apple',
              hasTyped: itemNameController.text.isNotEmpty,
              onChanged: (value) {
                setState(() {
                  var hasTyped = value.isNotEmpty;
                });
              },
            ),
            SizedBox(height: 10),
            // Category input field
            inputField(
              icon: Icons.check_circle,
              label: 'Category',
              controller: categoryController,
              isReadOnly: true,
              hintText: 'Ex: Fruits',
              onTap: () => _showCategoryBottomSheet(),
              additionalWidgets: [
                Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                  color: primaryColor,
                ),
              ],
            ),
            SizedBox(height: 10),
            // Sell Type Row
            Row(
              children: [
                Expanded(
                  child: dropDownInput(
                    label: 'Sell Type',
                    value: _sellType,
                    onChanged: (String? newValue) {
                      setState(() {
                        _sellType = newValue!;
                      });
                    },
                    options: _sellTypes,
                  ),
                ),
                if (_sellType == 'Sell by Fraction')
                  Container(
                    width: 100, // Fixed width for the fraction input
                    child: fractionInput(
                      showFractionInput: _sellType == 'Sell by Fraction',
                      controller: kgController,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            // Simple / Advanced toggle
          GestureDetector(
 onTap: () {
    setState(() {
      if (_selectedOption == 'Advanced') {
        // Remove empty variants (those with initial/default values)
        variantsWithValues.removeWhere((variant) =>
          variant['variantName'] == "Enter Variant Name" &&
          variant['sellingPrice'] == "AED 0.00" &&
          variant['costPrice'] == "-" &&
          variant['stockAvailable'] == "-"
        );
      }
      _selectedOption = _selectedOption == 'Simple' ? 'Advanced' : 'Simple';
    });
  },
  child: Container(
    height: 50,
    width: double.infinity,
    color: Colors.white,
    child: Row(
      children: [
        Expanded(
          child: Container(
            color: _selectedOption == 'Simple' ? primaryColor : Colors.white,
            child: Center(
              child: Text(
                'Simple',
                style: TextStyle(
                  color: _selectedOption == 'Simple' ? Colors.white : primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
       Expanded(
  child: Container(
    color: _selectedOption == 'Advanced' ? primaryColor : Colors.white,
    child: Center(
      child: Text(
        'Advanced',
        style: TextStyle(
          color: _selectedOption == 'Advanced' ? Colors.white : primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
),

      ],
    ),
  ),
),

SizedBox(height: 20),

// Conditionally show Selling Price or Variant Section
if (_selectedOption == 'Simple')
  inputField(
    icon: Icons.check_circle,
    label: 'Selling Price',
    controller: priceController,
    hintText: '0.00',
    hasTyped: priceController.text.isNotEmpty,
    onChanged: (value) {
      setState(() {
        var hasTyped = value.isNotEmpty;
      });
    },
  )
else
  Column(
    children: [
      // Display existing variants if any, including the first one with values
      ...variantsWithValues.map((variant) {
        int index = variantsWithValues.indexOf(variant);
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
          onTap: () async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => NewVariant()),
  );

  if (result != null) {
    setState(() {
      // Update only the tapped variant
      variantsWithValues[index] = {
        'image': result["image"], // Update image if necessary
        'variantName': result["variantName"] ?? "Enter Variant Name",
        'sellingPrice': result["sellingPrice"] ?? "AED 0.00",
        'costPrice': result["costPrice"] ?? "-",
        'stockAvailable': result["stockAvailable"] ?? "-",
      };
    });
  }
},
 child: Container(
  height: 140,
  width: double.infinity,
  color: Colors.white,
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(100),
              ),
              child: variantsWithValues[index]['image'] == null
                  ? CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.camera_alt, color: primaryColor, size: 20),
                    )
                  : ClipOval(
                      child: Image.file(
                        variantsWithValues[index]['image'],
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                    ),
            ),
            SizedBox(width: 10),
            Text(variantsWithValues[index]['variantName']),
          ],
        ),
        SizedBox(height: 5),
        Divider(color: Colors.grey),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Selling Price', style: TextStyle(fontSize: 11)),
                SizedBox(height: 5),
                Text(variantsWithValues[index]['sellingPrice'], style: TextStyle(fontSize: 11)),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cost Price', style: TextStyle(fontSize: 11)),
                SizedBox(height: 5),
                Text(variantsWithValues[index]['costPrice'], style: TextStyle(fontSize: 11)),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Stock Available', style: TextStyle(fontSize: 11)),
                SizedBox(height: 5),
                Text(variantsWithValues[index]['stockAvailable'], style: TextStyle(fontSize: 11)),
              ],
            ),
          ],
        ),
      ],
    ),
  ),
),

          ),
        );
      }).toList(),

      // Always show the "+ Add Variant" button when in 'Advanced' mode
      if (_selectedOption == 'Advanced')
       TextButton(
  onPressed: () {
    setState(() {
      // Add an empty variant with default string values
      variantsWithValues.add({
        'image': null, // No image initially
        'variantName': "Enter Variant Name",
        'sellingPrice': "AED 0.00",
        'costPrice': "-",
        'stockAvailable': "-",
      });
    });
  },
  child: Text(
    '+ Add Variant',
    style: TextStyle(color: primaryColor),
  ),
),

    ],
  ),

            SizedBox(height: 20),
            // Image picker area
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(75),
                  ),
                  child: _image == null
                      ? CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: Icon(
                            Icons.camera_alt,
                            color: primaryColor,
                            size: 50,
                          ),
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
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}