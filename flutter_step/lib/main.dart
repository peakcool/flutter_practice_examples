import 'package:flutter/material.dart';
import 'package:flutter_step/pages/account_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Flutter Demo',
      home: AccountPage(),
    );
  }
}