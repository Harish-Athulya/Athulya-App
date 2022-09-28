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
                return Text('No records found');
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
                        children: [
/*                           ListView.builder(
                              itemCount: files!.length,
                              itemBuilder: ((context, index) {
                                final file = files[index];
                                return buildFile(context, file);
                              })),
*/
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
                              files.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: secondaryColor),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ImagePage(file: files)));
                            },
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
