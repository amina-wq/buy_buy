// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['documentID'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  characteristics: json['characteristics'] as String?,
  price: (json['price'] as num).toDouble(),
  imageUrl: json['imageUrl'] as String,
  categoryId: json['categoryId'] as String,
  brandId: json['brandId'] as String,
  isBrandNew: json['isBrandNew'] as bool,
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'documentID': instance.id,
  'name': instance.name,
  'description': instance.description,
  'characteristics': instance.characteristics,
  'price': instance.price,
  'imageUrl': instance.imageUrl,
  'categoryId': instance.categoryId,
  'brandId': instance.brandId,
  'isBrandNew': instance.isBrandNew,
};
