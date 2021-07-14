import 'package:flutter/material.dart';
import 'package:redshop/models/flower_model.dart';
import 'package:redshop/views/product_container.dart';

import '../string.dart';
import 'basket_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Flower> flowerList = [];

  @override
  void initState() {
    loadJson().then((flowers) => flowerList = flowers);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(storeName),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_basket),
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BasketPage()))
              },
            ),
          ],
        ),
        body: ListView(
            children: flowerList.map((flower) {
          return ProductContainer(flower);
        }).toList()));
  }
}
