import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final double maxLines;

  const CustomText(
    this.text, {
    super.key,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.color,
    this.maxLines = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines.toInt(),
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: GoogleFonts.lato().fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
      ),
    );
  }
}
