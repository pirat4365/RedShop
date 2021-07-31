import 'package:flutter/material.dart';
import 'package:redshop/models/product_model.dart';
import 'package:redshop/string.dart';
import '../models/basket_model.dart';

class BasketPage extends StatefulWidget {
  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 40,
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '$total:  ${BasketModel().sumProduct().toString()} $rubles',
                    style: TextStyle(fontSize: 25),
                  )
                ]),
          ),
        ),
        appBar: AppBar(
          title: Text(cart),
        ),
        body: ListView.separated(
          padding: EdgeInsets.all(10),
          itemCount: BasketModel().getLength(),
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (context, index) {
            return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  setState(() {
                    BasketModel().getList().removeAt(index);
                  });
                },
                child: BasketItem(BasketModel().getList()[index]));
          },
        ));
  }
}

class BasketItem extends StatefulWidget {
  ProductModel product;
  BasketItem(this.product);
  @override
  createState() => BasketItemState(product);
}

class BasketItemState extends State<BasketItem> {
  ProductModel product;
  BasketItemState(this.product);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: Text(product.flower.name.toString(),
              style: TextStyle(fontSize: 20, color: Colors.white)),
        ),
        Row(
          children: [
            IconButton(
                icon: Icon(Icons.add),
                color: Colors.red,
                splashRadius: 20,
                iconSize: 25,
                onPressed: () {
                  setState(() {
                    product.count++;
                  });
                }),
            Container(
              child: Text(product.count.toString(),
                  style: TextStyle(fontSize: 18, color: Colors.redAccent)),
            ),
            IconButton(
                icon: Icon(Icons.remove),
                color: Colors.red,
                splashRadius: 20,
                iconSize: 25,
                onPressed: () {
                  setState(() {
                    product.count--;
                  });
                })
          ],
        ),
        Container(
          child: Text("${product.count * product.flower.price}$rubles"),
        )
      ],
    );
  }
}
