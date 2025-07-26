import 'package:flutter/material.dart';

Widget searchExample(BuildContext context, text, onTap) {
  return GestureDetector(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    ),
    onTap: () => onTap(text),
  );
}