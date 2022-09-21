import 'package:athulya_app/utils/constants.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  List<String> items = ['Pallavaram', 'Perungudi', 'Neelankarai', 'Arumbakkam'];
  String? selectedItem = 'Pallavaram';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Athulya Senior Care'),
        backgroundColor: primaryColor,
      ),
      body: Container(
        child: Form(
          child: Column(
            children: [
              // DropdownButton<String>(
                // value: selectedItem, 
/*                 items: items.map((item) => 
                  DropdownMenuItem<String>(value: item, 
                  child: Text(item, style: TextStyle(),))), 
                onChanged: onChanged
               )
 */
           ],
          )
        ),
      ),
    );
  }
}
