import 'dart:io';
import 'package:athulya_app/utils/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_appbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PlatformFile? pickedFile;
  late List<PlatformFile> listFile;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
      listFile = result.files;
    });
  }

  Future uploadFile() async {
    final path = 'test/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);

/* 
    final snackBar = SnackBar(
      content: const Text('Image uploaded'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
 */

    final snackBar = SnackBar(content: Text('Image uploaded'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Athulya Senior Care'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 32,
            ),
            if (pickedFile != null)
              Expanded(
                  child: Container(
                // padding: EdgeInsets.symmetric(vertical: 10),
                // color: Colors.blue[100],

/*                 child: Center(
                  child: Text(pickedFile!.name),
                ), 
 */
                // final file = File(pickedFile!.path!)

                child: Image.file(File(pickedFile!.path!),
                    width: double.infinity, fit: BoxFit.contain),
              )),
            SizedBox(
              height: 32,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50), primary: secondaryColor),
                onPressed: selectFile,
                child: const Text('Select File')),
            SizedBox(
              height: 32,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50), primary: secondaryColor),
                onPressed: uploadFile,
                child: const Text('Upload File'))
          ],
        ),
      ),
    );
  }
}
