import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLines;
  final TextStyle? textStyle;
  final TextStyle? linkStyle;

  const ExpandableText({
    super.key,
    required this.text,
    this.trimLines = 4,
    this.textStyle,
    this.linkStyle,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle =
        widget.textStyle ?? TextStyle(fontSize: 14, color: Colors.grey);

    final defaultLinkStyle =
        widget.linkStyle ??
        TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,

          maxLines: isExpanded ? null : widget.trimLines,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: defaultTextStyle,
        ),
        const Gap(4),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            isExpanded ? "Read less" : "Read more",
            style: defaultLinkStyle,
          ),
        ),
      ],
    );
  }
}
