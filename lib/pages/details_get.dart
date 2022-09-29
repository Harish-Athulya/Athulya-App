import 'dart:io';

import 'package:athulya_app/utils/constants.dart';
import 'package:athulya_app/utils/firebase_file.dart';
import 'package:athulya_app/utils/services_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:athulya_app/classes/food.dart';

import 'image_page.dart';

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
    // Map<String, dynamic> data = {"branch": 0};
    final documentId = Food.docId(widget.branch, widget.date, widget.food);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
              final data = snapshot.data!.data();
              late final records;
              // late Future<List<FirebaseFile>> futureFiles;
              late Future<FirebaseFile> futureFiles;
              if (data.toString() == 'null') {
                return Center(
                    child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  child: Text(
                    // 'No records found, \nfor the given filter data',
                    'Food data not updated for \n${widget.food} on ${widget.date} at \n${widget.branch}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor),
                  ),
                ));
              }
              /* Map<String, dynamic> data =
                  snapshot.data?.data() as Map<String, dynamic> ??
                      {"Records": 0};
 */
              /* if (data['Records'] == 0) {
                return Text('Null records');
              } */

              /* if (data.isEmpty) {
                return Text("No records found for the current filter");
              } */
              // Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
              // QueryDocumentSnapshot data =
              //     snapshot.data as QueryDocumentSnapshot;
              // return DocumentSnapshot(snapshot.data);
              // return Text('${data.isEmpty} value');
              // return Text(data['imageName']);
              if (data != null) {
                records = data;
                futureFiles = ServicesFirebase.listFiles(
                    // '${records['branch']}/${records['imageName']}');
                    '${records['branch']}',
                    '${records['imageName']}');
/* 
                futureFiles = ServicesFirebase.listAll(
                    // '${records['branch']}/${records['imageName']}');
                    '${records['branch']}');
*/

              }
              // return Text(records['imageName']);
              return FutureBuilder<FirebaseFile>(
                  future: futureFiles,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final files = snapshot.data;

                      return Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
/*                           ListView.builder(
                              itemCount: files!.length,
                              itemBuilder: ((context, index) {
                                final file = files[index];
                                return buildFile(context, file);
                              })),
*/

                          SizedBox(
                            height: 50,
                          ),
                          ListTile(
                            leading: ClipOval(
                              child: Image.network(
                                files!.url,
                                width: 52,
                                height: 52,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              '${records['foodType']} - ${records['menu']}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: secondaryColor),
                            ),
                            // tileColor: secondaryColor,
                            subtitle: Text(
                              '${records['branch']} on ${records['date']} at ${records['time']}',
                              style: TextStyle(color: secondaryColor),
                            ),
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) =>
                              //         ImagePage(file: files)));
                            },
                          ),

                          SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: secondaryColor, width: 3)),
                                // padding: EdgeInsets.fromLTRB(12, 50, 12, 12),
                                padding: EdgeInsets.all(40),
                                // color: primaryColor,
                                height: 400,
                                width: double.infinity,
                                child: Image.network(files.url,
                                    fit: BoxFit.contain)),
                          ),

                          // Text('Athulya ${files.name}'),
                          // Text('Athulya ${files?.ref}'),
                          // Text('Athulya ${files?.url}')
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('Something went wrong');
                    } else {
                      return CircularProgressIndicator();
                    }
                  });
            } else if (snapshot.hasError) {
              return Text('Error occured ${snapshot.error}');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return Text("Athulya");
          }),
    );
  }

  Widget buildFile(BuildContext context, FirebaseFile file) {
    return ListTile(
      leading: ClipOval(
        child: Image.network(
          file.url,
          width: 52,
          height: 52,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        file.name,
        style: TextStyle(fontWeight: FontWeight.bold, color: secondaryColor),
      ),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ImagePage(
                file: file,
              ))),
    );
  }
}
