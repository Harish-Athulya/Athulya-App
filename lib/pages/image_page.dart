import 'package:athulya_app/utils/constants.dart';
import 'package:athulya_app/utils/firebase_file.dart';
import 'package:athulya_app/utils/services_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({Key? key, required this.file}) : super(key: key);
  final FirebaseFile file;

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Preview'),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
              onPressed: () async {
                // await ServicesFirebase.downloadFile(widg-et.file.ref);
              },
              icon: Icon(
                Icons.file_download_outlined,
                color: Colors.white,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.file.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
                  fontSize: 20),
            ),
            Container(
                // padding: EdgeInsets.symmetric(vertical: 30),
                // color: primaryColor,
                height: 300,
                child: Image.network(widget.file.url, fit: BoxFit.contain)),
          ],
        ),
      ),
    );
  }
}
