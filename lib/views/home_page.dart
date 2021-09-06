import 'package:flutter/material.dart';
import 'package:redshop/models/basket_model.dart';
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
    loadJson().then((flowers) => setState(() => flowerList = flowers));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(storeName),
          actions: [
            Row(
              children: [
                Text(
                  "${BasketModel().sumProduct().toString()} $rubles",
                  style: TextStyle(fontSize: 15),
                ),
                IconButton(
                  icon: Icon(Icons.shopping_basket),
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BasketPage(() {
                                  setState(() {});
                                })))
                  },
                ),
              ],
            )
          ],
        ),
        body: ListView(
            children: flowerList.map((flower) {
          return ProductContainer(flower, () {
            setState(() {});
          });
        }).toList()));
  }
}
