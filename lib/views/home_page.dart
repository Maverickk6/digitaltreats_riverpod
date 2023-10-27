import 'package:ecommerce/constants/themes.dart';
import 'package:ecommerce/controllers/item_controller.dart';
import 'package:ecommerce/controllers/product_controller.dart';
import 'package:ecommerce/views/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../widgets/ads_banner_widget.dart';
import '../widgets/chip_widget.dart';
import '../widgets/product_card_widget.dart';

final currentIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final product = ref.watch(productNotifierProvider);
    final itemCart = ref.watch(itemCartProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: SvgPicture.asset(
          'assets/general/store_brand_white.svg',
          color: kWhiteColor,
          width: 180,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 7),
            child: Badge(
              label: Text(
                itemCart.length.toString(),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.local_mall, size: 22),
              ),
            ),
          ),
        ],
      ),
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              //Ads Banner Section
              const AdsBannerWidget(),

              //Chips section

              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: const [
                    ChipWidget(
                      chipLabel: 'All',
                    ),
                    ChipWidget(
                      chipLabel: 'Computers',
                    ),
                    ChipWidget(
                      chipLabel: 'Headsets',
                    ),
                    ChipWidget(
                      chipLabel: 'Accessories',
                    ),
                    ChipWidget(
                      chipLabel: 'Printing',
                    ),
                    ChipWidget(
                      chipLabel: 'Cameras',
                    ),
                  ],
                ),
              ),
              //Hot sales section
              const Gap(12),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hot Sales',
                    style: AppTheme.kHeading1,
                  ),
                  Text(
                    'See all',
                    style: AppTheme.kseeAllText,
                  )
                ],
              ),
              const Gap(12),
              Container(
                padding: const EdgeInsets.all(4),
                height: 320,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: product.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPage(
                                  getIndex: index,
                                ))),
                    child: ProductCardWidget(
                      productIndex: index,
                    ),
                  ),
                ),
              ),
              //Featured products
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Featured products', style: AppTheme.kHeading1),
                  Text('See all', style: AppTheme.kseeAllText),
                ],
              ),
              MasonryGridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: product.length,
                shrinkWrap: true,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsPage(
                                getIndex: index,
                              ))),
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: ProductCardWidget(
                        productIndex: index,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
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
