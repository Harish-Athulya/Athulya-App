import 'package:athulya_app/occupancy/pages/occupancy_tracker.dart';
import 'package:athulya_app/occupancy/pages/occupancy_update.dart';
import 'package:athulya_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class OccupancyMain extends StatefulWidget {
  const OccupancyMain({Key? key}) : super(key: key);

  @override
  State<OccupancyMain> createState() => _OccupancyMainState();
}

class _OccupancyMainState extends State<OccupancyMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text('Athulya Senior Care'),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Text('Harish')

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => OccupancyUpdate()));
              },
              child: Text(
                'Occupancy Data Update',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: secondaryColor, minimumSize: Size.fromHeight(50)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OccupancyTracker()));
              },
              child: Text(
                'Occupancy Tracker',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: secondaryColor, minimumSize: Size.fromHeight(50)),
            )
          ],
        ),
      ),
    );
  }
}
