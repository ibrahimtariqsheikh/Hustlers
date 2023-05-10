import 'package:flutter/material.dart';
import 'package:synew_gym/constants/colors.dart';

class CalenderView extends StatelessWidget {
  final String dayText;
  final int day;

  final bool isSelected;
  const CalenderView({
    super.key,
    required this.day,
    required this.dayText,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: isSelected
              ? primaryColor
              : Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          Text(
            dayText,
            style: isSelected
                ? const TextStyle(color: Colors.white)
                : Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 5,
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
              day.toString(),
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
