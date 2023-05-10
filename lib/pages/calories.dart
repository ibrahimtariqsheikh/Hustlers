import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synew_gym/blocs/auth/auth_bloc.dart';
import 'package:synew_gym/blocs/nutrition/nutrition_bloc.dart';
import 'package:synew_gym/models/food.dart';
import 'package:synew_gym/widgets/my_text_field.dart';

class CaloriesPage extends StatelessWidget {
  static const String routeName = '/calories';
  final String title;
  const CaloriesPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Foods'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(context),
            _buildFoodList(context, title.toLowerCase().trim()),
          ],
        ),
      ),
    );
  }
}

Widget _buildSearchBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: MyTextField(
      prefixIcon: const Icon(Icons.search),
      onFieldSubmitted: (value) {
        context
            .read<NutritionBloc>()
            .add(FetchNutritionInfoEvent(query: value!));
      },
      hintText: 'Search for Food',
    ),
  );
}

Widget _buildFoodList(BuildContext context, String title) {
  return Expanded(
    child: BlocBuilder<NutritionBloc, NutritionState>(
      builder: (context, state) {
        if (state.nutririonStatus == NutririonStatus.loading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state.nutririonStatus == NutririonStatus.loaded) {
          return ListView.builder(
            itemCount: state.foodItems.length,
            itemBuilder: (context, index) {
              final foodItem = state.foodItems[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (index == 0) const SizedBox(height: 15),
                    if (index == 0)
                      Text(
                        'Search Results',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 17,
                            ),
                      ),
                    if (index == 0) const SizedBox(height: 15),
                    FoodItemWidget(
                      foodItem: foodItem,
                      cardType: title,
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state.nutririonStatus == NutririonStatus.error) {
          return Center(
            child: Text(
              state.error.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(child: Text('Search for food to get started'));
        }
      },
    ),
  );
}

class FoodItemWidget extends StatelessWidget {
  final Food foodItem;
  final String cardType;

  const FoodItemWidget({
    super.key,
    required this.foodItem,
    required this.cardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          foodItem.name,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14),
        ),
        subtitle: Row(
          children: [
            Text('${foodItem.calories} calories\n${foodItem.brand}'),
          ],
        ),
        trailing: SizedBox(
            height: 30,
            width: 30,
            child: GestureDetector(
              onTap: () {
                context.read<NutritionBloc>().add(FetchAndAddFoodItemEvent(
                      uid: context.read<AuthBloc>().state.user!.uid,
                      itemId: foodItem.id,
                      foodCardType: cardType,
                    ));
                Navigator.pop(context);
              },
              child: const CircleAvatar(
                child: Icon(
                  CupertinoIcons.add,
                  size: 20,
                ),
              ),
            )),
      ),
    );
  }
}
