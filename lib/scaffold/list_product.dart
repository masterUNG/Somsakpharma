import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:somsakpharma/models/product_all_model.dart';
import 'package:somsakpharma/models/user_model.dart';
import 'package:somsakpharma/utility/my_style.dart';

import 'detail.dart';
import 'detail_cart.dart';

class ListProduct extends StatefulWidget {
  final int index;
  final UserModel userModel;
  ListProduct({Key key, this.index, this.userModel}) : super(key: key);

  @override
  _ListProductState createState() => _ListProductState();
}

//class
class Debouncer {
  // delay เวลาให้มีการหน่วง เมื่อ key searchview

  //Explicit
  final int milliseconds;
  VoidCallback action;
  Timer timer;

  //constructor
  Debouncer({this.milliseconds});
  run(VoidCallback action) {
    if (timer != null) {
      timer.cancel();
    }
    timer = Timer(Duration(microseconds: milliseconds), action);
  }
}

class _ListProductState extends State<ListProduct> {
  // Explicit
  int myIndex;
  List<ProductAllModel> productAllModels = List(); // set array
  List<ProductAllModel> filterProductAllModels = List();
  int amontCart = 0;
  UserModel myUserModel;
  String searchString = '';

  int amountListView = 6, page = 1;
  ScrollController scrollController = ScrollController();
  final Debouncer debouncer =
      Debouncer(milliseconds: 500); // ตั้งค่า เวลาที่จะ delay
  bool statusStart = true;

  // Method
  @override
  void initState() {
    // auto load
    super.initState();
    myIndex = widget.index;
    myUserModel = widget.userModel;

    createController(); // เมื่อ scroll to bottom

    setState(() {
      readData(); // read  ข้อมูลมาแสดง
      readCart();
    });
  }

  void createController() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        page++;
        readData();

        // print('in the end');

        // setState(() {
        //   amountListView = amountListView + 2;
        //   if (amountListView > filterProductAllModels.length) {
        //     amountListView = filterProductAllModels.length;
        //   }
        // });
      }
    });
  }

  Future<void> readData() async {
    // String url = MyStyle().readAllProduct;
    String url = 'http://somsakpharma.com/api/json_product.php?searchKey=$searchString&page=$page';
    if (myIndex != 0) {
      url = '${MyStyle().readProductWhereMode}$myIndex';
    }

    Response response = await get(url);
    print('url readData ##################+++++++++++>>> $url');
    var result = json.decode(response.body);
    // print('result = $result');
    // print('url ListProduct ====>>>> $url');
    // print('result ListProduct ========>>>>> $result');

    var itemProducts = result['itemsProduct'];

    for (var map in itemProducts) {
      ProductAllModel productAllModel = ProductAllModel.fromJson(map);
      setState(() {
        productAllModels.add(productAllModel);
        filterProductAllModels = productAllModels;
      });
    }
  }

  Widget showName(int index) {
    return Text(filterProductAllModels[index].title);
  }

  Widget showStock(int index) {
    return Text(filterProductAllModels[index].stock.toString());
    // return Text('na');
  }

  Widget showText(int index) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.5,
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[showName(index), showStock(index)],
      ),
    );
  }

  Widget showImage(int index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: MediaQuery.of(context).size.width * 0.4,
      child: Image.network(filterProductAllModels[index].photo),
    );
  }

  Widget showProductItem() {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        itemCount: productAllModels.length,
        itemBuilder: (BuildContext buildContext, int index) {
          return GestureDetector(
            child: Row(
              children: <Widget>[
                showImage(index),
                showText(index),
              ],
            ),
            onTap: () {
              MaterialPageRoute materialPageRoute =
                  MaterialPageRoute(builder: (BuildContext buildContext) {
                return Detail(
                  productAllModel: filterProductAllModels[index],
                  userModel: myUserModel,
                );
              });
              Navigator.of(context).push(materialPageRoute);
            },
          );
        },
      ),
    );
  }

  Widget showProgressIndicate() {
    return Center(
      child:
          statusStart ? CircularProgressIndicator() : Text('Search not found'),
    );
  }

  /*
  Widget myLayout() {
    return Column(
      children: <Widget>[
        searchForm(),
        showProductItem(),
      ],
    );
  }
  */

  Widget searchForm() {
    return Container(
      // color: Colors.grey,
      padding:
          EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
      child: ListTile(
        trailing: IconButton(icon: Icon(Icons.search), onPressed: () {
          print('searchString ===>>> $searchString');

          setState(() {
            page = 1;
            productAllModels.clear();
            readData();
          });

        }),
        title: TextField(
          decoration: InputDecoration(hintText: 'Search'),
          onChanged: (String string) {
            searchString = string.trim();

            // statusStart = false;
            // debouncer.run(() {
            //   setState(() {
            //     filterProductAllModels =
            //         productAllModels.where((ProductAllModel productAllModel) {
            //       return (productAllModel.title
            //           .toLowerCase()
            //           .contains(string.toLowerCase()));
            //     }).toList();
            //     amountListView = filterProductAllModels.length;
            //   });
            // });
          },
        ),
      ),
    );
  }

  Widget showContent() {
    return filterProductAllModels.length == 0
        ? showProgressIndicate()
        : showProductItem();
  }

  Future<void> readCart() async {
    String memberId = myUserModel.id.toString();
    print(memberId);
    String url =
        'http://somsakpharma.com/api/json_loadmycart.php?memberId=$memberId';

    Response response = await get(url);
    var result = json.decode(response.body);
    var cartList = result['cart'];

    for (var map in cartList) {
      setState(() {
        amontCart++;
      });
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
    Navigator.of(context).push(materialPageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().textColor,
        title: Text('List product'),
        actions: <Widget>[
          showCart(),
        ],
      ),
      // body: filterProductAllModels.length == 0
      //     ? showProgressIndicate()
      //     : myLayout(),

      body: Column(
        children: <Widget>[
          searchForm(),
          showContent(),
        ],
      ),
    );
  }
}
