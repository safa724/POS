// A reusable widget for input fields with check-circle and icons
import 'package:flutter/material.dart';
import 'package:pos/constants.dart';

Widget inputField({
  required IconData icon,
  required String label,
  required TextEditingController controller,
  bool isReadOnly = false,
  void Function()? onTap,
  bool hasTyped = false,
  TextInputType inputType = TextInputType.text,
  String hintText = '',
  List<Widget>? additionalWidgets,
  void Function(String)? onChanged, // Add this line for onChanged
}) {
  return Container(
    height: 80,
    width: double.infinity,
    color: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      children: [
        Icon(
          icon,
          color: hasTyped ? primaryColor : Colors.grey,
          size: 35,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(color: Colors.grey),
              ),
              TextField(
                controller: controller,
                readOnly: isReadOnly,
                keyboardType: inputType,
                onTap: onTap,
                onChanged: onChanged, // Pass the onChanged to the TextField
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
        if (additionalWidgets != null) ...additionalWidgets,
      ],
    ),
  );
}

Widget dropDownInput({
  required String label,
  required String? value,
  required Function(String?) onChanged,
  required List<String> options,
}) {
  return Container(
    height: 80,
    width: double.infinity,
    color: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      children: [
        Icon(
          Icons.check_circle,
          color: value != null && value.isNotEmpty ? primaryColor : Colors.grey,
          size: 35,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(color: Colors.grey),
              ),
              DropdownButton<String>(
                value: value?.isNotEmpty == true ? value : null,
                onChanged: onChanged,
                items: options.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                isExpanded: true,
                hint: Text(
                  'Select $label',
                  style: TextStyle(color: Colors.grey),
                ),
                underline: const SizedBox(),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


Widget fractionInput({required bool showFractionInput, required TextEditingController controller}) {
  if (!showFractionInput) return SizedBox.shrink();  // Only return if showFractionInput is true

  return Container(
    height: 70,
    width: double.infinity,
    color: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      children: [
        Icon(
          Icons.check_circle,
          color: controller.text.isNotEmpty ? primaryColor : Colors.grey,
          size: 35,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: 'Kg', // The placeholder for the input field
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

