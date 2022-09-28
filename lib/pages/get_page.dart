import 'package:athulya_app/classes/food.dart';
import 'package:athulya_app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class GetPage extends StatefulWidget {
  final String branch;
  final String date;
  final String foodType;

  const GetPage(
      {Key? key,
      required this.branch,
      required this.date,
      required this.foodType})
      : super(key: key);

  @override
  State<GetPage> createState() => _GetPageState();
}

class _GetPageState extends State<GetPage> {
  Stream<QuerySnapshot> upstream =
      FirebaseFirestore.instance.collection('Pallavaram').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Athulya Senior Care'),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: StreamBuilder<List<Food>>(
        stream: checkSubmit(),
        builder: (context, snapshot) {
          final food = snapshot.data;
          return ListView(
            children: food!.map((e) => Text(e.imageName)).toList(),
          );
        },
      ),

/*         body: Column(
          children: <Widget>[
            Text(widget.branch),
            Text(widget.date),
            Text(widget.foodType)
          ],
        )
 */
      /*
      body: StreamBuilder<List<Food>>(
          stream: checkSubmit(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong ${snapshot.error}');
            } 
            else if (!snapshot.hasData) {
              return Center(child: Text('Data Not Found'));
            } 
            else if (snapshot.hasData) {
              final food = snapshot.data;

              return ListView(
                children: food!.map(buildUser).toList(),
              );
            } 
            else {
              return Center(child: CircularProgressIndicator());
            }
          }),

*/
    );
  }

  Widget buildUser(Food food) => ListTile(
        leading: CircleAvatar(child: Text('${food.id}')),
        // title: Text(user.name),
        // subtitle: Text(user.birthday.toIso8601String()),
      );

  Stream<List<Food>> checkSubmit() {
    return FirebaseFirestore.instance.collection('foodData2').snapshots().map(
        (event) => event.docs.map((e) => Food.fromJson(e.data())).toList());
  }
}
