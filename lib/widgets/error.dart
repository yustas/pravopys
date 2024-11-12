import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  const Error({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(message),
          )
        ],
      ),
    );
  }
}
