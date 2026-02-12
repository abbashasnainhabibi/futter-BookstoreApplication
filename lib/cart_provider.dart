import 'dart:convert'; // For JSON encoding/decoding
import 'package:shared_preferences/shared_preferences.dart';
import 'product_model.dart';

class CartProvider {
  static const String _cartKey = 'cart_items';

  static Future<void> addToCart(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cartItems = prefs.getStringList(_cartKey);

    cartItems ??= [];

    // Convert product to JSON string
    final productJson = jsonEncode({
      'imagePath': product.imagePath,
      'name': product.name,
      'price': product.price,
    });

    cartItems.add(productJson);
    await prefs.setStringList(_cartKey, cartItems);
  }

  static Future<List<Product>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? cartItems = prefs.getStringList(_cartKey);
    
    if (cartItems == null) {
      return [];
    }

    return cartItems.map((item) {
      final productMap = jsonDecode(item);
      return Product(
        imagePath: productMap['imagePath'],
        name: productMap['name'],
        price: productMap['price'],
      );
    }).toList();
  }

  static Future<void> removeFromCart(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cartItems = prefs.getStringList(_cartKey);

    if (cartItems != null) {
      cartItems.removeAt(index);
      await prefs.setStringList(_cartKey, cartItems);
    }
  }
}
