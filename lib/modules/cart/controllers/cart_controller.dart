import 'package:get/get.dart';
import 'package:tamplate_getx/data/models/product_model.dart';
import 'package:tamplate_getx/services/cart_service.dart';

class CartController extends GetxController {
  final CartService cartService = Get.find<CartService>();

  List<ProductModel> get cartItems => cartService.cartItems;

  double get total => cartItems.fold(
    0,
    (previousValue, element) => previousValue + element.price,
  );

  void addToCart(ProductModel item) {
    cartService.addToCart(item);
  }

  void removeFromCart(ProductModel item) {
    cartService.removeFromCart(item);
  }

  void clearCart() {
    cartService.clearCart();
  }
}
