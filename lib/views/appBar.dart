import 'package:flutter/material.dart';
import 'package:redshop/models/basket_model.dart';

import 'basket_page.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  bool isAction;
  bool isLeading;
  dynamic callBack;
  CustomAppBar({required this.title, isAction, callBack, isLeading, Key? key})
      : isAction = isAction,
        isLeading = isLeading,
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
        if (widget.isAction) {
          return [
            Row(
              children: [
                Text(
                  "${BasketModel().sumProduct().toString()} ₽",
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
        if (widget.isLeading) {
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
