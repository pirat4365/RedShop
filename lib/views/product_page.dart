import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redshop/models/product_model.dart';
import 'package:redshop/models/basket_model.dart';
import 'package:redshop/models/flower_model.dart';

import '../string.dart';
import 'basket_page.dart';

class ProductPage extends StatefulWidget {
  final Flower flower;
  ProductPage(this.flower, this.homeTotal);
  VoidCallback homeTotal;

  @override
  createState() => ProductPageState(flower);
}

class ProductPageState extends State<ProductPage> {
  Flower flower;
  ProductPageState(this.flower);
  int _count = 1;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          appBar: AppBar(
              title: Text(flower.name),
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
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.homeTotal();
                },
              )),
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
            Container(
              padding: EdgeInsets.only(left: 20, bottom: 30),
              child: Text(
                '$cost: ${flower.price} $rubles',
                style: TextStyle(fontSize: 25, color: Colors.redAccent),
              ),
            )
          ]),
          bottomNavigationBar: BottomAppBar(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(children: [
                  IconButton(
                      icon: Icon(Icons.remove),
                      color: Colors.red,
                      splashRadius: 20,
                      iconSize: 25,
                      onPressed: () {
                        if (_count != 1) {
                          setState(() {
                            _count--;
                          });
                        }
                      }),
                  Container(
                    child: Text(_count.toString(),
                        style:
                            TextStyle(fontSize: 25, color: Colors.redAccent)),
                  ),
                  IconButton(
                      icon: Icon(Icons.add),
                      color: Colors.red,
                      splashRadius: 20,
                      iconSize: 25,
                      onPressed: () => setState(() => _count++))
                ]),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 16))),
                    onPressed: () {
                      BasketModel().addProduct(ProductModel(flower, _count));
                      Navigator.pop(context);
                      widget.homeTotal();
                    },
                    child: Text('$addToCart  ${flower.price * _count} $rubles'))
              ],
            ),
          )),
        ));
  }
}
