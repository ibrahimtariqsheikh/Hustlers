import 'package:flutter/material.dart';
import 'package:synew_gym/constants/colors.dart';

class DayClipWidget extends StatelessWidget {
  final String day;
  final bool isSelected;
  final VoidCallback onTap;

  const DayClipWidget({
    super.key,
    required this.day,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        minRadius: 22,
        backgroundColor: isSelected
            ? primaryColor
            : Theme.of(context).colorScheme.onTertiary,
        child: Text(
          day,
          style: isSelected
              ? Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 15, color: Colors.white)
              : Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
        ),
      ),
    );
  }
}
