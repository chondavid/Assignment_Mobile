import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constant.dart';
import '../../../../data/models/product.model.dart';
import '../controllers/view_all_product_controller.dart';

class ViewAllProductView extends StatelessWidget {
  final ViewAllProductController productController =
      Get.put(ViewAllProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: Obx(() {
        if (productController.isLoading.value &&
            productController.products.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.75,
          ),
          padding: EdgeInsets.all(8.0),
          itemCount: productController.products.length + 1,
          itemBuilder: (context, index) {
            if (index == productController.products.length) {
              if (productController.currentPage.value <
                  productController.lastPage) {
                productController.loadMoreProducts();
                return Center(child: CircularProgressIndicator());
              } else {
                return SizedBox.shrink();
              }
            }

            final product = productController.products[index];
            return ProductDetailCard(product: product);
          },
        );
      }),
    );
  }
}

class ProductDetailCard extends StatelessWidget {
  const ProductDetailCard({
    super.key,
    required this.product,
  });

  final Products product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.toNamed('/product-detail', arguments: product);
      },
      child: Card(
        color: kCardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                "${kURL}" + product.image!,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '\$${product.price!.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
