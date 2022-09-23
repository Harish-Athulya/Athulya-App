import 'package:athulya_app/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) => AppBar(
    backgroundColor: primaryColor,
    title: Text('Athulya Senior Care'),
  );
}
