import 'package:buy_buy/models/models.dart';

abstract interface class ProductRepositoryInterface {
  Future<List<Product>> getProducts({String? categoryId});

  Future<Product> getProductById(String id);
}
