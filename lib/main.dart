import 'package:flutter/material.dart';
import 'package:somsakpharma/scaffold/authen.dart';

void main() {
  runApp(MyApp());
} //

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: Authen(),
    );
  }
}
