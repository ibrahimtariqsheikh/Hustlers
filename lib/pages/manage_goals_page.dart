import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synew_gym/blocs/auth/auth_bloc.dart';
import 'package:synew_gym/blocs/nutrition/nutrition_bloc.dart';
import 'package:synew_gym/constants/colors.dart';
import 'package:synew_gym/widgets/login_button.dart';
import 'package:synew_gym/widgets/workout_text_feild.dart';

class ManageGoalsPage extends StatelessWidget {
  const ManageGoalsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String uid = context.read<AuthBloc>().state.user!.uid;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Set Goals'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(children: [
                        Text(
                          'Current Goal',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 20,
                                  ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(height: 20),
                        WorkoutTextField(
                          label: 'Calories',
                          hintText: 'calories',
                          keyboardType: TextInputType.number,
                          onChanged: (goalCalories) {
                            context
                                .read<NutritionBloc>()
                                .add(UpdateGoalCaloriesEvent(
                                  uid: uid,
                                  goalCalories: int.parse(goalCalories),
                                ));
                          },
                        ),
                        const SizedBox(height: 10),
                        WorkoutTextField(
                          label: 'Carbohydrates',
                          keyboardType: TextInputType.number,
                          hintText: '%',
                          onChanged: (goalCarbs) {
                            context
                                .read<NutritionBloc>()
                                .add(UpdateGoalCarbsEvent(
                                  uid: uid,
                                  goalCarbs: int.parse(goalCarbs),
                                ));
                          },
                        ),
                        const SizedBox(height: 10),
                        WorkoutTextField(
                          label: 'Fats',
                          keyboardType: TextInputType.number,
                          hintText: '%',
                          onChanged: (goalFats) {
                            context
                                .read<NutritionBloc>()
                                .add(UpdateGoalFatsEvent(
                                  uid: uid,
                                  goalFats: int.parse(goalFats),
                                ));
                          },
                        ),
                        const SizedBox(height: 10),
                        WorkoutTextField(
                          label: 'Proteins',
                          hintText: '%',
                          keyboardType: TextInputType.number,
                          onChanged: (goalProteins) {
                            context
                                .read<NutritionBloc>()
                                .add(UpdateGoalProteinsEvent(
                                  uid: uid,
                                  goalProteins: int.parse(goalProteins),
                                ));
                          },
                        ),
                        const SizedBox(height: 20),
                        MyButton(
                          buttonText: 'Set Goals',
                          buttonColor: primaryColor,
                          buttonWidth: size.width - 20,
                          buttonHeight: 60,
                          isSubmitting: false,
                          isOutlined: false,
                          buttonAction: () {
                            Navigator.pop(context);
                          },
                        )
                      ]))
                ]),
          ),
        ));
  }
}
