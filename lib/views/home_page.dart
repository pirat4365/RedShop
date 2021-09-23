import 'package:flutter/material.dart';
import 'package:redshop/models/flower_model.dart';
import 'package:redshop/services/database_manager.dart';
import 'package:redshop/views/appBar.dart';
import 'package:redshop/views/product_container.dart';

import '../string.dart';

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
        appBar: CustomAppBar(
          title: storeName,
          isShowBasket: true,
          isShowBackArrow: false,
          callBack: false,
        ),
        body: ListView(
            children: flowerList.map((flower) {
          return ProductContainer(flower, () {
            setState(() {});
          });
        }).toList()));
  }
}
