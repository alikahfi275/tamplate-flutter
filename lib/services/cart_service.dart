import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tamplate_getx/data/models/product_model.dart';

class CartService extends GetxService {
  final storage = GetStorage();

  final RxList<ProductModel> cartItems = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    final List? cart = storage.read<List>('cart');

    if (cart != null) {
      cartItems.assignAll(cart.map((e) => ProductModel.fromJson(e)).toList());
    }

    /// auto save setiap cart berubah
    ever(cartItems, (_) {
      storage.write('cart', cartItems.map((e) => e.toJson()).toList());
    });
  }

  void addToCart(ProductModel item) {
    cartItems.add(item);
  }

  void removeFromCart(ProductModel item) {
    cartItems.remove(item);
  }

  void clearCart() {
    cartItems.clear();
  }
}
