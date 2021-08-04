import 'package:redshop/models/product_model.dart';

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
    bool isContain = false;
    for (var item in _basketList) {
      if (item.isObjectEqual(product)) {
        item.count += product.count;
        isContain = true;
        break;
      }
    }
    if (!isContain) {
      _basketList.add(product);
    }
  }

  getList() {
    return _basketList;
  }

  getLength() {
    return _basketList.length;
  }
}
