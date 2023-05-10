import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:synew_gym/blocs/cart/cart_cubit.dart';
import 'package:synew_gym/constants/colors.dart';
import 'package:synew_gym/models/products.dart';
import 'package:synew_gym/pages/cart_page.dart';
import 'package:synew_gym/widgets/login_button.dart';
import 'package:synew_gym/widgets/my_divider.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  const ProductPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = PageController(viewportFraction: 0.65);

    return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: size.height / 2.8,
                    width: size.width / 1.1,
                    child: PageView.builder(
                      controller: controller,
                      itemCount: product.imageURL.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).colorScheme.onTertiary,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              product.imageURL[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SmoothPageIndicator(
                    controller: controller,
                    count: product.imageURL.length,
                    effect: ExpandingDotsEffect(
                      expansionFactor: 4,
                      spacing: 8,
                      radius: 16,
                      dotColor: Theme.of(context).colorScheme.onTertiary,
                      activeDotColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.productName,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 18,
                                  ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          product.productDescription,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              product.price.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 18,
                                  ),
                            ),
                            const Spacer(),
                            const Icon(
                              CupertinoIcons.star_fill,
                              color: Colors.yellow,
                            ),
                            Text(
                              ' ${product.rating} ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 18,
                                  ),
                            ),
                            Text(
                              '(- Reviews)',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Colors.grey,
                                      decoration: TextDecoration.underline,
                                      fontSize: 14),
                            ),
                          ],
                        ),
                        const MyDivider(
                            horizontalPadding: 0, verticalPadding: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select size',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 15,
                                  ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: List.generate(
                                  product.size.length,
                                  (index) => Row(
                                        children: [
                                          SizeWidget(
                                            product: product,
                                            index: index,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      )),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Colors',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 17,
                                  ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                                children: List.generate(product.color.length,
                                    (index) {
                              String hexCode = '0xFF${product.color[index]}';
                              return Row(children: [
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<CartCubit>()
                                        .selectColor(hexCode);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Color(
                                      int.parse(hexCode),
                                    ),
                                    child:
                                        (state.currentProduct.selectedColor ==
                                                hexCode)
                                            ? const Icon(
                                                Icons.check,
                                              )
                                            : null,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                              ]);
                            })),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      context
                                          .read<CartCubit>()
                                          .toggleIsWishlist();
                                    },
                                    icon: state.currentProduct.isWishlist
                                        ? const Icon(
                                            size: 35,
                                            CupertinoIcons.heart_fill,
                                            color: redishTextColor,
                                          )
                                        : const Icon(
                                            size: 35, CupertinoIcons.heart)),
                                const Spacer(),
                                MyButton(
                                  buttonText: 'Add To Cart',
                                  buttonIcon: CupertinoIcons.cart,
                                  buttonColor: primaryColor,
                                  buttonWidth: size.width / 1.4,
                                  buttonHeight: 60,
                                  isSubmitting: false,
                                  isOutlined: false,
                                  buttonAction: () {
                                    context.read<CartCubit>().addToCart();
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => const CartPage(),
                                    ));
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class SizeWidget extends StatelessWidget {
  const SizeWidget({
    Key? key,
    required this.product,
    required this.index,
  }) : super(key: key);

  final Product product;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      return GestureDetector(
        onTap: () {
          context.read<CartCubit>().selectSize(product.size[index]);
        },
        child: CircleAvatar(
          backgroundColor:
              (state.currentProduct.selectedSize == product.size[index])
                  ? primaryColor
                  : Theme.of(context).cardColor,
          child: Text(
            product.size[index],
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      );
    });
  }
}
