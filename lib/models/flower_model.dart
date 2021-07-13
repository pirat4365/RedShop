import 'dart:convert';
import 'package:flutter/services.dart';

class Flower {
  final String name;
  final int id;
  final int price;
  final String description;
  final String imagePath;

  Flower(
      {required this.name,
      required this.price,
      required this.description,
      required this.imagePath,
      required this.id});
  factory Flower.fromJson(Map<String, dynamic> json) {
    return Flower(
        id: json['id'] as int,
        name: json['name'] as String,
        price: json['price'] as int,
        description: json['description'] as String,
        imagePath: json['imagePath'] as String);
  }
}

Future<List<Flower>> loadJson() async {
  String data = await rootBundle.loadString('assets/redshop_data.json');
  final jsonsResult = jsonDecode(data) as Map<String, dynamic>;
  final flowerList = jsonsResult['flower'] as List<dynamic>;

  print(flowerList
      .map<Flower>((json) => Flower.fromJson(json as Map<String, dynamic>))
      .toList());
  return flowerList
      .map<Flower>((json) => Flower.fromJson(json as Map<String, dynamic>))
      .toList();
}
