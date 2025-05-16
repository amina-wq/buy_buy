import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: 'documentID')
  final String id;

  final String name;
  final String description;

  final String? characteristics;
  final double price;
  final String imageUrl;

  final String categoryId;

  final String brandId;

  Product({
    required this.id,
    required this.name,
    required this.description,
    this.characteristics,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    required this.brandId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
