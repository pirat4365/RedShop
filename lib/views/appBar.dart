import 'package:flutter/material.dart';
import 'package:redshop/models/basket_model.dart';

import '../string.dart';
import 'basket_page.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  String name;
  bool isProductPage = false;
  bool isBasket = false;
  CustomAppBar(this.name, {Key? key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(widget.name), actions: [
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
              })
    ]);
  }
}
