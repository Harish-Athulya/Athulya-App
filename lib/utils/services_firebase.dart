import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_file.dart';

class ServicesFirebase {
  static Future<List<FirebaseFile>> listAll(String path) async {
    print('${path} 123');
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();

    final urls = await _getDownloadLinks(result.items);

    return urls
        .asMap()
        .map((key, value) {
          final ref = result.items[key];
          final name = ref.name;
          print(name);

          final file = FirebaseFile(ref: ref, name: name, url: value);

          return MapEntry(key, file);
        })
        .values
        .toList();
    ;
  }

  // static Future<List<FirebaseFile>> listFiles(
  static Future<FirebaseFile> listFiles(String branch, String fileName) async {
    final ref = FirebaseStorage.instance.ref(branch);
    final result = await ref.listAll();

    // final urls = await _getDownloadLinks(result.items);

    final urls = await ref.child(fileName).getDownloadURL();

    print(urls);

    final FirebaseFile ffile =
        FirebaseFile(ref: ref, name: result.items.first.name, url: urls);

    return ffile;

/*     return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          // print(name);
          // print(fileName);
          final file = FirebaseFile(ref: ref, name: name, url: url);

          if (name == fileName) {
            print('${fileName}');
          }
          return MapEntry(index, file);
        })
        .values
        .toList();
    ;
 */
  }

  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((e) => e.getDownloadURL()).toList());

  static Future downloadFile(Reference ref) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${ref.name}');

    await ref.writeToFile(file);
  }
}
