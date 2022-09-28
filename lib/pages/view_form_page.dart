import 'package:athulya_app/classes/food.dart';
import 'package:athulya_app/pages/details_get.dart';
import 'package:athulya_app/pages/get_page.dart';
import 'package:athulya_app/pages/image_fetch.dart';
import 'package:athulya_app/pages/test_page.dart';
import 'package:athulya_app/utils/constants.dart';
import 'package:athulya_app/widgets/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewFormPage extends StatefulWidget {
  const ViewFormPage({Key? key}) : super(key: key);

  @override
  State<ViewFormPage> createState() => _ViewFormPageState();
}

class _ViewFormPageState extends State<ViewFormPage> {
  bool isContainer = false;
  final value = 'Athulya Senior Care';
  final items = ['Pallavaram', 'Perungudi', 'Neelankarai', 'Arumbakkam'];
  String selectedItem = 'Pallavaram';
  final foodInterval = ['Breakfast', 'Lunch', 'Snack', 'Dinner'];
  String foodItem = 'Breakfast';
  DateTime date = DateTime.now();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text("Athulya Senior Care"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                // border: Border.all(color: secondaryColor, width: 4)
                ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    'Select Branch',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    height: 55,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    decoration: BoxDecoration(
                        border: Border.all(color: secondaryColor, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedItem,
                          items: items.map(buildMenuItem).toList(),
                          onChanged: (value) => setState(() {
                                this.selectedItem = value as String;
                              })),
                    )),
                SizedBox(
                  height: 15,
                ),
                Container(
                  // padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    'Select Date',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 10,
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
                          border: Border.all(color: secondaryColor, width: 2)),
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
                Container(
                    height: 55,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    decoration: BoxDecoration(
                        border: Border.all(color: secondaryColor, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          isExpanded: true,
                          value: foodItem,
                          items: foodInterval.map(buildMenuItem).toList(),
                          onChanged: (value) => setState(() {
                                foodItem = value as String;
                              })),
                    )),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50), primary: Colors.teal),
                    onPressed: () {
                      // print(selectedItem);
                      // print(selectedItem.runtimeType);
                      String selectedDate = date.toString().substring(0, 10);
                      // print(selectedDate);
                      // print(selectedDate.runtimeType);

                      /*                     Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageFetch(
                                    branchName: selectedItem!,
                                    date: selectedDate,
                                  )));
       */

                      /*                     Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TestPage(value: selectedItem, date: selectedDate)));
       */

                      /* 
                      setState(() {
                        isVisible = true;
                      });
       */
                      // isContainer = true;
/*                     Navigator.of(context).push(MaterialPageRoute
                    (builder: (context) => GetPage(branch: selectedItem, date: selectedDate, foodType: foodItem!)));
                   
 */

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailsGet(
                              branch: selectedItem,
                              date: selectedDate,
                              food: foodItem)));
                    },
                    child: Text('Check for Records')),

/*                
                if (isContainer)
                  Container(
                    color: secondaryColor,
                    // height: 50,
                    child: StreamBuilder<List<Food>>(
                      stream: checkSubmit(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        } else if (!snapshot.hasData) {
                          return Text('No data found');
                        }
                        return Text('Athulya');
                      },
                    ),
                  )
 */
              ],
            ),
          ),
        ),
      ),
    );
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
