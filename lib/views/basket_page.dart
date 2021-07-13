import 'package:flutter/material.dart';
import 'package:redshop/string.dart';
import '../models/basket_model.dart';
import '../models/flower_model.dart';

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
        body: ListView.builder(
          itemCount: BasketModel().getLength(),
          itemBuilder: (context, index) {
            return BasketItem(BasketModel().getList()[index]);
          },
        ));
  }
}

class BasketItem extends StatelessWidget {
  Flower flower;
  BasketItem(this.flower);
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(flower.name),
        trailing: Text(flower.price.toString() + "₽"));
  }
}
