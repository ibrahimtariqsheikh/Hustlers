import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: unused_import
import 'package:synew_gym/blocs/auth/auth_bloc.dart';
import 'package:synew_gym/blocs/nutrition/nutrition_bloc.dart';
import 'package:synew_gym/constants/colors.dart';
import 'package:synew_gym/helpers.dart';
import 'package:synew_gym/models/daily_logs.dart';
import 'package:synew_gym/models/user_daily_nutrition.dart';
import 'package:synew_gym/pages/calories.dart';
import 'package:synew_gym/pages/manage_goals_page.dart';
import 'package:synew_gym/widgets/calender_day.dart';
import 'package:synew_gym/widgets/error_dialog.dart';

import 'package:synew_gym/widgets/login_button.dart';
import 'package:synew_gym/widgets/my_divider.dart';
import 'package:synew_gym/widgets/stats_view.dart';
import 'package:synew_gym/widgets/workout_text_feild.dart';

class NutritionPage extends StatefulWidget {
  static const String routeName = '/nutrition';
  const NutritionPage({super.key});

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: BlocConsumer<NutritionBloc, NutritionState>(
                listener: (context, state) {
      if (state.nutririonStatus == NutririonStatus.error) {
        errorDialog(context, state.error);
      }
    }, builder: (context, state) {
      if (state.nutririonStatus == NutririonStatus.loaded ||
          state.nutririonStatus == NutririonStatus.initial) {
        return Column(
          children: [
            _buildCalanderDayRow(context),
            _buildCalenderView(context),
            const MyDivider(horizontalPadding: 25, verticalPadding: 20),
            _buildStatsCard(context, state.userFoodNutrition),
            const SizedBox(height: 15),
            TrackCaloriesCard(
              title: 'Breakfast',
              icon: const Icon(
                Icons.wb_sunny_rounded,
                color: Colors.orangeAccent,
              ),
              dailyLog: state.userFoodNutrition.dailyLogs
                  .firstWhere((log) => log.type == 'breakfast'),
            ),
            TrackCaloriesCard(
              title: 'Lunch',
              icon: const Icon(
                Icons.food_bank_rounded,
                color: Colors.green,
              ),
              dailyLog: state.userFoodNutrition.dailyLogs
                  .firstWhere((log) => log.type == 'lunch'),
            ),
            TrackCaloriesCard(
              title: 'Dinner',
              icon: const Icon(
                Icons.nights_stay,
                color: Colors.blue,
              ),
              dailyLog: state.userFoodNutrition.dailyLogs
                  .firstWhere((log) => log.type == 'dinner'),
            ),
            TrackCaloriesCard(
              title: 'Snacks',
              icon: const Icon(
                Icons.breakfast_dining,
                color: Colors.redAccent,
              ),
              dailyLog: state.userFoodNutrition.dailyLogs
                  .firstWhere((log) => log.type == 'snacks'),
            ),
            TrackWaterIntakeCard(
              title: 'Water',
              icon: const Icon(
                Icons.water,
                color: Colors.lightBlueAccent,
              ),
              waterConsumed: state.userFoodNutrition.totalWater,
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              buttonText: 'Manage Goals',
              buttonColor: primaryColor,
              buttonWidth: MediaQuery.of(context).size.width - 100,
              buttonHeight: 55,
              buttonAction: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ManageGoalsPage(),
                    ));
              },
              isSubmitting: false,
              isOutlined: false,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      } else {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      }
    })));
  }
}

class TrackCaloriesCard extends StatelessWidget {
  final String title;
  final Icon icon;

  final DailyLogs dailyLog;
  const TrackCaloriesCard({
    super.key,
    required this.title,
    required this.icon,
    required this.dailyLog,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: size.width - 50,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  const Spacer(),
                  icon,
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 17),
                      ),
                      Text('${dailyLog.totalCalories} calories',
                          style: TextStyle(
                              color: Theme.of(context).iconTheme.color)),
                    ],
                  ),
                  const Spacer(
                    flex: 9,
                  ),
                  IconButton(
                    style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(CircleBorder()),
                    ),
                    icon: const CircleAvatar(
                        maxRadius: 16,
                        child: Icon(
                          CupertinoIcons.add,
                          size: 20,
                        )),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CaloriesPage(
                            title: title,
                          ),
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const MyDivider(horizontalPadding: 0, verticalPadding: 5),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'Carbs',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 15,
                            color: Theme.of(context).iconTheme.color),
                      ),
                      Text('${dailyLog.totalCarbs} g'),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Fats',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 15,
                            color: Theme.of(context).iconTheme.color),
                      ),
                      Text('${dailyLog.totalFat} g'),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Protein',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 15,
                            color: Theme.of(context).iconTheme.color),
                      ),
                      Text('${dailyLog.totalProtein} g'),
                    ],
                  ),
                ],
              ),
            ),
            const MyDivider(horizontalPadding: 0, verticalPadding: 5),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  dailyLog.foodList.length,
                  (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Spacer(
                            flex: 2,
                          ),
                          const Icon(FontAwesomeIcons.kitchenSet),
                          const Spacer(
                            flex: 10,
                          ),
                          SizedBox(
                            width: size.width * .65,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  dailyLog.foodList[index].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 14),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '(${dailyLog.foodList[index].totalCarbs.toInt()}g Carbs, ${dailyLog.foodList[index].totalFat.toInt()}g Fats, ${dailyLog.foodList[index].protein.toInt()}g Proteins)',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color)),
                                    Text(
                                        '${dailyLog.foodList[index].calories} Kcal',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Spacer(
                            flex: 12,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class TrackWaterIntakeCard extends StatelessWidget {
  final String title;
  final Icon icon;
  final double waterConsumed;
  const TrackWaterIntakeCard({
    super.key,
    required this.title,
    required this.icon,
    required this.waterConsumed,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: size.width - 50,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  const Spacer(),
                  icon,
                  const Spacer(),
                  BlocBuilder<NutritionBloc, NutritionState>(
                      builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 17),
                        ),
                        Text('${state.userFoodNutrition.totalWater} ml',
                            style: TextStyle(
                                color: Theme.of(context).iconTheme.color)),
                      ],
                    );
                  }),
                  const Spacer(
                    flex: 9,
                  ),
                  IconButton(
                    style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(CircleBorder()),
                    ),
                    icon: const CircleAvatar(
                        maxRadius: 16,
                        child: Icon(
                          CupertinoIcons.add,
                          size: 20,
                        )),
                    onPressed: () {
                      if (Platform.isIOS) {
                        showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: const Text('Enter Water'),
                                content: WorkoutTextField(
                                  hintText: 'ml',
                                  label: 'Water',
                                  keyboardType: TextInputType.number,
                                  onChanged: (waterConsumed) {
                                    context.read<NutritionBloc>().add(
                                          UpdateWaterConsumedEvent(
                                              waterConsumed: waterConsumed),
                                        );
                                  },
                                ),
                                actions: [
                                  CupertinoDialogAction(
                                    child: const Text('OK'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                ],
                              );
                            });
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Enter Water'),
                                content: WorkoutTextField(
                                  hintText: 'ml',
                                  label: 'Water',
                                  keyboardType: TextInputType.number,
                                  onChanged: (waterConsumed) {
                                    context.read<NutritionBloc>().add(
                                          UpdateWaterConsumedEvent(
                                              waterConsumed: waterConsumed),
                                        );
                                  },
                                ),
                                actions: [
                                  CupertinoDialogAction(
                                    child: const Text('OK'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                ],
                              );
                            });
                      }
                    },
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildStatsCard(
    BuildContext context, UserFoodNutrition userFoodNutrition) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 33),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Goals',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 27,
              ),
        ),
        BlocBuilder<NutritionBloc, NutritionState>(builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StatsView(
                text: 'Calories',
                value: userFoodNutrition.totalCalories,
                color: Colors.amber,
                percentage: ((userFoodNutrition.totalCalories /
                            userFoodNutrition.goalCalories) *
                        100)
                    .toInt(),
              ),
              StatsView(
                  text: 'Protein',
                  value: state.userFoodNutrition.totalProtein,
                  color: Colors.redAccent,
                  percentage: ((userFoodNutrition.totalProtein /
                              userFoodNutrition.goalProtein) *
                          100)
                      .toInt()),
              StatsView(
                  text: 'Carbs',
                  value: state.userFoodNutrition.totalCarbs,
                  color: Colors.blueAccent,
                  percentage: ((userFoodNutrition.totalCarbs /
                              userFoodNutrition.goalCarbs) *
                          100)
                      .toInt()),
              StatsView(
                  text: 'Fats',
                  value: state.userFoodNutrition.totalFat,
                  color: Colors.greenAccent,
                  percentage: ((userFoodNutrition.totalFat /
                              userFoodNutrition.goalFat) *
                          100)
                      .toInt()),
              StatsView(
                text: 'Water',
                value: userFoodNutrition.totalWater.toDouble(),
                color: Colors.lightBlueAccent,
                percentage:
                    ((userFoodNutrition.totalWater / 2000) * 100).toInt(),
              ),
            ],
          );
        }),
      ],
    ),
  );
}

Widget _buildCalenderView(BuildContext context) {
  DateTime now = DateTime.now();
  int currentDay = now.day;
  int currentMonth = now.month;
  int currentYear = now.year;

  DateTime firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));

  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .05),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          7,
          (dayIndex) {
            DateTime currentDate = firstDayOfWeek.add(Duration(days: dayIndex));
            bool isSelected = currentDate.day == currentDay &&
                currentDate.month == currentMonth &&
                currentDate.year == currentYear;

            return CalenderView(
              dayText: Helpers.days[dayIndex],
              day: currentDate.day,
              isSelected: isSelected,
            );
          },
        ),
      ),
    ),
  );
}

Widget _buildCalanderDayRow(BuildContext context) {
  return Row(
    children: [
      const Spacer(),
      Text(
        'Today',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 27,
            ),
      ),
      const Spacer(
        flex: 9,
      ),
      Icon(
        CupertinoIcons.calendar_today,
        color: Theme.of(context).textTheme.bodyLarge!.color,
      ),
      const Spacer(),
    ],
  );
}
