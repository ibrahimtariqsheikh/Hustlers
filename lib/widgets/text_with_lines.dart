import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWithLines extends StatelessWidget {
  const TextWithLines({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 2,
              color: Colors.grey[400],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Text(
              text,
              style: GoogleFonts.urbanist(
                textStyle: TextStyle(color: Colors.grey[600]),
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 2,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
