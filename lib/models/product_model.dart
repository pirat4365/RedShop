import 'package:redshop/models/flower_model.dart';

class ProductModel {
  Flower flower;
  int count;
  ProductModel(this.flower, this.count);

  @override
  String toString() {
    return "name = $flower.name; count: $count";
  }
}
