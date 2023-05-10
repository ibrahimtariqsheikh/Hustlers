// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synew_gym/blocs/cart/cart_cubit.dart';
import 'package:synew_gym/blocs/category_toggle/category_cubit.dart';
import 'package:synew_gym/blocs/category_toggle/category_state.dart';
import 'package:synew_gym/blocs/product/product_bloc.dart';
import 'package:synew_gym/constants/colors.dart';
import 'package:synew_gym/models/products.dart';
import 'package:synew_gym/pages/product_page.dart';
import 'package:synew_gym/widgets/error_dialog.dart';
import 'package:synew_gym/widgets/my_text_field.dart';

class ShopPage extends StatefulWidget {
  static const String routeName = '/shop';
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state.productStatus == ProductStatus.error) {
            errorDialog(context, state.error);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                children: const [
                  ExploreSearchBar(),
                  CategoriesOptions(),
                  ShoppingOptions(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ExploreSearchBar extends StatelessWidget {
  const ExploreSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Explore',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 20,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        MyTextField(
          prefixIcon: const Icon(CupertinoIcons.search),
          hintText: 'Search for a product',
          onFieldSubmitted: (value) {
            context
                .read<ProductBloc>()
                .add(FetchProductsBySearchEvent(query: value!));
          },
        ),
      ],
    );
  }
}

class CategoriesOptions extends StatelessWidget {
  const CategoriesOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: CategoryButton(
                    label: context.read<CategoryCubit>().state.labels[index],
                    index: index,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatefulWidget {
  final String label;
  final int index;

  const CategoryButton({
    Key? key,
    required this.label,
    required this.index,
  }) : super(key: key);

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context
                .read<CategoryCubit>()
                .categoryButtonPressed(widget.index, widget.label);
          },
          child: Container(
            decoration: BoxDecoration(
              color: context.read<CategoryCubit>().state.index == widget.index
                  ? primaryColor
                  : Theme.of(context).colorScheme.onTertiary,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Center(child: Text(widget.label)),
            ),
          ),
        );
      },
    );
  }
}

class ShoppingOptions extends StatelessWidget {
  const ShoppingOptions({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> products = context.read<ProductBloc>().state.selectedProducts;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 12,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(
            product: products[index],
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        context.read<CartCubit>().updateSelectedProduct(product);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(product: product),
            ));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height / 4.2,
            width: size.width / 2.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).colorScheme.onTertiary,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                product.imageURL[0],
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            product.productName,
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 12),
          ),
          Text(product.price.toString()),
        ],
      ),
    );
  }
}
