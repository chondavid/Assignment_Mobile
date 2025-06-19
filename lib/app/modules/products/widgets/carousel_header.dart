import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:full_stack_app_ecom/app/modules/products/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../../../data/models/product.model.dart';

class CarouselHeader extends StatelessWidget {
  const CarouselHeader({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final featured = controller.products.value.featuredProducts!;
    return CarouselSlider.builder(
      options: CarouselOptions(
        autoPlay: controller.products.value.featuredProducts!.length >
            1, // Only auto-play if there is more than one item
        reverse: true,
        padEnds: true,
        viewportFraction: 1,
      ),
      itemCount: featured.length,
      itemBuilder: (context, index, pageIndex) {
        final banner = controller.products.value.featuredProducts![index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      banner.name ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      banner.description ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          final featured = controller
                              .products.value.featuredProducts![index];
                          final product = Products(
                            id: featured.id,
                            name: featured.name,
                            description: featured.description,
                            price: featured.price,
                          );
                          Get.toNamed('/product-detail', arguments: product);
                        },
                        child: Text('Shop Now')),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Image.network(
                banner.image!,
                fit: BoxFit.cover,
                width: 200,
              ),
            ),
          ],
        );
      },
    );
  }
}
