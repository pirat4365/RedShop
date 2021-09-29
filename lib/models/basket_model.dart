import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:redshop/models/flower_model.dart';
import 'package:redshop/models/product_model.dart';
import 'package:redshop/services/database_manager.dart';
import 'package:redshop/services/flower_db.dart';

class BasketModel {
  static final BasketModel _instance = BasketModel._internal();
  factory BasketModel() {
    return _instance;
  }
  BasketModel._internal();
  List<ProductModel> _basketList = [];

  sumProduct() {
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
      DatabaseManager.instance.showFlowers();
    } else {
      _basketList.add(product);
      DatabaseManager.instance
          .addFlowers(DBFlower(product.count, product.flower.id));
      DatabaseManager.instance.showFlowers();
    }
  }

  getList() {
    return _basketList;
  }

  getLength() {
    return _basketList.length;
  }

  initBasket() {
    List dbFlower = [];
    print('111');
    DatabaseManager.instance.fetchAllFlowers().then((value) {
      dbFlower = value;
    });
    loadJson().then((value) => value.map((flower) {
          for (var item in dbFlower) {
            if (item.id == flower.id) {
              return BasketModel().addProduct(ProductModel(flower, item.count));
            }
          }
        }));
    print(dbFlower);
  }
}
