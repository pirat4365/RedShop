import 'dart:async';

import 'package:redshop/models/flower_model.dart';
import 'package:redshop/models/product_model.dart';
import 'package:redshop/services/database_manager.dart';
import 'package:redshop/services/flower_db.dart';

class BasketModel {
  BasketModel._privateConstructor();
  static final BasketModel instance = BasketModel._privateConstructor();
  List<ProductModel> _basketList = [];

  int sumProduct() {
    int sum = 0;
    for (var item in _basketList) {
      sum += item.flower.price * item.count;
    }
    return sum;
  }

  void addProduct(ProductModel product) {
    int index = _basketList.indexWhere((item) => item.isObjectEqual(product));
    if (index != -1) {
      int res = _basketList[index].count += product.count;
      DatabaseManager.instance.updateFlowers(DBFlower(res, product.flower.id));
    } else {
      _basketList.add(product);
      DatabaseManager.instance
          .addFlowers(DBFlower(product.count, product.flower.id));
    }
  }

  getList() {
    return _basketList;
  }

  getLength() {
    return _basketList.length;
  }

  void addDBList(ProductModel product) {
    _basketList.add(product);
  }

  Future<List<Flower>> initBasket() async {
    List dbFlowers = await DatabaseManager.instance.fetchAllFlowers();
    return loadJson().then((flowers) {
      for (var flower in flowers) {
        for (var dbFlower in dbFlowers) {
          if (flower.id == dbFlower.id) {
            BasketModel.instance
                .addDBList(ProductModel(flower, dbFlower.count));
          }
        }
      }
      return flowers;
    });
  }
}
