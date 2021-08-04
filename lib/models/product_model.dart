import 'package:redshop/models/flower_model.dart';

class ProductModel {
  Flower flower;
  int count;
  ProductModel(this.flower, this.count);

  bool isObjectEqual(ProductModel productModel) {
    return this.flower.id == productModel.flower.id;
  }
}
