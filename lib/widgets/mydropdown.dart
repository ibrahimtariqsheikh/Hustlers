import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  const MyDropdown({
    Key? key,
    required this.hintText,
    required this.items,
    this.prefixIcon,
    this.onChanged,
    this.value,
    this.validator,
  }) : super(key: key);

  final String hintText;
  final List<String> items;
  final IconData? prefixIcon;
  final void Function(String?)? onChanged;
  final String? value;
  final String? Function(String?)? validator;

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Theme.of(context).colorScheme.secondary,
        border: Border.all(
          color: Theme.of(context).colorScheme.secondaryContainer,
          width: 2,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          value: widget.value,
          onChanged: widget.onChanged,
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          decoration: InputDecoration(
            labelText: widget.hintText,
            labelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.w100,
            ),
            contentPadding: const EdgeInsets.all(10),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            prefixIconColor: Theme.of(context).iconTheme.color,
            prefixIcon:
                widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
          ),
          validator: widget.validator ??
              (value) {
                return null;
              },
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
    );
  }
}
