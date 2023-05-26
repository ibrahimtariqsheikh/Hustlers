import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:synew_gym/app_theme.dart';
import 'package:synew_gym/blocs/auth/bloc/auth_bloc.dart';
import 'package:synew_gym/blocs/profile/cubit/profile_cubit.dart';
import 'package:synew_gym/blocs/tab_bar/cubit/tab_bar_cubit.dart';
import 'package:synew_gym/blocs/tab_bar/cubit/tab_bar_state.dart';
import 'package:synew_gym/constants/helpers.dart';
import 'package:synew_gym/pages/auth_landing.dart';
import 'package:synew_gym/pages/messages_page.dart';
import 'package:synew_gym/pages/profile_page.dart';
import 'package:synew_gym/pages/create_page.dart';
import 'package:synew_gym/pages/nutrition_page.dart';
import 'package:synew_gym/pages/search_page.dart';
import 'package:synew_gym/pages/shop_page.dart';
import 'package:synew_gym/widgets/avatar.dart';

final children = [
  'Nutrition',
  'Messages',
  'Workouts',
  'Shop',
  'Today',
];

class TabBarPage extends StatefulWidget {
  static const String routeName = '/tabbar';
  const TabBarPage({Key? key}) : super(key: key);

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  void _getUserData() {
    final String uid = context.read<AuthBloc>().state.user!.uid;
    context.read<ProfileCubit>().getUserDetails(uid: uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBarCubit, TabBarState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<TabBarCubit>(context);
        return Scaffold(
          drawer: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
            return Drawer(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Avatar.small(url: Helpers.randomPictureUrl()),
                        title: Text(
                          state.user.firstname,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        subtitle: state.user.friends.length <= 1
                            ? Text('${state.user.friends.length} friend')
                            : Text('${state.user.friends.length} friends'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DrawerTile(
                        label: 'Add Friends',
                        icon: const Icon(Icons.people),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, SearchPage.routeName);
                        },
                      ),
                      DrawerTile(
                        label: 'Sign Out',
                        icon: const Icon(Icons.exit_to_app),
                        onTap: () {
                          context.read<AuthBloc>().add(SignOutRequestedEvent());
                          Navigator.pushNamedAndRemoveUntil(
                              context, AuthLanding.routeName, (route) => false);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          body: _createBody(context, bloc.state.index),
          bottomNavigationBar: _BottomNavigationBar(
            onItemSelected: bloc.state.index,
          ),
        );
      },
    );
  }
}

Widget _createBody(BuildContext context, int index) {
  final children = [
    const NutritionPage(),
    const MessagesPage(),
    const CreatePage(),
    const ShopPage(),
    const ProfilePage(),
  ];
  return children[index];
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  final int onItemSelected;

  @override
  __BottomNavigationBarState createState() => __BottomNavigationBarState();
}

class __BottomNavigationBarState extends State<_BottomNavigationBar> {
  void handleItemSelected(int index) {
    context.read<TabBarCubit>().tabBarPressed(index);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      elevation: 0,
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
          child:
              BlocBuilder<TabBarCubit, TabBarState>(builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _NavigationBarItem(
                  index: 0,
                  lable: children[0],
                  icon: FontAwesomeIcons.nutritionix,
                  isSelected: (state.index == 0),
                  onTap: handleItemSelected,
                ),
                _NavigationBarItem(
                  index: 1,
                  lable: children[1],
                  icon: CupertinoIcons.bubble_left_bubble_right_fill,
                  isSelected: (state.index == 1),
                  onTap: handleItemSelected,
                ),
                _NavigationBarItem(
                  index: 2,
                  lable: children[2],
                  icon: Icons.fitness_center,
                  isSelected: (state.index == 2),
                  onTap: handleItemSelected,
                ),
                _NavigationBarItem(
                  index: 3,
                  lable: children[3],
                  icon: FontAwesomeIcons.cartShopping,
                  isSelected: (state.index == 3),
                  onTap: handleItemSelected,
                ),
                _NavigationBarItem(
                  index: 4,
                  lable: children[4],
                  icon: CupertinoIcons.person_fill,
                  isSelected: (state.index == 4),
                  onTap: handleItemSelected,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    Key? key,
    required this.index,
    required this.lable,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  final int index;
  final String lable;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: isSelected ? AppColors.secondary : null,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            lable,
            style: isSelected
                ? const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  )
                : const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}
