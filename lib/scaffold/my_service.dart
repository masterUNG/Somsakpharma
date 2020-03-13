import 'dart:convert';
import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:somsakpharma/models/product_all_model.dart';
import 'package:somsakpharma/models/user_model.dart';
import 'package:somsakpharma/scaffold/detail.dart';

import 'package:somsakpharma/utility/my_style.dart';
import 'package:somsakpharma/utility/normal_dialog.dart';
import 'package:somsakpharma/widget/contact.dart';
import 'package:somsakpharma/widget/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detail_cart.dart';

class MyService extends StatefulWidget {
  final UserModel userModel;
  MyService({Key key, this.userModel}) : super(key: key);

  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  //Explicit
  UserModel myUserModel;
  Widget currentWidget;
  String qrString;
  int amontCart = 0;

  // Method
  @override
  void initState() {
    super.initState(); // จะทำงานก่อน build
    setState(() {
      myUserModel = widget.userModel;
      currentWidget = Home(
        userModel: myUserModel,
      );
    });
    readCart();
  }

  Widget menuHome() {
    return ListTile(
      leading: Icon(
        Icons.home,
        size: 36.0,
        color: MyStyle().textColor,
      ),
      title: Text(
        'Home',
        style: TextStyle(color: MyStyle().textColor),
      ),
      subtitle: Text(
        'Description Home',
        style: TextStyle(color: MyStyle().mainColor),
      ),
      onTap: () {
        setState(() {
          readCart();
          currentWidget = Home(
            userModel: myUserModel,
          );
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget menuLogOut() {
    return ListTile(
      leading: Icon(
        Icons.exit_to_app,
        size: 36.0,
      ),
      title: Text('Logout and exit'),
      subtitle: Text('Logout and exit'),
      onTap: () {
        logOut();
      },
    );
  }

  Future<void> logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    exit(0);
  }

  Widget menuContact() {
    return ListTile(
      leading: Icon(
        Icons.home,
        size: 36.0,
      ),
      title: Text('Contact'),
      subtitle: Text('Contact pattana'),
      onTap: () {
        setState(() {
          currentWidget = Contact();
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget menuReadQRcode() {
    return ListTile(
      leading: Icon(
        Icons.photo_camera,
        size: 36.0,
      ),
      title: Text('Read QR code'),
      subtitle: Text('Read QR code or barcode'),
      onTap: () {
        readQRcode();
        Navigator.of(context).pop();
      },
    );
  }

  Future<void> readQRcode() async {
    try {
      qrString = await BarcodeScanner.scan();
      print('QR code = $qrString');
      if (qrString != null) {
        decodeQRcode(qrString);
      }
    } catch (e) {
      print('e = $e');
    }
  }

  Future<void> decodeQRcode(String code) async {
    try {
      String url = 'http://somsakpharma.com/api/json_product.php?bqcode=$code';
      Response response = await get(url);
      var result = json.decode(response.body);
      print('result ===*******>>>> $result');

      int status = result['status'];
      print('status ===>>> $status');
      if (status == 0) {
        normalDialog(context, 'No Code', 'No $code in my Database');
      } else {
        var itemProducts = result['itemsProduct'];
        for (var map in itemProducts) {
          print('map ===*******>>>> $map');

          ProductAllModel productAllModel = ProductAllModel.fromJson(map);
          MaterialPageRoute route = MaterialPageRoute(
            builder: (BuildContext context) => Detail(
              userModel: myUserModel,
              productAllModel: productAllModel,
            ),
          );
          Navigator.of(context).push(route).then((value) {
            setState(() {
              readCart();
            });
          });
        }
      }
    } catch (e) {}
  }

  Widget showAppName() {
    return Text(
      'Somsak Pharma',
      style: TextStyle(
        fontSize: 24.0,
        color: MyStyle().textColor,
      ),
    );
  }

  Widget showLogin() {
    String login = myUserModel.name;
    if (login == null) {
      login = '...';
    }
    return Text(
      'Login by $login',
      style: TextStyle(
        color: MyStyle().mainColor,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: 80.0,
      height: 80.0,
      child: Image.asset('images/logo_master.png'),
    );
  }

  Widget headDrawer() {
    return DrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/pharma.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          showLogo(),
          showAppName(),
          showLogin(),
        ],
      ),
    );
  }

  Widget showDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          headDrawer(),
          menuHome(),
          menuContact(),
          menuReadQRcode(),
          menuLogOut(),
        ],
      ),
    );
  }

  Future<void> readCart() async {
    amontCart = 0;
    String memberId = myUserModel.id.toString();
    String url =
        'http://somsakpharma.com/api/json_loadmycart.php?memberId=$memberId';

    Response response = await get(url);
    var result = json.decode(response.body);
    var cartList = result['cart'];

    for (var map in cartList) {
      setState(() {
        amontCart++;
      });
      print('amontCart ===*******>>>> $amontCart');
    }
  }

  Widget showCart() {
    return GestureDetector(
      onTap: () {
        routeToDetailCart();
      },
      child: Container(
        margin: EdgeInsets.only(top: 5.0, right: 5.0),
        width: 32.0,
        height: 32.0,
        child: Stack(
          children: <Widget>[
            Image.asset('images/shopping_cart.png'),
            Text(
              '$amontCart',
              style: TextStyle(
                backgroundColor: Colors.blue.shade600,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void routeToDetailCart() {
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext buildContext) {
      return DetailCart(
        userModel: myUserModel,
      );
    });
    Navigator.of(context).push(materialPageRoute).then((value) {
      setState(() {
        readCart();
      });
    });
  }

  BottomNavigationBarItem homeBotton() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('Home'),
    );
  }

  BottomNavigationBarItem cartBotton() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      title: Text('Cart'),
    );
  }

  BottomNavigationBarItem readQrBotton() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.menu),
      title: Text('QR code'),
    );
  }

  Widget showBottomBarNav() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        homeBotton(),
        cartBotton(),
        readQrBotton(),
      ],
      onTap: (int index) {
        print('index = $index');
        if (index == 1) {
          routeToDetailCart();
        } else if (index == 2) {
          readQRcode();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: showBottomBarNav(),
      appBar: AppBar(
        actions: <Widget>[
          showCart(),
        ],
        backgroundColor: MyStyle().textColor,
        title: Text('Home'),
      ),
      body: currentWidget,
      drawer: showDrawer(),
    );
  }
}
