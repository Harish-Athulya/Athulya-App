import 'dart:ui';

import 'package:athulya_app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:athulya_app/classes/room.dart';
import 'package:pie_chart/pie_chart.dart';

class ViewTracker extends StatefulWidget {
  const ViewTracker({Key? key, required this.branch, required this.date})
      : super(key: key);
  final String branch;
  final String date;

  @override
  State<ViewTracker> createState() => _ViewTrackerState();
}

class _ViewTrackerState extends State<ViewTracker> {
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
              StreamBuilder<List<Room>>(
                  stream: getRoomData(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      final records = snapshot.data;
                      late final Room roomDoc;
                      bool empty = true;

                      for (var record in records!) {
                        print(record.id);
                        if (record.id == docId) {
                          roomDoc = record;
                          empty = false;
                          print(record.count);
                          break;
                        }
                      }

                      if (empty) {
                        return Center(
                          child: Container(
                            child: Text(
                              'No data uploaded for \n${widget.branch} on ${widget.date}',
                              style: styleForHeadText(),
                            ),
                          ),
                        );
                      } else {
                        Map<String, double> dataMap = {
                          "Vacant": double.parse(roomDoc.count) -
                              double.parse(roomDoc.occupied),
                          "Occupancy": double.parse(roomDoc.occupied)
                        };

                        final vacant = int.parse(roomDoc.count) -
                            int.parse(roomDoc.occupied);

                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: secondaryColor, width: 2),
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Branch : ${roomDoc.branch}',
                                        style: styleForHeadText(),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Date : ${roomDoc.date}',
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Total Rooms = ${roomDoc.count}',
                                          textAlign: TextAlign.left,
                                          style: styleForText(),
                                        ),
                                        Text(
                                          'Occupied Rooms = ${roomDoc.occupied}',
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
                      }
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Container(
                          child: Text('Something went wrong ${snapshot.error}'),
                        ),
                      );
                    } else {
                      return Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  }))
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

  Stream<List<Room>> getRoomData() {
    return FirebaseFirestore.instance.collection('Occupancy').snapshots().map(
        (event) => event.docs.map((e) => Room.fromJson(e.data())).toList());
  }
}
