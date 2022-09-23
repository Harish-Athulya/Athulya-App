import 'package:athulya_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomWidgets extends StatefulWidget {
  const CustomWidgets({Key? key}) : super(key: key);

  @override
  State<CustomWidgets> createState() => _CustomWidgetsState();
}

class _CustomWidgetsState extends State<CustomWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

Widget CustomDropdown(List<String> items, String? selectedItem) => Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: secondaryColor, width: 2)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            isExpanded: true,
            icon: Icon(
              Icons.arrow_drop_down_circle_outlined,
              color: secondaryColor,
            ),
            value: selectedItem,
            items: items.map(buildMenuItem).toList(),
            onChanged: (value) =>  
            selectedItem = value),
      ),
    );

DropdownMenuItem<String> buildMenuItem(String item) {
  return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
      ));
}
