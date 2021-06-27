import 'package:flutter/material.dart';
import 'package:redshop/redshop_data.dart';

class BasketPage extends StatefulWidget {
  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  int? sumProduct() {
    int sum = 0;
    for (var item in basketList) {
      sum += int.parse(productData[item]![2]);
    }
    return sum;
  }

  final basketItem = Column(
    children: [],
  );
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
                    "Итого:" + sumProduct().toString() + "₽",
                    style: TextStyle(fontSize: 25),
                  )
                ]),
          ),
        ),
        appBar: AppBar(
          title: Text('Корзина'),
        ),
        body: ListView.builder(
          itemCount: basketList.length,
          itemBuilder: (context, i) {
            for (var item in basketList) {
              basketItem.children.add(BasketItem(item));
            }
            return basketItem.children[i];
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
