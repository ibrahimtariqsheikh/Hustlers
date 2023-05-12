import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:synew_gym/blocs/auth/auth_bloc.dart';
import 'package:synew_gym/blocs/nutrition/nutrition_bloc.dart';
import 'package:synew_gym/blocs/profile/profile_cubit.dart';
import 'package:synew_gym/constants/colors.dart';
import 'package:synew_gym/helpers.dart';
import 'package:synew_gym/models/exercises.dart';
import 'package:synew_gym/models/workout.dart';
import 'package:synew_gym/pages/auth_landing.dart';
import 'package:synew_gym/widgets/avatar.dart';
import 'package:synew_gym/widgets/circular_progress.dart';
import 'package:synew_gym/widgets/custom_card.dart';
import 'package:synew_gym/widgets/login_button.dart';
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

        if (state.status == ProfileStatus.loaded) {
          return Scaffold(
              body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            state.user.firstname.toUpperCase(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Avatar.small(url: Helpers.randomPictureUrl()),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const CustomCard(
                    height: 200,
                    child: NutritionCard(),
                  ),
                  const SizedBox(height: 10),
                  const CustomCard(
                    height: 200,
                    child: StepsCard(),
                  ),
                  const SizedBox(height: 10),
                  CustomCard(
                      height: 100,
                      child: HeartRateSleepCard(
                        heartRate: heartRate,
                        sleepInBed: sleepInBed,
                      )),
                  const SizedBox(height: 20),
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
                  MyButton(
                    buttonText: 'Sign Out',
                    buttonColor: Colors.green,
                    buttonWidth: 300,
                    buttonHeight: 50,
                    buttonAction: () {
                      context.read<AuthBloc>().add(SignOutRequestedEvent());
                      Navigator.pushNamedAndRemoveUntil(
                          context, AuthLanding.routeName, (route) => false);
                    },
                    isSubmitting: false,
                    isOutlined: false,
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

class NutritionCard extends StatelessWidget {
  const NutritionCard({super.key});

  @override
  Widget build(BuildContext context) {
    String remainingCalories = (context
                .read<NutritionBloc>()
                .state
                .userFoodNutrition
                .goalCalories -
            context.read<NutritionBloc>().state.userFoodNutrition.totalCalories)
        .toStringAsFixed(0);
    String remainingCarbs = (context
                .read<NutritionBloc>()
                .state
                .userFoodNutrition
                .goalCarbs -
            context.read<NutritionBloc>().state.userFoodNutrition.totalCarbs)
        .toStringAsFixed(0);
    String remainingFat =
        (context.read<NutritionBloc>().state.userFoodNutrition.goalFat -
                context.read<NutritionBloc>().state.userFoodNutrition.totalFat)
            .toStringAsFixed(0);
    String remainingProtein = (context
                .read<NutritionBloc>()
                .state
                .userFoodNutrition
                .goalProtein -
            context.read<NutritionBloc>().state.userFoodNutrition.totalProtein)
        .toStringAsFixed(0);

    double remainingCaloriesPercentage =
        (context.read<NutritionBloc>().state.userFoodNutrition.totalCalories /
            context.read<NutritionBloc>().state.userFoodNutrition.goalCalories);
    double remainingCarbsPercentage =
        (context.read<NutritionBloc>().state.userFoodNutrition.totalCarbs /
            context.read<NutritionBloc>().state.userFoodNutrition.goalCarbs);
    double remainingFatPercentage =
        (context.read<NutritionBloc>().state.userFoodNutrition.totalFat /
            context.read<NutritionBloc>().state.userFoodNutrition.goalFat);
    double remainingProteinPercentage =
        (context.read<NutritionBloc>().state.userFoodNutrition.totalProtein /
            context.read<NutritionBloc>().state.userFoodNutrition.goalProtein);

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
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15),
            ),
            Text('${remainingCarbs}g'),
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
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15),
            ),
            Text('${remainingProtein}g'),
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
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15),
            ),
            Text('${remainingFat}g'),
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
        const Spacer(
          flex: 3,
        ),
      ],
    );
  }
}

class StepsCard extends StatelessWidget {
  const StepsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
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
                centerText: state.healthData.steps.split('.').first,
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
                      '${state.healthData.distanceWalking} KM', //!!!!!!!!!!!!!!!!!!!
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Calories Burned',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 16)),
                  Text('20 Kcal',
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              )
            ],
          ),
          const Spacer(),
        ],
      );
    });
  }
}

class HeartRateSleepCard extends StatelessWidget {
  final String heartRate;
  final String sleepInBed;
  const HeartRateSleepCard(
      {super.key, required this.heartRate, required this.sleepInBed});

  @override
  Widget build(BuildContext context) {
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
              '$sleepInBed mins',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
