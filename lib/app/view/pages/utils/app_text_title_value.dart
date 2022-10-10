import 'package:flutter/material.dart';

class AppTextTitleValue extends StatelessWidget {
  final String title;
  final String value;
  const AppTextTitleValue({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: const TextStyle(color: Colors.blueGrey),
        children: <InlineSpan>[
          TextSpan(text: value, style: const TextStyle(color: Colors.white))
        ],
      ),
    );
  }
}
