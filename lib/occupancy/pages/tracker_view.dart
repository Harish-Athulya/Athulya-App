import 'package:athulya_app/utils/constants.dart';
import 'package:athulya_app/utils/firebase_file.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:athulya_app/classes/room.dart';
import 'package:pie_chart/pie_chart.dart';

class TrackerView extends StatefulWidget {
  const TrackerView({Key? key, required this.branch, required this.date})
      : super(key: key);
  final String branch;
  final String date;

  @override
  State<TrackerView> createState() => _TrackerViewState();
}

class _TrackerViewState extends State<TrackerView> {
  @override
  Widget build(BuildContext context) {
    final String docId = Room.docId(widget.branch, widget.date);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Athulya Senior Care'),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
/*               FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('Occupancy')
                    .doc(docId)
                    .get(),
 */
              FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('Occupancy')
                    .doc(docId)
                    .get(),
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong ${snapshot.error}');
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    final data = snapshot.data;
                    late final records;
                    if (data.toString() == 'null') {
                      return Center(
                          child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        child: Text(
                          // 'No records found, \nfor the given filter data',
                          'Occupancy data not updated for \n${widget.branch} on ${widget.date}',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: secondaryColor),
                        ),
                      ));
                    }
                    if (data != null) {
                      records = data;
                    }
                    Map<String, double> dataMap = {
/*                     "Vacant": ((double.parse(records['count']) -
                                  double.parse(records['occupied'])) /
                              double.parse(records['total'])) *
                          100,
 */
                      "Vacant": double.parse(records['count']) -
                          double.parse(records['occupied']),
                      "Occupied": double.parse(records['occupied']),
                    };
                    final vacant = int.parse(records['count']) -
                        int.parse(records['occupied']);
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                            border: Border.all(color: secondaryColor, width: 2),
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Text(records['count']),
                              // Text(records['occupied']),

/*                             RichText(
                                  text: TextSpan(
                                      text: 'Branch: ',
                                      style: TextStyle(
                                          fontSize: 20, color: secondaryColor),
                                      children: <TextSpan>[
                                    TextSpan(
                                        text: '${records['Branch']}',
                                        style: TextStyle(
                                            color: secondaryColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ])),
 */
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Branch : ${records['branch']}',
                                    style: styleForHeadText(),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Date : ${records['date']}',
                                    style: styleForHeadText(),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 30,
                              ),
                              // Text(records['occupied']),
                              PieChart(
                                dataMap: dataMap,
                                chartValuesOptions: ChartValuesOptions(
                                    showChartValuesInPercentage: true),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                // color: secondaryColor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Total Rooms = ${records['count']}',
                                      textAlign: TextAlign.left,
                                      style: styleForText(),
                                    ),
                                    Text(
                                      'Occupied Rooms = ${records['occupied']}',
                                      textAlign: TextAlign.left,
                                      style: styleForText(),
                                    ),
                                    Text(
                                      'Vacant Rooms = ${vacant}',
                                      style: styleForText(),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                      ),
                    );
                  } else {
                    return Text('Athulya');
                  }
                }),
              )
            ],
          ),
        )),
      ),
    );
  }

  TextStyle styleForText() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: primaryColor,
    );
  }

  TextStyle styleForHeadText() {
    return TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: secondaryColor);
  }
}
