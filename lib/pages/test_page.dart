import 'package:athulya_app/utils/constants.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  final String value;

  // String date;
  final String date;
  const TestPage({Key? key, required this.value, required this.date})
      : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Athulya Senior Care'),
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: Column(
          children: [Text(widget.value), Text(widget.date)],
        ),
      ),
    );
  }
}
