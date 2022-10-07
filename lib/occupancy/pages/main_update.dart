import 'package:athulya_app/utils/constants.dart';
import 'package:athulya_app/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';

class MainUpdate extends StatefulWidget {
  const MainUpdate({Key? key}) : super(key: key);

  @override
  State<MainUpdate> createState() => _MainUpdateState();
}

class _MainUpdateState extends State<MainUpdate> {
  final branch = ['Pallavaram', 'Perungudi', 'Neelankarai', 'Arumbakkam'];
  String selectedBranch = 'Pallavaram';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Athulya Senior Care'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Select Branch:',
                style: TextStyle(
                    color: secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButton<String>(
                  isExpanded: true,
                  value: this.selectedBranch,
                  items: branch.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() {
                        this.selectedBranch = value!;
                      })),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontSize: 20),
        ));
  }
}
