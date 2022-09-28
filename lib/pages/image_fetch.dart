import 'package:athulya_app/classes/food.dart';
import 'package:athulya_app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ImageFetch extends StatefulWidget {
  final String branchName;
  final String date;
  const ImageFetch({Key? key, required this.branchName, required this.date})
      : super(key: key);

  @override
  State<ImageFetch> createState() => _ImageFetchState();
}

class _ImageFetchState extends State<ImageFetch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text('Athulya Senior Care'),
      ),

/*       body: Column(
        children: <Widget>[Text(widget.branchName), Text(widget.date)],
      ),
 */
      body: StreamBuilder<List<Food>>(
        stream: readFoodData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong ${snapshot.error}');
          } else if (snapshot.hasData) {
            final dbfoodData = snapshot.data;

            return ListView.builder(
                itemCount: dbfoodData?.length,
                itemBuilder: (context, index) {
                  final record = dbfoodData![index];
                  return Text(record.menu);
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Stream<List<Food>> readFood() {
    return FirebaseFirestore.instance.collection('foodData').snapshots().map(
        (event) => event.docs.map((e) => Food.fromJson(e.data())).toList());
  }
  Stream<List<Food>> readFoodData() {
    return FirebaseFirestore.instance.collection('foodData2').snapshots().map(
        (event) => event.docs.map((e) => Food.fromJson(e.data())).toList());
  }
}
