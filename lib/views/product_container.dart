import 'package:flutter/material.dart';
import 'package:redshop/models/flower_model.dart';
import 'package:redshop/views/product_page.dart';

class ProductContainer extends StatelessWidget {
  final Flower flower;
  VoidCallback homeTotal;
  ProductContainer(this.flower, this.homeTotal);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(backgroundImage: AssetImage(flower.imagePath)),
        title: Text(flower.name),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductPage(flower, homeTotal)));
        });
  }
}
