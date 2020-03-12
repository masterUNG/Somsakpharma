import 'package:flutter/material.dart';

class MyStyle {
  double h1 = 24.0, h2 = 18.0;
  Color mainColor   = Colors.blueGrey.shade700;
  Color textColor = Colors.blueGrey.shade500;
  Color bgColor = Colors.green.shade100;
  Color barColor = Colors.green;

  String fontName = 'Sarabun';

  String readAllProduct           = 'http://www.somsakpharma.com/api/json_product.php?top=100';
  String readProductWhereMode     = 'http://www.somsakpharma.com/api/json_product.php?searchKey=';
  String getUserWhereUserAndPass  = 'http://www.somsakpharma.com/api/json_login.php';
  String getProductWhereId        = 'http://www.somsakpharma.com/api/json_productdetail.php?id=';

  String loadMyCart               =  'http://www.somsakpharma.com/api/json_loadmycart.php?memberId=';

  MyStyle();
}
