import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final double maxLines;

  const AppText(
    this.text, {
    super.key,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.color,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines.toInt(),
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: "Alan Sans",
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
      ),
    );
  }
}
