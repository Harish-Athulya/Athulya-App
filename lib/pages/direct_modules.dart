import 'package:athulya_app/occupancy/pages/occupancy_main.dart';
import 'package:athulya_app/pages/direct_page.dart';
import 'package:athulya_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DirectModules extends StatefulWidget {
  const DirectModules({Key? key}) : super(key: key);

  @override
  State<DirectModules> createState() => _DirectModulesState();
}

class _DirectModulesState extends State<DirectModules> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Athulya Senior Care'),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                // padding: EdgeInsets.symmetric(vertical: 20),
                // color: Colors.black,
                // constraints: BoxConstraints.expand(),
                width: double.infinity,
                height: 200,
                child: Image.asset('images/Occupancy_Image.jpg'),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: secondaryColor,
                      minimumSize: Size.fromHeight(50)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OccupancyMain()));
                  },
                  icon: Icon(Icons.bed_outlined),
                  label: Text(
                    'Occupancy Data',
                    style: TextStyle(fontSize: 20),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                child: Image.asset('images/Feedback_Image.jpg'),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: secondaryColor,
                      minimumSize: Size.fromHeight(50)),
                  onPressed: () {},
                  icon: Icon(Icons.note_add_outlined),
                  label: Text(
                    'Clinical Feedback',
                    style: TextStyle(fontSize: 20),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                child: Image.asset('images/Food_Image.jpg'),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: secondaryColor,
                      minimumSize: Size.fromHeight(50)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => DirectPage())));
                  },
                  icon: Icon(Icons.fastfood_outlined),
                  label: Text(
                    'Food Tracker',
                    style: TextStyle(fontSize: 20),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
