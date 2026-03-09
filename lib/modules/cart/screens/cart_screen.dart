import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamplate_getx/modules/cart/controllers/cart_controller.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const Center(child: Text("Cart is empty"));
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  final item = controller.cartItems[index];

                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text("\$${item.price}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        controller.removeFromCart(item);
                      },
                    ),
                  );
                },
              ),
            ),

            /// TOTAL
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total", style: TextStyle(fontSize: 18)),
                  Text(
                    "\$${controller.total.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),

            ElevatedButton(
              onPressed: () {
                controller.clearCart();

                Get.snackbar("Success", "Checkout success");
              },
              child: const Text("Checkout"),
            ),

            const SizedBox(height: 20),
          ],
        );
      }),
    );
  }
}
