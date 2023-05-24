import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synew_gym/blocs/nutrition/bloc/nutrition_bloc.dart';
import 'package:synew_gym/blocs/profile/cubit/profile_cubit.dart';
import 'package:synew_gym/models/food.dart';
import 'package:synew_gym/widgets/my_text_field.dart';

class SearchPage extends StatelessWidget {
  static const String routeName = '/serach';

  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Friends'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(context),
            _buildSearchList(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildSearchBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    child: MyTextField(
      prefixIcon: const Icon(Icons.search),
      onFieldSubmitted: (username) {
        print(username);
      },
      hintText: 'enter username',
    ),
  );
}

Widget _buildSearchList(BuildContext context) {
  return Expanded(
    child: BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.status == ProfileStatus.loading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state.status == ProfileStatus.loaded) {
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
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
                    const ListTile(
                      title: Text('User found'),
                    )
                  ],
                ),
              );
            },
          );
        } else if (state.status == NutririonStatus.error) {
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

  const FoodItemWidget({
    super.key,
    required this.foodItem,
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
