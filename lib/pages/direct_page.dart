import 'package:athulya_app/pages/main_page.dart';
import 'package:athulya_app/pages/my_home_page.dart';
import 'package:athulya_app/utils/constants.dart';
import 'package:flutter/material.dart';

class DirectPage extends StatefulWidget {
  const DirectPage({Key? key}) : super(key: key);

  @override
  State<DirectPage> createState() => _DirectPageState();
}

class _DirectPageState extends State<DirectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text('Athulya Senior Care'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50), primary: secondaryColor),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MyHomePage(title: 'title'))),
                child: Text(
                  'Food Update Form',
                  style: TextStyle(fontSize: 20),
                )),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50), primary: secondaryColor),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MainPage()));
                },
                child: Text(
                  'View Updates',
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
