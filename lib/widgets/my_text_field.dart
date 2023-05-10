import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.passwordSuffix,
    this.onFieldSubmitted,
  }) : super(key: key);

  final String hintText;
  final bool obscureText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final int? maxLength;
  final bool? passwordSuffix;
  final String? Function(String?)? validator;
  final void Function(String?)? onFieldSubmitted;
  final TextEditingController? controller;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late final TextEditingController _controller;

  bool hidePassword = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    if (widget.passwordSuffix != null) {
      hidePassword = !widget.passwordSuffix!;
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

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
      child: TextFormField(
        onChanged: (text) {},
        style: Theme.of(context).textTheme.bodySmall,
        controller: _controller,
        validator: widget.validator ??
            (value) {
              return null;
            },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.w100,
          ),
          errorStyle: GoogleFonts.urbanist(
            textStyle: Theme.of(context).textTheme.headlineSmall!,
            color: Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          errorMaxLines: 3,
          contentPadding: const EdgeInsets.all(10),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: widget.prefixIcon,
          suffixIcon:
              (widget.suffixIcon == null && widget.passwordSuffix == true)
                  ? IconButton(
                      icon: (hidePassword == false)
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      color: Colors.grey,
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                    )
                  : widget.suffixIcon,
        ),
        obscureText:
            (widget.obscureText && hidePassword == false) ? true : false,
        onFieldSubmitted: widget.onFieldSubmitted,
      ),
    );
  }
}
