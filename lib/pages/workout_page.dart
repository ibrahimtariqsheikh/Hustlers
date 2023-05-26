import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synew_gym/blocs/auth/bloc/auth_bloc.dart';
import 'package:synew_gym/blocs/chat/bloc/chat_bloc.dart';
import 'package:synew_gym/blocs/friends/bloc/friends_bloc.dart';
import 'package:synew_gym/blocs/workout/cubit/workout_cubit.dart';
import 'package:synew_gym/models/user_model.dart';
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
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: IconButton(
                icon: const Icon(CupertinoIcons.share),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        String currUser =
                            context.read<AuthBloc>().state.user!.uid;
                        final chatBloc = context.read<ChatBloc>();
                        return Container(
                          padding: const EdgeInsets.all(30),
                          width: MediaQuery.of(context).size.width,
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Text('Share workout',
                                style: Theme.of(context).textTheme.bodyLarge),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: StreamBuilder<List<User>>(
                                stream: chatBloc.getUsers(currUser),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final data = snapshot.data!;
                                    return ListView.builder(
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        final user = data[index];
                                        if (user.id == currUser) {
                                          return Container();
                                        } else {
                                          return ListTile(
                                              title: user.username != ''
                                                  ? Text(
                                                      user.username,
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    )
                                                  : const Text(
                                                      'No username',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                              subtitle: Text(
                                                user.firstname,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              trailing: IconButton(
                                                icon: const Icon(
                                                    CupertinoIcons.share),
                                                onPressed: () {
                                                  context
                                                      .read<FriendsBloc>()
                                                      .add(ShareWorkoutEvent(
                                                        friendId: user.id,
                                                        workout: widget.workout,
                                                      ));
                                                  Navigator.pop(context);
                                                },
                                              ));
                                        }
                                      },
                                    );
                                  } else {
                                    return const CircularProgressIndicator
                                        .adaptive();
                                  }
                                },
                              ),
                            ),
                          ]),
                        );
                      });
                },
              ),
            )
          ],
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
