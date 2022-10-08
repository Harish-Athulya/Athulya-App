import 'package:athulya_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class OccupancyTracker extends StatefulWidget {
  const OccupancyTracker({Key? key}) : super(key: key);

  @override
  State<OccupancyTracker> createState() => _OccupancyTrackerState();
}

class _OccupancyTrackerState extends State<OccupancyTracker> {
  final branch = ['Pallavaram', 'Perungudi', 'Neelankarai', 'Arumbakkam'];
  String selectedBranch = 'Pallavaram';
  DateTime date = DateTime.now();

  int count = 0;
  late final counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    counter = 0;
  }

  @override
  Widget build(BuildContext context) {
    final sdate = date.day.toString().padLeft(2, '0');
    final smonth = date.month.toString().padLeft(2, '0');
    final syear = date.year.toString().padLeft(2, '0');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Athulya Senior Care'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
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
                height: 40,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.teal, minimumSize: Size.fromHeight(50)),
                  onPressed: () {
                    setState(() {
                      count = count + 1;
                      counter = counter + 1;
                      print(count);
                      print(counter);
                    });
                    // count++;
                  },
                  child: Text(
                    'Fetch Data',
                    style: TextStyle(fontSize: 20),
                  )),
              SizedBox(
                height: 20,
              ),
              if (count != 0)
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: secondaryColor, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                )
            ],
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
          style: TextStyle(fontSize: 20),
        ));
  }
}
