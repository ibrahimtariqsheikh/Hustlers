import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synew_gym/blocs/date_toggle/cubit/date_toggle_cubit.dart';
import 'package:synew_gym/constants/colors.dart';

class CalenderView extends StatelessWidget {
  final String dayText;
  final DateTime date;

  const CalenderView({
    super.key,
    required this.date,
    required this.dayText,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateToggleCubit, DateState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 15),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: state.selectedDate.day == date.day
                  ? primaryColor
                  : Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              Text(
                dayText,
                style: state.selectedDate.day == date.day
                    ? const TextStyle(color: Colors.white)
                    : Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 5,
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  date.day.toString(),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
