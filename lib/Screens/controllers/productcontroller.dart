import 'package:get/get.dart';
import '../product.dart';

class ProductController extends GetxController {
  final RxList<Product> _products = RxList<Product>();

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    update(); // This will notify all listeners that the state has changed
  }

  void editProduct(int index, Product updatedProduct) {
    if (index >= 0 && index < _products.length) {
      _products[index] = updatedProduct;
      update(); // Notify listeners
    }
  }

  void deleteProduct(int index) {
    if (index >= 0 && index < _products.length) {
      _products.removeAt(index);
      update(); // Notify listeners
    }
  }
}