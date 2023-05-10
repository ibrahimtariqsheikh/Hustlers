import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synew_gym/blocs/workout/workout_cubit.dart';
import 'package:synew_gym/models/workout.dart';
import 'package:synew_gym/widgets/todays_workout.dart';

class WorkoutPage extends StatefulWidget {
  final Workout workout;
  final int workoutIndex;

  const WorkoutPage({
    Key? key,
    required this.workout,
    required this.workoutIndex,
  }) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutCubit, WorkoutState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.workout.name,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: List.generate(widget.workout.days.length, (dayIndex) {
                if (widget.workout.days[dayIndex]) {
                  return TodaysWorkout(
                    workoutIndex: widget.workoutIndex,
                    dayIndex: dayIndex,
                    exerciseData: widget.workout.exerciseData[dayIndex],
                  );
                } else {
                  return Container();
                }
              }),
            ),
          ),
        ),
      );
    });
  }
}
