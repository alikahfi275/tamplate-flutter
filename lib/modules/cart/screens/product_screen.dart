import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:tamplate_getx/data/models/product_model.dart';
import 'package:tamplate_getx/modules/cart/controllers/cart_controller.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  final CartController cartController = Get.find<CartController>();

  final List<ProductModel> products = [
    ProductModel(name: "Helmet", price: 44.99),
    ProductModel(name: "Football", price: 20.50),
    ProductModel(name: "Basketball", price: 35.20),
    ProductModel(name: "Tennis Racket", price: 89.99),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Get.toNamed("/cart");
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
            child: ListTile(
              title: Text(product.name),
              subtitle: Text("\$${product.price}"),
              trailing: ElevatedButton(
                onPressed: () {
                  cartController.addToCart(product);

                  Get.snackbar(
                    "Cart",
                    "${product.name} added",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                child: const Text("Add"),
              ),
            ),
          );
        },
      ),
    );
  }
}
