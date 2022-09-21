import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_file.dart';

class ServicesFirebase {
  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();

    final urls = await _getDownloadLinks(result.items);

    return urls
        .asMap()
        .map((key, value) {
          final ref = result.items[key];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: value);

          return MapEntry(key, file);
        })
        .values
        .toList();
    ;
  }

  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((e) => e.getDownloadURL()).toList());

  static Future downloadFile(Reference ref) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${ref.name}');

    await ref.writeToFile(file);
  }
}
