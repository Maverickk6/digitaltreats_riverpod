import 'package:ecommerce/models/products_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<ProductModel> itemCart = [
  ProductModel(
    pid: 1,
    imgUrl: 'assets/products/airpods.jpg',
    title: 'AirPods Max',
    price: 599,
    rating: 1,
    review: 11277,
    shortDescription: 'Winning beats sound',
    longDescription:
        'Apple-designed dynamic driver provides high-fidelity audio.Note : If the size of the earbud tips does not match the size of your ear canals or the headset is not worn properly in your ears, you may not obtain the correct sound qualities or call performance. Change the earbud tips to ones that fit more snugly in your ear',
  ),

  // Product List 2
  ProductModel(
    pid: 2,
    imgUrl: 'assets/products/macbook.jpg',
    title: 'MacBook Pro laptop',
    price: 3415,
    rating: 5.0,
    review: 13625,
    shortDescription: 'Apple M2 Pro chip with 10‑core',
    longDescription:
        'SUPERCHARGED BY M2 PRO OR M2 MAX — Take on demanding projects with the M2 Pro or M2 Max chip. M2 Pro has up to 12 CPU cores, up to 19 GPU cores and up to 32GB unified memory. M2 Max has 12 CPU cores, up to 38 GPU cores and up to 96GB unified memory. All your pro apps run lightning-fast — including Adobe Creative Cloud, Xcode, Affinity Designer, Microsoft 365, and many of your favourite iPhone and iPad apps. The 14.2-inch Liquid Retina XDR display features Extreme Dynamic Range, over 1,000 nits of brightness for stunning HDR content and pro reference modes for doing your best work on the go.',
  ),

  // Product List 3
  ProductModel(
    pid: 3,
    imgUrl: 'assets/products/magic.jpg',
    title: 'Magic Wireless',
    price: 255,
    rating: 4.8,
    review: 13625,
    shortDescription: 'Keyboard with Numeric Keypad',
    longDescription:
        'The Magic Keyboard is the perfect companion for iPad Pro (3rd, 2nd and 1st generation) and iPad Air (5th and 4th generation). It features the best typing experience ever on iPad, a trackpad that opens up new ways to work with iPadOS, a USB-C port for charging, backlit keys, and front and back protection. With a new floating cantilever design, iPad Pro attaches magnetically and allows you to smoothly adjust to the perfect viewing angle for you. Folds into a case to provide front and back protection',
  ),
];

class ItemCartNotifier extends StateNotifier<List<ProductModel>> {
  ItemCartNotifier() : super(itemCart);

  void addNewCartItem(ProductModel productModel) {
    state = [...state, productModel];
  }

  void removeCartItem(int pid) {
    state = [
      for (final product in state)
        if (product.pid != pid) product,
    ];
  }
}

final priceCalcProvider = StateProvider<double>((ref) {
  final itemCart = ref.watch(itemCartProvider);

  double sum = 0;
  for (var element in itemCart) sum += element.price;

  return sum;
});

final itemCartProvider =
    StateNotifierProvider<ItemCartNotifier, List<ProductModel>>((ref) {
  return ItemCartNotifier();
});
