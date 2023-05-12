import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synew_gym/blocs/workout/workout_cubit.dart';
import 'package:synew_gym/constants/colors.dart';
import 'package:synew_gym/models/workout.dart';
import 'package:synew_gym/widgets/login_button.dart';
import 'package:synew_gym/widgets/workout_text_feild.dart';

class WorkoutDay extends StatelessWidget {
  final String dayName;
  final Workout workout;
  final int workoutIndex;

  const WorkoutDay({
    Key? key,
    required this.workout,
    required this.dayName,
    required this.workoutIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).cardColor),
          child: Column(
            children: [
              Text(dayName),
              const SizedBox(height: 20),
              WorkoutTextField(
                label: 'Workout Day Title',
                hintText: 'Title',
                onChanged: (value) {
                  String title = value;
                  context
                      .read<WorkoutCubit>()
                      .updateWorkoutDayTitle(workoutIndex, title);
                },
              ),
              const SizedBox(height: 20),
              BlocConsumer<WorkoutCubit, WorkoutState>(
                  listener: (context, state) {
                print('listening change in add excercise');
              }, builder: (context, state) {
                List<Widget> exercises = [];
                for (int i = 0;
                    i <
                        (workout.exerciseData[workoutIndex].exercises?.length ??
                            0);
                    i++) {
                  exercises.add(ExerciseWidget(
                    workoutIndex: workoutIndex,
                    exerciseIndex: i,
                  ));
                }

                return Column(
                  children: exercises,
                );
              }),
              MyButton(
                buttonText: 'Add Exercise',
                buttonColor: primaryColor,
                buttonWidth: double.infinity,
                buttonHeight: 50,
                isSubmitting: false,
                isOutlined: false,
                borderRadius: 30,
                buttonAction: () =>
                    context.read<WorkoutCubit>().addEmptyExercise(workoutIndex),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class ExerciseWidget extends StatefulWidget {
  final int exerciseIndex;
  final int workoutIndex;
  const ExerciseWidget(
      {Key? key, required this.exerciseIndex, required this.workoutIndex})
      : super(key: key);

  @override
  State<ExerciseWidget> createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  TextEditingController exerciseNameController = TextEditingController();
  TextEditingController noOfSetsController = TextEditingController();
  TextEditingController repController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: Theme.of(context).dividerColor),
        const SizedBox(height: 20),
        WorkoutTextField(
          label: 'Exercise Name',
          hintText: 'Name',
          controller: exerciseNameController,
          onChanged: (exerciseName) {
            context.read<WorkoutCubit>().updateExerciseName(
                  widget.workoutIndex,
                  widget.exerciseIndex,
                  exerciseName,
                );
          },
        ),
        const SizedBox(height: 10),
        WorkoutTextField(
          label: 'No. of Sets',
          hintText: 'Sets',
          keyboardType: TextInputType.number,
          controller: noOfSetsController,
          onChanged: (exerciseSets) {
            context.read<WorkoutCubit>().updateExerciseSets(
                  widget.workoutIndex,
                  widget.exerciseIndex,
                  exerciseSets,
                );
          },
        ),
        const SizedBox(height: 10),
        WorkoutTextField(
          label: 'No. of Reps/Set (comma seperated)',
          hintText: 'Reps/Set',
          controller: repController,
          onChanged: (value) {
            context.read<WorkoutCubit>().updateExerciseReps(
                  widget.workoutIndex,
                  widget.exerciseIndex,
                  repController.text,
                );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
