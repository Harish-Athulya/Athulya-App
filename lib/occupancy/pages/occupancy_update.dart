import 'package:athulya_app/classes/room.dart';
import 'package:athulya_app/utils/constants.dart';
import 'package:athulya_app/widgets/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';

class OccupancyUpdate extends StatefulWidget {
  const OccupancyUpdate({Key? key}) : super(key: key);

  @override
  State<OccupancyUpdate> createState() => _OccupancyUpdateState();
}

class _OccupancyUpdateState extends State<OccupancyUpdate> {
  final branch = ['Pallavaram', 'Perungudi', 'Neelankarai', 'Arumbakkam'];
  String selectedBranch = 'Pallavaram';

  final TextEditingController countController = TextEditingController();
  final TextEditingController occupiedController = TextEditingController();

  DateTime date = DateTime.now();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final sdate = date.day.toString().padLeft(2, '0');
    final smonth = date.month.toString().padLeft(2, '0');
    final syear = date.year.toString().padLeft(4, '0');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Athulya Senior Care'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Select Facility:',
                  style: TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: secondaryColor, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                        isExpanded: true,
                        value: this.selectedBranch,
                        items: branch.map(buildMenuItem).toList(),
                        onChanged: (value) => setState(() {
                              this.selectedBranch = value!;
                            })),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Select Date:',
                  style: TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: date,
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
                            // '${date.day}/${date.month}/${date.year}',
                            '${sdate}/${smonth}/${syear}',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Total rooms at facility: ',
                  style: TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  // height: 55,
                  constraints: BoxConstraints(minHeight: 55),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: secondaryColor, width: 2),
                  ),
                  child: TextFormField(
                    controller: countController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(border: InputBorder.none),
                    style: TextStyle(fontSize: 20),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Total room count should not be empty";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Rooms Occupied: ',
                  style: TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // padding: const EdgeInsets.only(left: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  // height: 55,
                  constraints: BoxConstraints(minHeight: 55),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: secondaryColor, width: 2),
                  ),
                  child: TextFormField(
                    controller: occupiedController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      // contentPadding:
                      // const EdgeInsets.symmetric(vertical: 10)
                    ),
                    style: TextStyle(fontSize: 20),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Occupied room count should not be empty";
                      }
                      return null;
                    },
/*                     validator: (value) {
                      if (value == null || value.isEmpty) {
                        print("Rooms occupied should not be null");
                      }
                      return null;
                    },
 */
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50), primary: Colors.teal),
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      final String branchName = this.selectedBranch;
                      final String fdate = '${sdate}-${smonth}-${syear}';

                      final count = countController.text;
                      final occupied = occupiedController.text;

                      final docId = Room.docId(branchName, fdate);

                      final room = Room(
                          branch: branchName,
                          date: fdate,
                          count: count,
                          occupied: occupied);

                      submitRoomData(room);
/*                       print(docId);
                      print(count);
                      print(occupied);
 */

                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future submitRoomData(Room room) async {
    try {
      room.id = Room.docId(room.branch, room.date);
      final docUser =
          FirebaseFirestore.instance.collection('Occupancy').doc(room.id);
      final json = room.toJson();
      await docUser.set(json);

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
          style: TextStyle(fontSize: 20),
        ));
  }
}
