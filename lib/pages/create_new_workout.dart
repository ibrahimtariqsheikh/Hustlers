import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synew_gym/blocs/workout/cubit/workout_cubit.dart';
import 'package:synew_gym/constants/colors.dart';
import 'package:synew_gym/constants/helpers.dart';
import 'package:synew_gym/widgets/day_clip.dart';
import 'package:synew_gym/widgets/login_button.dart';
import 'package:synew_gym/widgets/workout_day.dart';

class CreateNewWorkout extends StatefulWidget {
  static const String routeName = '/create/workout';

  const CreateNewWorkout({Key? key}) : super(key: key);

  @override
  State<CreateNewWorkout> createState() => _CreateNewWorkoutState();
}

class _CreateNewWorkoutState extends State<CreateNewWorkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Create New Workout')),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Workout Name',
                      ),
                      onChanged: (workoutName) {
                        context
                            .read<WorkoutCubit>()
                            .updateWorkoutName(workoutName);
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          Text(
                            'Days for the workout',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          BlocBuilder<WorkoutCubit, WorkoutState>(
                              builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(Helpers.days.length,
                                      (index) {
                                    return Row(
                                      children: [
                                        DayClipWidget(
                                          day: Helpers.days[index],
                                          isSelected: state.workout.days[index],
                                          onTap: () {
                                            context
                                                .read<WorkoutCubit>()
                                                .updateDay(index,
                                                    !state.workout.days[index]);
                                          },
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<WorkoutCubit, WorkoutState>(
                        builder: (context, state) {
                      List<Widget> workoutDays = [];

                      for (int i = 0; i < Helpers.days.length; i++) {
                        if (state.workout.days[i]) {
                          workoutDays.add(WorkoutDay(
                            workout: state.workout,
                            dayName: Helpers.days[i],
                            workoutIndex: i,
                          ));
                          workoutDays.add(const SizedBox(height: 20));
                        }
                      }
                      return Column(children: workoutDays);
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    MyButton(
                      buttonText: 'Add Workout',
                      buttonIcon: CupertinoIcons.add,
                      buttonColor: primaryColor,
                      buttonWidth: double.infinity,
                      buttonHeight: 60,
                      isSubmitting: false,
                      isOutlined: false,
                      borderRadius: 30,
                      buttonAction: () {
                        context.read<WorkoutCubit>().addWorkoutToFirebase();
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ))));
  }
}
