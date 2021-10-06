import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redshop/models/product_model.dart';
import 'package:redshop/services/database_manager.dart';
import 'package:redshop/services/flower_db.dart';
import 'package:redshop/string.dart';
import 'package:redshop/views/appBar.dart';
import 'package:redshop/views/home_page.dart';
import '../models/basket_model.dart';

class BasketPage extends StatefulWidget {
  VoidCallback homeTotal;
  BasketPage(this.homeTotal);

  Future alertWindow(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(buyOk),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                  textStyle:
                      MaterialStateProperty.all(TextStyle(fontSize: 17))),
              child: Text(ok),
              onPressed: () {
                BasketModel.instance.getList().clear();
                DatabaseManager.instance.deleteAllFlowers();
                homeTotal();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                    (route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            bottomNavigationBar: BottomAppBar(
              child: Container(
                height: 50,
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '$total:  ${BasketModel.instance.sumProduct().toString()} ₽',
                        style: TextStyle(fontSize: 25),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(10)),
                              textStyle: MaterialStateProperty.all(
                                  TextStyle(fontSize: 17))),
                          onPressed: () {
                            if (BasketModel.instance.getList().isNotEmpty) {
                              widget.alertWindow(context);
                            }
                          },
                          child: Row(
                            children: [Text(buy), Icon(Icons.attach_money)],
                          ))
                    ]),
              ),
            ),
            appBar: CustomAppBar(
              title: cart,
              isShowBasket: false,
              isShowBackArrow: true,
              callBack: widget.homeTotal,
            ),
            body: (() {
              if (BasketModel.instance.getList().isEmpty) {
                return Padding(
                  padding: EdgeInsets.only(top: 100, left: 30),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/basket_empty.png",
                        width: 320,
                        height: 240,
                      ),
                      Text(basketEmpty, style: TextStyle(fontSize: 20))
                    ],
                  ),
                );
              } else {
                return ListView.separated(
                  padding: EdgeInsets.all(10),
                  itemCount: BasketModel.instance.getLength(),
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        setState(() {
                          DatabaseManager.instance.deleteFlowers(
                              BasketModel.instance.getList()[index].flower.id);
                          BasketModel.instance.getList().removeAt(index);
                        });
                      },
                      child: BasketItem(
                        BasketModel.instance.getList()[index],
                        () {
                          setState(() {});
                        },
                      ),
                    );
                  },
                );
              }
            }())));
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
                icon: Icon(Icons.remove),
                color: Colors.red,
                splashRadius: 20,
                iconSize: 25,
                onPressed: () {
                  setState(() {
                    if (widget.product.count != 1) {
                      widget.product.count--;
                      DatabaseManager.instance.updateFlowers(DBFlower(
                          widget.product.count, widget.product.flower.id));
                    }
                    widget.totalCallback();
                  });
                }),
            Container(
              child: Text(widget.product.count.toString(),
                  style: TextStyle(fontSize: 18, color: Colors.redAccent)),
            ),
            IconButton(
                icon: Icon(Icons.add),
                color: Colors.red,
                splashRadius: 20,
                iconSize: 25,
                onPressed: () {
                  setState(() {
                    widget.product.count++;
                    DatabaseManager.instance.updateFlowers(DBFlower(
                        widget.product.count, widget.product.flower.id));
                  });
                  widget.totalCallback();
                })
          ],
        ),
        Container(
          child: Text("${widget.product.count * widget.product.flower.price}₽"),
        )
      ],
    );
  }
}
