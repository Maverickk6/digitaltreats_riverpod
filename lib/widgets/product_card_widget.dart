import 'package:ecommerce/controllers/item_controller.dart';
import 'package:ecommerce/controllers/product_controller.dart';
import 'package:ecommerce/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../constants/themes.dart';

class ProductCardWidget extends ConsumerWidget {
  const ProductCardWidget({
    super.key,
    required this.productIndex,
  });

  final int productIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productNotifierProvider);

    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 6),
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          )
        ],
      ),
      width: MediaQuery.of(context).size.width * 0.5,
      margin: const EdgeInsets.all(12),
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(12),
                color: kLightBackground,
                child: Image.asset(products[productIndex].imgUrl),
              ),
            ),
            const Gap(4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    products[productIndex].title,
                    style: AppTheme.kCardTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    products[productIndex].shortDescription,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${products[productIndex].price}'),
                      IconButton(
                        onPressed: () {
                          ref
                              .read(productNotifierProvider.notifier)
                              .isSelectedItem(
                                  products[productIndex].pid, productIndex);
                          if (products[productIndex].isSelected == false) {
                            ref.read(itemCartProvider.notifier).addNewCartItem(
                                  ProductModel(
                                      pid: products[productIndex].pid,
                                      imgUrl: products[productIndex].imgUrl,
                                      title: products[productIndex].title,
                                      price: products[productIndex].price,
                                      shortDescription: products[productIndex]
                                          .shortDescription,
                                      longDescription: products[productIndex]
                                          .longDescription,
                                      review: products[productIndex].review,
                                      rating: products[productIndex].rating),
                                );
                          } else {
                            ref
                                .read(itemCartProvider.notifier)
                                .removeCartItem(products[productIndex].pid);
                          }
                        },
                        icon: Icon(
                          products[productIndex].isSelected
                              ? Icons.check_circle
                              : Icons.add_circle,
                          size: 30,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
