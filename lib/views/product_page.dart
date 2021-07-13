import 'package:flutter/material.dart';
import 'package:redshop/models/basket_model.dart';
import 'package:redshop/models/flower_model.dart';

import '../string.dart';
import 'basket_page.dart';

class ProductPage extends StatelessWidget {
  final Flower flower;
  ProductPage(this.flower);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(flower.name), actions: [
          IconButton(
            icon: Icon(Icons.shopping_basket),
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BasketPage()))
            },
          ),
        ]),
        body: ListView(children: [
          Container(
              padding:
                  EdgeInsets.only(bottom: 20, top: 20, left: 20, right: 20),
              child: Image.asset(flower.imagePath)),
          Container(
            padding: EdgeInsets.only(left: 20, bottom: 30),
            child: Text(
              flower.description,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Row(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Text(
                  '$cost: ${flower.price} $rubles',
                  style: TextStyle(fontSize: 25, color: Colors.redAccent),
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      textStyle:
                          MaterialStateProperty.all(TextStyle(fontSize: 16))),
                  onPressed: () {
                    BasketModel().addProduct(flower);
                  },
                  child: Text(addToCart))
            ],
          )
        ]));
  }
}
