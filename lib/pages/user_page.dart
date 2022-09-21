import 'dart:io';

import 'package:athulya_app/utils/constants.dart';
import 'package:athulya_app/utils/firebase_api.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text('Athulya Senior Care'),
        ),
        body: FutureBuilder<ListResult>(
            future: FirebaseApi.listAll(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final files = snapshot.data!.items;
                return ListView.builder(
                    itemCount: files.length,
                    itemBuilder: ((context, index) {
                      final file = files[index];

                      return ListTile(
                        title: Text(file.name),
                        trailing: IconButton(
                            onPressed: () {
                              downloadFile(file);
                            },
                            icon: const Icon(
                              Icons.download_outlined,
                              color: Colors.black,
                            )),
                      );
                    }));
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error occurred'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  Future downloadFile(Reference ref) async {
    // final dir = await getApplicationDocumentsDirectory();
    // final file = File('${dir.path}/${ref.name}');
    // await ref.writeToFile(file);
    final String urlImage;

    final url = ref.getDownloadURL();

    // Get file using dio plugin
    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${ref.name}';

    await Dio().download(url.toString(), path);

    if (url.toString().contains('.jpg')) {
      await GallerySaver.saveImage(path, toDcim: true);
    }

/*     appInfoApi.getLogoClient().then((String result) {
      setState(() {
        urlImageApi = result;
      });
    });
 */
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloaded ${ref.name}')),
    );
  }
}
