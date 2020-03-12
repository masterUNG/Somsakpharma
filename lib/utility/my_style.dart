import 'package:flutter/material.dart';

class MyStyle {
  double h1 = 24.0, h2 = 18.0;
  Color mainColor = Color.fromARGB(0xff, 0x31, 0xa3, 0x51);
  Color textColor = Color.fromARGB(0xff, 0x00, 0x73, 0x26);
  Color lightColor = Color.fromARGB(0xff, 0x68, 0xd5, 0x7f);
  Color bgColor = Color.fromARGB(0xff, 0x31, 0xa3, 0x51);
  Color barColor = Color.fromARGB(0xff, 0x00, 0x73, 0x26);

  TextStyle h1Style = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(0xff, 0x00, 0x73, 0x26));

  TextStyle h2Style = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(0xff, 0x00, 0x73, 0x26));

  TextStyle h3Style = TextStyle(
      fontSize: 16.0,
      // fontWeight: FontWeight.bold,
      color: Color.fromARGB(0xff, 0x31, 0xa3, 0x51));

  BoxDecoration boxLightGreen = BoxDecoration(
    borderRadius: BorderRadius.circular(12.0),
    color: Color.fromARGB(0xff, 0x68, 0xd5, 0x7f),
  );

  BoxDecoration boxLightGrey = BoxDecoration(
    borderRadius: BorderRadius.circular(12.0),
    color: Colors.grey.shade300,
  );

  String fontName = 'Sarabun';

  String readAllProduct =
      'http://www.somsakpharma.com/api/json_product.php?top=100';
  String readProductWhereMode =
      'http://www.somsakpharma.com/api/json_product.php?searchKey=';
  String getUserWhereUserAndPass =
      'http://www.somsakpharma.com/api/json_login.php';
  String getProductWhereId =
      'http://www.somsakpharma.com/api/json_productdetail.php?id=';

  String loadMyCart =
      'http://www.somsakpharma.com/api/json_loadmycart.php?memberId=';

  MyStyle();
}
