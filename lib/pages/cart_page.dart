import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:synew_gym/blocs/cart/cart_cubit.dart';
import 'package:synew_gym/constants/colors.dart';
import 'package:synew_gym/models/cart_product.dart';
import 'package:synew_gym/services/stripe_api_services.dart';
import 'package:synew_gym/widgets/login_button.dart';
import 'package:synew_gym/widgets/my_divider.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? paymentIntent;
    Size size = MediaQuery.of(context).size;

    List<CartProduct> cartProducts =
        context.read<CartCubit>().state.cartProducts;

    displayPaymentSheet() async {
      try {
        await Stripe.instance.presentPaymentSheet().then((value) {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 100.0,
                        ),
                        SizedBox(height: 10.0),
                        Text("Payment Successful!"),
                      ],
                    ),
                  ));

          paymentIntent = null;
        }).onError((error, stackTrace) {
          throw Exception(error);
        });
      } on StripeException catch (e) {
        AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  Text(e.toString()),
                ],
              ),
            ],
          ),
        );
      }
    }

    Future<void> makePayment() async {
      try {
        paymentIntent = await StripeApiServices().createPaymentIntent(
            context.read<CartCubit>().state.totalPayment, 'PKR');

        await Stripe.instance
            .initPaymentSheet(
                paymentSheetParameters: SetupPaymentSheetParameters(
                    paymentIntentClientSecret: paymentIntent!['client_secret'],
                    style: ThemeMode.dark,
                    merchantDisplayName: 'Hustlers'))
            .then((value) {});

        displayPaymentSheet();
      } catch (err) {
        throw Exception(err);
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: size.width * .03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: List.generate(cartProducts.length,
                      (index) => CartItem(product: cartProducts[index])),
                ),
                const MyDivider(horizontalPadding: 0, verticalPadding: 20),
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      'Total Sum',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(
                      flex: 6,
                    ),
                    Text(
                      '${context.read<CartCubit>().state.totalPayment} PKR',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                MyButton(
                  buttonText: 'Pay Now',
                  buttonColor: primaryColor,
                  buttonWidth: size.width * .8,
                  buttonHeight: 55,
                  isSubmitting: false,
                  isOutlined: false,
                  buttonAction: () async {
                    await makePayment();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.product,
  });

  final CartProduct product;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * .13,
              width: size.width * .22,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(product.imageURL, fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              width: size.width * .03,
            ),
            SizedBox(
              width: size.width * .57,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Torrus',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Text(product.productName,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 18,
                          )),
                  SizedBox(
                    height: size.height * .005,
                  ),
                  Text('\$${product.price}'),
                  SizedBox(
                    height: size.height * .01,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 15,
                        backgroundColor:
                            Theme.of(context).colorScheme.onTertiary,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              size: 15,
                              CupertinoIcons.minus,
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            )),
                      ),
                      CircleAvatar(
                        maxRadius: 12,
                        backgroundColor: Theme.of(context).cardColor,
                        child: Text(
                          '1',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      CircleAvatar(
                        maxRadius: 15,
                        backgroundColor:
                            Theme.of(context).colorScheme.onTertiary,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              size: 15,
                              CupertinoIcons.add,
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            )),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        maxRadius: 18,
                        backgroundColor: Colors.redAccent,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              size: 21,
                              Icons.delete,
                              color: Colors.white,
                            )),
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
