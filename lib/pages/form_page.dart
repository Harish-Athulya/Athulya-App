import 'dart:io';

import 'package:athulya_app/classes/food.dart';
import 'package:athulya_app/utils/constants.dart';
import 'package:athulya_app/widgets/custom_appbar.dart';
import 'package:athulya_app/widgets/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final items = [
    'Pallavaram',
    'Perungudi',
    'Neelankarai',
    'Arumbakkam',
    'Kasavanahalli'
  ];
  String selectedItem = 'Pallavaram';
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay(hour: 10, minute: 30);
  final foodType = ['Breakfast', 'Lunch', 'Snack', 'Dinner'];
  String? foodItem = 'Breakfast';

  final menuController = TextEditingController();
  String? dTime;

  String abbrBranch = '';
  String image = '';

  @override
  Widget build(BuildContext context) {
    final String abbrBranch;

    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: Text('Athulya Senior Care'),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    // margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    decoration: BoxDecoration(
                      // color: secondaryColor,
                      border: Border.all(color: secondaryColor, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          hint: Container(
                            width: 150,
                            child: Text(
                              'Select Branch',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          value: selectedItem,
                          isExpanded: true,
                          icon: Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            color: secondaryColor,
                          ),
                          items: items.map(buildMenuItem).toList(),
                          onChanged: (value) => setState(() {
                                this.selectedItem = value as String;
                              })),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2050));

                      if (selectedDate == null) return;
                      setState(() {
                        date = selectedDate;
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: Colors.red,
                            border:
                                Border.all(color: secondaryColor, width: 2)),
                        height: 55,
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${date.day}/${date.month}/${date.year}',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      TimeOfDay? newTime = await showTimePicker(
                          context: context, initialTime: time);

                      if (newTime == null) return;

                      setState(() {
                        time = newTime;
                        dTime = '${hours}:${minutes}';
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: secondaryColor, width: 2)),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${hours}:${minutes}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    // margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    decoration: BoxDecoration(
                      // color: secondaryColor,
                      border: Border.all(color: secondaryColor, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          hint: Container(
                            width: 150,
                            child: Text(
                              'Select Food Type',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          value: foodItem,
                          isExpanded: true,
                          icon: Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            color: secondaryColor,
                          ),
                          items: foodType.map(buildMenuItem).toList(),
                          onChanged: (value) => setState(() {
                                this.foodItem = value;
                              })),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // CustomDropdown(items, selectedItem),
                  Container(
                    height: 130,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        border: Border.all(color: secondaryColor, width: 2)),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: menuController,
                      maxLines: 3,

                      style: TextStyle(fontSize: 20),
                      cursorColor: Colors.black,
                      // cursorHeight: 30,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Menu Items'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: ElevatedButton(
                      child: Text(
                        'Select Image',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: selectFile,
                      style: ElevatedButton.styleFrom(
                        primary: secondaryColor,
                        minimumSize: Size.fromHeight(50),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (pickedFile != null)
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(color: secondaryColor, width: 2)),
                      // width: 500,
                      // height: 500,
                      child: Column(
                        children: [
                          Text(
                            'Image Preview',
                            style: TextStyle(
                                fontSize: 20,
                                color: secondaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(pickedFile!.name),
                          SizedBox(
                            height: 10,
                          ),
                          Image.file(File(pickedFile!.path!),
                              width: double.infinity, fit: BoxFit.contain),
                        ],
                      ),
                    ),
/* 
                  SizedBox(
                    height: 40,
                  ),
*/
                ],
              )),
            ),
            SizedBox(
              height: 80,
            ),
            Container(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50), primary: Colors.teal),
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: (() {
                      final String branchName = selectedItem;
                      final String foodDate = date.toString().substring(0, 10);
                      final String foodTime = time
                          .toString()
                          .replaceAll('TimeOfDay(', '')
                          .replaceAll(')', '');
                      final String foodType = foodItem!;
                      final int lastIndex =
                          (pickedFile!.path!).lastIndexOf('/') + 1;
                      final String apath = (pickedFile!.path!);
                      final String rpath = apath.substring(lastIndex);

                      final food = Food(
                          branch: branchName,
                          date: foodDate,
                          time: foodTime,
                          foodType: foodType,
                          menu: menuController.text,
                          imageName: rpath);

                      submit(food);

                      // print(lastIndex);
                      // print(apath);
                      // print(rpath);

                      // final food = Food(branch: )

                      // submit(),
                    })))
          ],
        ),
      ),
    );
  }

  PlatformFile? pickedFile;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
        // allowedExtensions: ['png', 'jpg'],
        // allowMultiple: false
        );

    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future submit(Food food) async {
    switch (selectedItem) {
      case 'Arumbakkam':
        abbrBranch = 'ARM';
        break;
      case 'Neelankarai':
        abbrBranch = 'NLK';
        break;
      case 'Pallavaram':
        abbrBranch = 'PVM';
        break;
      case 'Perungudi':
        abbrBranch = 'PRG';
        break;
    }

    switch (food.foodType) {
      case 'Breakfast':
        image = 'Img1';
        break;
      case 'Lunch':
        image = 'Img2';
        break;
      case 'Snack':
        image = 'Img3';
        break;
      case 'Dinner':
        image = 'Img4';
        break;
    }
    food.id = '${abbrBranch}-${food.date}-${image}';
    final docUser =
        FirebaseFirestore.instance.collection(food.branch!).doc(food.id);
    final json = food.toJson();
    await docUser.set(json);

    // print(abbrBranch);
    // print(food.date);
    // print(image);

    // print(food.id);

/*     print(selectedItem);
    print(date.toString().substring(0, 10));
    print(time.toString().replaceAll('TimeOfDay(', '').replaceAll(')', ''));
    print(foodItem);
    print(menuController.text);

 */
    // final snackBar = SnackBar(content: Text(selectedItem!));
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);

    final path = '${selectedItem}/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    try {
      final ref = FirebaseStorage.instance.ref().child(path);
      ref.putFile(file);

      final snackBar = SnackBar(content: Text('Content Uploaded'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.pop(context);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
        ));
  }
}
