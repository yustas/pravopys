import 'package:flutter/material.dart';
import 'package:mova/i18n/ua.dart';

class Error extends StatelessWidget {
  const Error({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: Theme.of(context).splashColor,
          size: 50,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: Text(message,  textAlign: TextAlign.center,),
        )
      ],
    );
  }
}
