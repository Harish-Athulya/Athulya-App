import 'dart:io';

import 'package:athulya_app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:athulya_app/classes/food.dart';

class DetailsGet extends StatefulWidget {
  final String branch;
  final String date;
  final String food;
  const DetailsGet(
      {Key? key, required this.branch, required this.date, required this.food})
      : super(key: key);

  @override
  State<DetailsGet> createState() => _DetailsGetState();
}

class _DetailsGetState extends State<DetailsGet> {
  @override
  Widget build(BuildContext context) {
    final documentId = Food.docId(widget.branch, widget.date, widget.food);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Athulya Senior Care'),
      ),

/*       body: Column(
        children: <Widget>[
          // Text(widget.branch),
          // Text(widget.date),
          // Text(widget.food)
          // Text(Food.docId(widget.branch, widget.date, widget.food))
        ],
      ),
 */
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection(widget.branch)
              .doc(documentId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              // Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
              // QueryDocumentSnapshot data =
              //     snapshot.data as QueryDocumentSnapshot;
              // return DocumentSnapshot(snapshot.data);
              return Text(data['imageName']);
            } else if (snapshot.hasError) {
              return Text('Error occured ${snapshot.error}');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return Text("Athulya");
          }),
    );
  }
}
