import 'package:ecommerce/controllers/product_controller.dart';
import 'package:ecommerce/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../constants/themes.dart';

class DetailsPage extends ConsumerWidget {
  const DetailsPage({
    super.key,
    required this.getIndex,
  });

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final product = ref.watch(productNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text(product[getIndex].title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.local_mall_outlined),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: double.infinity,
            height: 300,
            color: kLightBackground,
            child: Image.asset(product[getIndex].imgUrl),
          ),
          Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product[getIndex].title,
                  style: AppTheme.kBigTitle.copyWith(color: kPrimaryColor),
                ),
                const Gap(6),
                Row(
                  children: [
                    RatingBar(
                      itemSize: 22,
                      initialRating: 1,
                      minRating: 1,
                      maxRating: 5,
                      allowHalfRating: true,
                      ratingWidget: RatingWidget(
                        empty: const Icon(
                          Icons.star_border,
                          color: Colors.amber,
                        ),
                        full: const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        half: const Icon(
                          Icons.star_half_sharp,
                          color: Colors.amber,
                        ),
                      ),
                      onRatingUpdate: (value) => null,
                    ),
                    const Gap(12),
                    const Text('125 reviews'),
                  ],
                ),
                const Gap(8),
                Text(product[getIndex].longDescription),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$${product[getIndex].price * product[getIndex].qty}',
                        style: AppTheme.kHeading1),
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(productNotifierProvider.notifier)
                                  .decrementQty(product[getIndex].pid);
                            },
                            icon: const Icon(
                              Icons.do_not_disturb_on_outlined,
                              size: 30,
                            ),
                          ),
                          Text(
                            product[getIndex].qty.toString(),
                            style: AppTheme.kCardTitle.copyWith(fontSize: 24),
                          ),
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(productNotifierProvider.notifier)
                                  .incrementQty(product[getIndex].pid);
                            },
                            icon:
                                const Icon(Icons.add_circle_outline, size: 30),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      minimumSize: const Size(double.infinity, 50)),
                  onPressed: () {},
                  child: const Text('Add items to bag'),
                ),
              ],
            ),
          )
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) =>
            ref.read(currentIndexProvider.notifier).update((state) => value),
        currentIndex: currentIndex,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kSecondaryColor,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              activeIcon: Icon(Icons.home_filled)),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: 'Favorites',
              activeIcon: Icon(Icons.favorite)),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              label: 'location',
              activeIcon: Icon(Icons.location_on)),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              label: 'Home',
              activeIcon: Icon(Icons.notifications)),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
              activeIcon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
