import 'package:flutter/material.dart';
import 'package:mova/i18n/ua.dart';

class Error extends StatelessWidget {
  const Error({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: Theme.of(context).splashColor,
            size: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
            child: Text(message,  textAlign: TextAlign.center,),
          )
        ],
      ),
    );
  }
}
