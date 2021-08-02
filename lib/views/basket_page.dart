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
              child: BasketItem(
                BasketModel().getList()[index],
                () {
                  setState(() {});
                },
              ),
            );
          },
        ));
  }
}

class BasketItem extends StatefulWidget {
  ProductModel product;
  BasketItem(this.product, this.totalCallback);
  VoidCallback totalCallback;

  @override
  createState() => BasketItemState();
}

class BasketItemState extends State<BasketItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: Text(widget.product.flower.name.toString(),
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
                    widget.product.count++;
                  });
                  widget.totalCallback();
                }),
            Container(
              child: Text(widget.product.count.toString(),
                  style: TextStyle(fontSize: 18, color: Colors.redAccent)),
            ),
            IconButton(
                icon: Icon(Icons.remove),
                color: Colors.red,
                splashRadius: 20,
                iconSize: 25,
                onPressed: () {
                  setState(() {
                    if (widget.product.count != 1) {
                      widget.product.count--;
                    }
                    widget.totalCallback();
                  });
                })
          ],
        ),
        Container(
          child: Text(
              "${widget.product.count * widget.product.flower.price}$rubles"),
        )
      ],
    );
  }
}
