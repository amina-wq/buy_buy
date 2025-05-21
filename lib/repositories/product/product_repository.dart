import 'package:buy_buy/models/models.dart';
import 'package:buy_buy/repositories/product/product_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepository implements ProductRepositoryInterface {
  final CollectionReference _products = FirebaseFirestore.instance.collection('products');

  @override
  Future<List<Product>> getProducts(String? categoryId) async {
    try {
      if (categoryId != allCategory.id) {
        final snapshot = await _products.where('categoryId', isEqualTo: categoryId).get();
        return snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Product.fromJson({...data, 'documentID': doc.id});
        }).toList();
      } else {
        final snapshot = await _products.get();
        return snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Product.fromJson({...data, 'documentID': doc.id});
        }).toList();
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Product> getProductById(String productId) async {
    try {
      final doc = await _products.doc(productId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return Product.fromJson(data..['documentID'] = doc.id);
      } else {
        throw Exception('Product not found');
      }
    } catch (e) {
      rethrow;
    }
  }
}
