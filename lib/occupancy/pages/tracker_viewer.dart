import 'package:athulya_app/utils/constants.dart';
import 'package:athulya_app/utils/firebase_file.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:athulya_app/classes/room.dart';
import 'package:pie_chart/pie_chart.dart';

class TrackerViewer extends StatefulWidget {
  const TrackerViewer({Key? key, required this.branch, required this.date})
      : super(key: key);
  final String branch;
  final String date;

  @override
  State<TrackerViewer> createState() => _TrackerViewerState();
}

class _TrackerViewerState extends State<TrackerViewer> {
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
            children: [
              /* StreamBuilder(
                  stream: readRoom2(docId).snapshots(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data;

                      return Text('${data.toString()}');
                    } else {
                      return Text('No records found');
                    }
                  })) */
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

  Stream<List<Room>> readRoom() {
    return FirebaseFirestore.instance.collection('Occupancy').snapshots().map(
        (event) => event.docs.map((e) => Room.fromJson(e.data())).toList());
  }

  void readRoom2(String docId) {
    final roomLists = FirebaseFirestore.instance
        .collection('Occupancy')
        .snapshots()
        .map((event) => event.docs
            .map((e) => Room.fromJson(e.data()))
            .where((element) => element.id == docId)
            .toList());

    // final room = roomLists.map((event) => event.)
/* 
    final CollectionReference occupancyCollection =
        FirebaseFirestore.instance.collection('Occupancy');
    final Query select = occupancyCollection.where('id', isEqualTo: docId);

    final room = select
        .snapshots()
        .map((event) => event.docs.map((e) => Room.fromJson(e.data())));

    select.snapshots(); 
  */

    int roomCount = 0;
    Room room;

    roomLists.forEach((element) {
      print("Element length = ${element.length}");
      room = element.first;
    });

    /* if(room == null) {

    } */

    print("Room count = ${roomCount}");

    // return room;
  }
}
