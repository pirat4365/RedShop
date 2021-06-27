import 'package:flutter/material.dart';
import 'package:redshop/redshop_data.dart';
import 'package:redshop/basket.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
          fontFamily: 'Georgia',
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],
          appBarTheme: AppBarTheme(
              color: Colors.red, brightness: Brightness.light, elevation: 1)),
      home: Scaffold(
        body: MainPage(),
      )));
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final productList = Column(
    children: [],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('RedShop'),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_basket),
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BasketPage()))
              },
            ),
          ],
        ),
        body: ListView.builder(
            itemCount: productData.keys.length,
            itemBuilder: (context, i) {
              for (var item in productData.entries) {
                productList.children
                    .add(ProductContainer(item.key, item.value[1]));
              }
              return productList.children[i];
            }));
  }
}

class ProductContainer extends StatelessWidget {
  final String productName;
  final String productImage;

  ProductContainer(this.productName, this.productImage);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(backgroundImage: AssetImage(productImage)),
        title: Text(productName),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductPage(productName)));
        });
  }
}

class ProductPage extends StatelessWidget {
  final String productName;
  ProductPage(this.productName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(productName),
        ),
        body: ListView(children: [
          Container(
              padding:
                  EdgeInsets.only(bottom: 20, top: 20, left: 20, right: 20),
              child: Image.asset(productData[productName]![1])),
          Container(
            padding: EdgeInsets.only(left: 20, bottom: 30),
            child: Text(
              productData[productName]![0],
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Row(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Text(
                  'Цена: ' + productData[productName]![2] + '₽',
                  style: TextStyle(fontSize: 25, color: Colors.redAccent),
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      textStyle:
                          MaterialStateProperty.all(TextStyle(fontSize: 16))),
                  onPressed: () {
                    basketList.add(productName);
                  },
                  child: Text("Добавить в корзину"))
            ],
          )
        ]));
  }
}
