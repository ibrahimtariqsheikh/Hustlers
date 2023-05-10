import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  final double verticalPadding;
  final double horizontalPadding;
  const MyDivider(
      {super.key,
      required this.horizontalPadding,
      required this.verticalPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      child: Divider(
        color: Theme.of(context).colorScheme.onTertiary,
      ),
    );
  }
}
