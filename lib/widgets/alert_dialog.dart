import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAlertDialog extends StatelessWidget {
  final String text;
  final String content;
  final String buttonText;
  final VoidCallback onPressed;
  const CustomAlertDialog(
      {super.key,
      required this.text,
      required this.content,
      required this.buttonText,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        text,
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Text(
        content,
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 14,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
