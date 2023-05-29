import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:synew_gym/blocs/nutrition/bloc/nutrition_bloc.dart';
import 'package:synew_gym/blocs/profile/cubit/profile_cubit.dart';
import 'package:synew_gym/constants/colors.dart';
import 'package:synew_gym/constants/helpers.dart';
import 'package:synew_gym/models/exercises.dart';
import 'package:synew_gym/models/workout.dart';
import 'package:synew_gym/widgets/circular_progress.dart';
import 'package:synew_gym/widgets/custom_card.dart';
import 'package:synew_gym/widgets/todays_workout.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    int day = DateTime.now().weekday - 1;

    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      {
        Workout? workout = Helpers.findSelectedWorkout(state.user.workouts!);
        int index = Helpers.findSelectedWorkoutIndex(state.user.workouts!);
        ExerciseData? currentDayExercises = workout?.exerciseData[day];

        String heartRate = state.healthData.heartRate;
        String sleepInBed = state.healthData.sleepInBed;
        String steps = state.healthData.steps;
        String distanceWalking = state.healthData.distanceWalking;

        if (state.status == ProfileStatus.loaded) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Today'),
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const CustomCard(
                        height: 200,
                        child: NutritionCard(),
                      ),
                      const SizedBox(height: 10),
                      CustomCard(
                        height: 200,
                        child: StepsCard(
                            steps: steps, distanceWalking: distanceWalking),
                      ),
                      const SizedBox(height: 10),
                      CustomCard(
                          height: 100,
                          child: HeartRateSleepCard(
                            heartRate: heartRate,
                            sleepInBed: sleepInBed,
                          )),
                      const SizedBox(height: 15),
                      currentDayExercises == null
                          ? Container()
                          : TodaysWorkout(
                              workoutIndex: index,
                              dayIndex: day,
                              exerciseData: currentDayExercises,
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ));
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      }
    });
  }
}

class DrawerTile extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function()? onTap;

  const DrawerTile({
    required this.label,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: .2,
            color: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
        ),
      ),
      child: ListTile(
        leading: icon,
        title: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        onTap: onTap,
      ),
    );
  }
}

class NutritionCard extends StatelessWidget {
  const NutritionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NutritionBloc, NutritionState>(
      builder: (context, state) {
        String remainingCalories = (state.userFoodNutrition.goalCalories -
                    state.userFoodNutrition.totalCalories) >
                0
            ? (state.userFoodNutrition.goalCalories -
                    state.userFoodNutrition.totalCalories)
                .toStringAsFixed(0)
            : '0';
        String remainingCarbs = (state.userFoodNutrition.goalCarbs -
                    state.userFoodNutrition.totalCarbs) >
                0
            ? (state.userFoodNutrition.goalCarbs -
                    state.userFoodNutrition.totalCarbs)
                .toStringAsFixed(0)
            : '0';
        String remainingFat = (state.userFoodNutrition.goalFat -
                    state.userFoodNutrition.totalFat) >
                0
            ? (state.userFoodNutrition.goalFat -
                    state.userFoodNutrition.totalFat)
                .toStringAsFixed(0)
            : '0';
        String remainingProtein = (state.userFoodNutrition.goalProtein -
                    state.userFoodNutrition.totalProtein) >
                0
            ? (state.userFoodNutrition.goalProtein -
                    state.userFoodNutrition.totalProtein)
                .toStringAsFixed(0)
            : '0';

        String remainingWater = (state.userFoodNutrition.goalWater -
                    state.userFoodNutrition.totalWater) >
                0
            ? ((state.userFoodNutrition.goalWater -
                    state.userFoodNutrition.totalWater)
                .toStringAsFixed(0))
            : '0';
        double remainingCaloriesPercentage =
            (state.userFoodNutrition.totalCalories /
                state.userFoodNutrition.goalCalories);
        double remainingCarbsPercentage = (state.userFoodNutrition.totalCarbs /
            state.userFoodNutrition.goalCarbs);
        double remainingFatPercentage = (state.userFoodNutrition.totalFat /
            state.userFoodNutrition.goalFat);
        double remainingProteinPercentage =
            (state.userFoodNutrition.totalProtein /
                state.userFoodNutrition.goalProtein);
        double remainingWaterPercentage = (state.userFoodNutrition.totalWater /
            state.userFoodNutrition.goalWater);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  FontAwesomeIcons.nutritionix,
                  color: Colors.green,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  'Todays Nutritions',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.green),
                ),
              ],
            ),
            const Spacer(flex: 3),
            Row(
              children: [
                Text(
                  'Calories Left: ',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 15,
                      ),
                ),
                Text('$remainingCalories Kcal'),
                const Spacer(),
                CircularProgress(
                  color: Colors.red,
                  width: 20,
                  height: 20,
                  percentage: remainingCaloriesPercentage,
                  paintWidth: 3,
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  'Carbs Left: ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 15),
                ),
                Text('$remainingCarbs g'),
                const SizedBox(
                  width: 10,
                ),
                const Spacer(),
                CircularProgress(
                  color: Colors.blue,
                  width: 20,
                  height: 20,
                  percentage: remainingCarbsPercentage,
                  paintWidth: 3,
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  'Protein Left: ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 15),
                ),
                Text('$remainingProtein g'),
                const SizedBox(
                  width: 10,
                ),
                const Spacer(),
                CircularProgress(
                  color: Colors.green,
                  width: 20,
                  height: 20,
                  percentage: remainingProteinPercentage,
                  paintWidth: 3,
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  'Fat Left: ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 15),
                ),
                Text('$remainingFat g'),
                const SizedBox(
                  width: 10,
                ),
                const Spacer(),
                CircularProgress(
                  color: Colors.lime,
                  width: 20,
                  height: 20,
                  percentage: remainingFatPercentage,
                  paintWidth: 3,
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  'Water Left: ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 15),
                ),
                Text('$remainingWater ml'),
                const SizedBox(
                  width: 10,
                ),
                const Spacer(),
                CircularProgress(
                  color: Colors.orange,
                  width: 20,
                  height: 20,
                  percentage: remainingWaterPercentage,
                  paintWidth: 3,
                ),
              ],
            ),
            const Spacer(
              flex: 3,
            ),
          ],
        );
      },
    );
  }
}

class StepsCard extends StatelessWidget {
  final String steps;
  final String distanceWalking;
  const StepsCard(
      {required this.steps, required this.distanceWalking, super.key});

  @override
  Widget build(BuildContext context) {
    String showSteps = steps;
    String showDistanceWalking = distanceWalking;
    if (steps == 'N/A') {
      showSteps = '0';
    } else {
      showSteps = steps.split('.').first;
    }
    if (distanceWalking == 'N/A') {
      showDistanceWalking = '0';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              FontAwesomeIcons.personWalking,
              color: Colors.deepOrangeAccent,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.deepOrangeAccent,
                  ),
            ),
          ],
        ),
        const Spacer(),
        // distance covered pos
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircularProgress(
              percentage: 60,
              color: Colors.deepOrangeAccent,
              width: 100,
              height: 100,
              paintWidth: 15,
              centerText: showSteps,
            ),
            const SizedBox(
              width: 15,
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Distance covered',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 16)),
                Text(
                    '${double.parse(showDistanceWalking).toStringAsFixed(2)} meters',
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(
                  height: 10,
                ),
                Text('Calories Burned',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 16)),
                Text('0 Kcal', style: Theme.of(context).textTheme.bodyMedium),
              ],
            )
          ],
        ),
        const Spacer(),
      ],
    );
  }
}

class HeartRateSleepCard extends StatelessWidget {
  final String heartRate;
  final String sleepInBed;
  const HeartRateSleepCard(
      {super.key, required this.heartRate, required this.sleepInBed});

  @override
  Widget build(BuildContext context) {
    int sleepHours;
    int sleepMins;
    if (heartRate == 'N/A' || sleepInBed == 'N/A') {
      sleepHours = 0;
      sleepMins = 0;
    } else {
      sleepHours = double.parse(sleepInBed) ~/ 60;
      sleepMins = (double.parse(sleepInBed) % 60).toInt();
    }

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  CupertinoIcons.heart_fill,
                  size: 20,
                  color: redishTextColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Heart Rate',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: redishTextColor),
                ),
              ],
            ),
            Text(
              '$heartRate BPM',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  CupertinoIcons.bed_double_fill,
                  size: 20,
                  color: blueBedTextColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Time in Bed',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: blueBedTextColor),
                ),
              ],
            ),
            Text(
              '$sleepHours hrs $sleepMins mins',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
