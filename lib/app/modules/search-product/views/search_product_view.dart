import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_product_controller.dart';

class SearchProductView extends GetView<SearchProductController> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();

  SearchProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SearchBar(
                      controller: searchController,
                      cancelSearch: () {
                        searchController.clear();
                        controller.isSearch.value = false;
                        controller.searchProduct();
                      },
                      onChanged: (value) {
                        if (value.isEmpty) {
                          controller.isSearch.value = false;
                          controller.searchProduct();
                        }
                      },
                      submit: (value) {
                        controller.isSearch.value = true;
                        controller.searchProduct(search: value);
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.filter_list_outlined),
                  )
                ],
              ),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (controller.isSearch.value)
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  'Search results for "${searchController.text}"'),
                            ),
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                controller.isSearch.value = false;
                                controller.searchProduct();
                              },
                            ),
                          ],
                        ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.products.length,
                          itemBuilder: (context, index) {
                            final product = controller.products[index];
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          onTap: () {
                                            Get.toNamed('/product-detail',
                                                arguments: product);
                                          },
                                          leading: product.image != null
                                              ? Image.network(product.image!)
                                              : null,
                                          title: Text(product.name ?? ""),
                                          subtitle: Text(
                                              product.description ?? "",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis),
                                          trailing: Text('\$${product.price}',
                                              style: TextStyle(fontSize: 12)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final Function(String)? submit;
  final Function(String)? onChanged;
  final TextEditingController controller;
  final Function()? cancelSearch;

  SearchBar(
      {this.submit,
      this.onChanged,
      required this.controller,
      this.cancelSearch});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.grey),
          hintText: 'Search products',
          border: InputBorder.none,
          suffixIcon: widget.controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    widget.cancelSearch!();
                    setState(() {
                      widget.controller.clear();
                    });
                  },
                )
              : null,
        ),
        onFieldSubmitted: widget.submit,
        // onChanged: (value) {
        //   widget.onChanged!(value);
        //   setState(() {}); // Update state to show/hide the clear icon
        // },
      ),
    );
  }
}
