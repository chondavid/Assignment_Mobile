import 'package:flutter/material.dart';
import 'package:full_stack_app_ecom/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../../constant.dart';
import '../../widgets/carousel_header.dart';
import '../../widgets/product_card_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (!controller.isLoading.value &&
            controller.products.value.categories != null) {
          return RefreshIndicator(
            onRefresh: () async {
              controller.fetchProduct();
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  backgroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Positioned(
                          left: 10,
                          bottom: 10,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundImage: NetworkImage(kProfileURL),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text('Hello', style: TextStyle(fontSize: 14, color: Colors.black)),
                                  Text(
                                    'Mr.Kosal',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          child: Image.network(
                            'https://1000logos.net/wp-content/uploads/2016/10/Apple-Logo.png',
                            height: 30,
                          ),
                        ),
                        Positioned(
                          right: 10,
                          bottom: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[200],
                            ),
                            child: IconButton(
                              onPressed: () {
                                Get.toNamed('/cart');
                              },
                              icon: Icon(
                                Icons.shopping_cart_outlined,
                                size: 30,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Banner section as a sliver
                if (controller.products.value.featuredProducts != null &&
                    controller.products.value.featuredProducts!.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      child: SizedBox(
                        height: Get.height * 0.2,
                        child: CarouselHeader(
                          controller: controller,
                        ),
                      ),
                    ),
                  ),
                // Product categories list as slivers
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: controller.products.value.categories != null
                        ? controller.products.value.categories!.length
                        : 0,
                    (context, index) {
                      final category =
                          controller.products.value.categories![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  category.name ?? "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed(
                                      Routes.VIEW_ALL_PRODUCT,
                                      arguments: category.id,
                                    );
                                  },
                                  child: const Text('View All'),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: Get.height * 0.28,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: category.products!.length,
                                itemBuilder: (context, index) {
                                  final product = category.products![index];
                                  return SizedBox(
                                    width: Get.width * 0.5,
                                    height: Get.height * 0.28,
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      child: ProductCard(
                                          addToCart: () {
                                            controller.addToCart(
                                              price: num.parse(
                                                  product.price.toString()),
                                              productId: product.id!,
                                              quantity: 1,
                                            );
                                          },
                                          product: product,
                                          controller: controller),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return Center(
            child: Column(
          children: [
            Text(
              'No products found',
            ),
          ],
        ));
      }),
    );
  }
}
