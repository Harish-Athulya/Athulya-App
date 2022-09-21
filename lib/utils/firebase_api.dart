import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi {
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) async {
    return Future.wait(refs.map((e) => e.getDownloadURL()).toList());
  }

  static Future<ListResult> listAll() async {
    


    Future<ListResult> results = FirebaseStorage.instance.ref('/test').listAll();

    /* 
    results.items.forEach((element) {
      print('File: $element');
    });
 */

    return results;
    
    // final urls = await _getDownloadLinks(results.items);


    /* return urls.asMap().map((key, value) {
      final ref = results.items[index];
      final name = ref.name;
    }); */
  }
}
