import 'package:flutter/material.dart';
import 'package:redshop/redshop_data.dart';
import 'package:redshop/string.dart';

class BasketPage extends StatefulWidget {
  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  int sumProduct() {
    int sum = 0;
    for (var item in basketList) {
      sum += int.parse(productData[item]![2]);
    }
    return sum;
  }

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
                    '$total:  ${sumProduct().toString()} $rubles',
                    style: TextStyle(fontSize: 25),
                  )
                ]),
          ),
        ),
        appBar: AppBar(
          title: Text(cart),
        ),
        body: ListView.builder(
          itemCount: basketList.length,
          itemBuilder: (context, index) {
            return BasketItem(basketList[index]);
          },
        ));
  }
}

class BasketItem extends StatelessWidget {
  final String productName;
  BasketItem(this.productName);
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(productName),
        trailing: Text(productData[productName]![2] + "₽"));
  }
}
