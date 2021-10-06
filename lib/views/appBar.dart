import 'package:flutter/material.dart';
import 'package:redshop/models/basket_model.dart';

import 'basket_page.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  bool isShowBasket;
  bool isShowBackArrow;
  dynamic callBack;
  CustomAppBar(
      {required this.title, isShowBasket, callBack, isShowBackArrow, Key? key})
      : isShowBasket = isShowBasket,
        isShowBackArrow = isShowBackArrow,
        callBack = callBack,
        preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  _CustomAppBarState();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      actions: (() {
        if (widget.isShowBasket) {
          return [
            Row(
              children: [
                Text(
                  "${BasketModel.instance.sumProduct().toString()} ₽",
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
          ];
        }
      }()),
      leading: () {
        if (widget.isShowBackArrow) {
          return IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
              widget.callBack();
            },
          );
        }
      }(),
    );
  }
}
