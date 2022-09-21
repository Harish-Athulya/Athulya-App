import 'package:athulya_app/pages/image_page.dart';
import 'package:athulya_app/utils/constants.dart';
import 'package:athulya_app/utils/firebase_file.dart';
import 'package:athulya_app/utils/services_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    futureFiles = ServicesFirebase.listAll('test/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text('Athulya Senior Care'),
      ),
      body: FutureBuilder<List<FirebaseFile>>(
        future: futureFiles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final files = snapshot.data;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(files!.length),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: files!.length,
                  itemBuilder: (context, index) {
                    final file = files[index];

                    return buildFile(context, file);
                  },
                ))
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Some error occurred while connecting'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
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

  Widget buildHeader(int length) {
    return ListTile(
      tileColor: primaryColor,
      leading: Container(
        width: 52,
        height: 52,
        child: Icon(
          Icons.file_copy,
          color: Colors.white,
        ),
      ),
      title: Text(
        '$length Files',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
      ),
    );
  }
}
