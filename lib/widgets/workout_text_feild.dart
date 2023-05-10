import 'package:flutter/material.dart';

class WorkoutTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;

  const WorkoutTextField({
    Key? key,
    required this.label,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  State<WorkoutTextField> createState() => _WorkoutTextFieldState();
}

class _WorkoutTextFieldState extends State<WorkoutTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(widget.label),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            onChanged: widget.onChanged,
            onEditingComplete: widget.onEditingComplete,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
