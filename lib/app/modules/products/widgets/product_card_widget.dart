import 'package:flutter/material.dart';
import 'package:full_stack_app_ecom/app/modules/products/home/controllers/home_controller.dart';
import 'package:full_stack_app_ecom/app/modules/products/product-detail/views/product_detail_view.dart';
import 'package:get/get.dart';

import '../../../data/models/product.model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.controller,
    this.addToCart,
  });

  final Products product;
  final HomeController controller;
  final Function()? addToCart;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailView(product: product));
      },
      child: Hero(
        transitionOnUserGestures: true,
        tag: product.id!,
        child: Material(
          type: MaterialType.transparency, // likely needed

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  product.image!,
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
                        fontSize: 12.0,
                        // color: context.theme.secondaryHeaderColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price!.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: context.theme.primaryColor,
                          ),
                        ),
                        IconButton(
                          onPressed: addToCart,
                          icon: Container(
                            decoration: BoxDecoration(
                              color: Get.theme.primaryColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      ],
                    ),

                    // ElevatedButton(
                    //   onPressed: () => controller.addToWishlist(product),
                    //   child: Text('Add to Wishlist'),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
