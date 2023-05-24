import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synew_gym/blocs/auth/bloc/auth_bloc.dart';
import 'package:synew_gym/blocs/friends/bloc/friends_bloc.dart';
import 'package:synew_gym/constants/helpers.dart';
import 'package:synew_gym/widgets/avatar.dart';
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
  return BlocBuilder<FriendsBloc, FriendsState>(builder: (context, state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: MyTextField(
        prefixIcon: const Icon(Icons.search),
        onFieldSubmitted: (value) {
          final String name = value ?? '';
          context.read<FriendsBloc>().add(SearchUsersByNameEvent(name: name));
        },
        hintText: 'Enter Username',
      ),
    );
  });
}

Widget _buildSearchList(BuildContext context) {
  return Expanded(
    child: BlocBuilder<FriendsBloc, FriendsState>(
      builder: (context, state) {
        if (state.friendsStatus == FriendsStatus.loading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state.friendsStatus == FriendsStatus.loaded) {
          return ListView.builder(
            itemCount: state.fetchedUsers.length,
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
                    ListTile(
                      leading: Avatar.small(url: Helpers.randomPictureUrl()),
                      title: Text(
                        state.fetchedUsers[index].username,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 15),
                      ),
                      subtitle: Text(
                        state.fetchedUsers[index].firstname,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 12),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          String uid = context.read<AuthBloc>().state.user!.uid;
                          context.read<FriendsBloc>().add(AddFriendEvent(
                                loggedInUserId: uid,
                                friendId: state.fetchedUsers[index].id,
                              ));
                          Navigator.pop(context);
                        },
                        child: const Text('Add'),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        } else if (state.friendsStatus == FriendsStatus.error) {
          return const Center(
            child: Text(
              'Users not found',
              style: TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(
              child: Text('Search for people to add as your friends'));
        }
      },
    ),
  );
}
