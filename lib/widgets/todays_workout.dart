import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synew_gym/blocs/profile/cubit/profile_cubit.dart';
import 'package:synew_gym/constants/colors.dart';
import 'package:synew_gym/constants/helpers.dart';
import 'package:synew_gym/models/exercise.dart';
import 'package:synew_gym/models/exercises.dart';

class TodaysWorkout extends StatefulWidget {
  const TodaysWorkout({
    super.key,
    required this.workoutIndex,
    required this.dayIndex,
    required this.exerciseData,
  });

  final int workoutIndex;
  final int dayIndex;
  final ExerciseData exerciseData;

  @override
  State<TodaysWorkout> createState() => _TodaysWorkoutState();
}

class _TodaysWorkoutState extends State<TodaysWorkout> {
  List<List<FocusNode>> focusNodes = [];
  int expandedButtonIndex = -1;
  int expandedWeightIndex = -1;

  @override
  void initState() {
    super.initState();
    for (int outer = 0;
        outer < widget.exerciseData.exercises!.length;
        outer++) {
      focusNodes.add([]);
      Exercise currentExercise = widget.exerciseData.exercises![outer];
      for (int inner = 0; inner < currentExercise.weights.length; inner++) {
        focusNodes[outer].add(FocusNode());
      }
    }
  }

  @override
  void dispose() {
    for (var nodeList in focusNodes) {
      for (var node in nodeList) {
        node.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(30))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("${widget.exerciseData.name} Workout",
                          style: Theme.of(context).textTheme.bodyLarge),
                      const Spacer(),
                      InkWell(
                        splashFactory: InkRipple.splashFactory,
                        splashColor: Colors.blue,
                        onTap: () {
                          // print('Change');
                        },
                        child: Container(
                          width: 50,
                          height: 35,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(Helpers.days[widget.dayIndex]),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.edit)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      widget.exerciseData.exercises!.length,
                      (exerciseIndex) {
                        Exercise currentExercise =
                            widget.exerciseData.exercises![exerciseIndex];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${exerciseIndex + 1}) ${currentExercise.name} - ${currentExercise.sets} x ${currentExercise.reps}',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List<Widget>.generate(
                                    currentExercise.weights.length,
                                    (weightIndex) {
                                  return Row(
                                    children: [
                                      AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.bounceInOut,
                                        width: expandedButtonIndex ==
                                                    exerciseIndex &&
                                                expandedWeightIndex ==
                                                    weightIndex
                                            ? 145
                                            : null,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    primaryColor),
                                            elevation:
                                                MaterialStateProperty.all(0),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (expandedButtonIndex ==
                                                      exerciseIndex &&
                                                  expandedWeightIndex ==
                                                      weightIndex) {
                                                expandedButtonIndex = -1;
                                                expandedWeightIndex = -1;
                                                focusNodes[exerciseIndex]
                                                        [weightIndex]
                                                    .unfocus();
                                              } else {
                                                for (int i = 0;
                                                    i < focusNodes.length;
                                                    i++) {
                                                  for (int j = 0;
                                                      j < focusNodes[i].length;
                                                      j++) {
                                                    focusNodes[i][j].unfocus();
                                                  }
                                                }
                                                expandedButtonIndex =
                                                    exerciseIndex;
                                                expandedWeightIndex =
                                                    weightIndex;
                                                FocusScope.of(context)
                                                    .requestFocus(focusNodes[
                                                            exerciseIndex]
                                                        [weightIndex]);
                                              }
                                            });
                                          },
                                          child: expandedButtonIndex ==
                                                      exerciseIndex &&
                                                  expandedWeightIndex ==
                                                      weightIndex
                                              ? TextField(
                                                  focusNode:
                                                      focusNodes[exerciseIndex]
                                                          [weightIndex],
                                                  showCursor: true,
                                                  onSubmitted: (weight) {
                                                    setState(() {
                                                      expandedButtonIndex = -1;
                                                      expandedWeightIndex = -1;
                                                    });

                                                    context
                                                        .read<ProfileCubit>()
                                                        .updateExerciseWeight(
                                                            widget.workoutIndex,
                                                            exerciseIndex,
                                                            widget.dayIndex,
                                                            weightIndex,
                                                            int.parse(weight));
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: "Enter weight",
                                                    hintStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17,
                                                    ),
                                                    border: InputBorder.none,
                                                  ),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                )
                                              : Row(
                                                  children: [
                                                    Text(
                                                      '${currentExercise.weights[weightIndex]}',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
