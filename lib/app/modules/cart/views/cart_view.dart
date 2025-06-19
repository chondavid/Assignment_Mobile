import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../../../data/models/product.model.dart'; // Adjust this path based on your structure

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CartView'),
        centerTitle: true,
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: controller.cart.value.cart!.items!.length,
        itemBuilder: (context, index) {
          final cartItem = controller.cart.value.cart!.items![index];
          final product = cartItem.product!;

          return Card(
            child: ListTile(
              onTap: () {
                // Navigate to product detail screen with product data
                Get.toNamed('/product-detail', arguments: product);
              },
              leading: Image.network(
                "${product.image}",
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
              ),
              title: Text("${product.name}"),
              subtitle: Text("Quantity: ${cartItem.quantity}"),
              trailing: Text("\$${product.price?.toStringAsFixed(2) ?? '0.00'}"),
            ),
          );
        },
      )),
    );
  }
}
