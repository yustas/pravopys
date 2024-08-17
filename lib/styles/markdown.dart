import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/material.dart';

var stylesheet = MarkdownStyleSheet(
  h1: ThemeData()
      .textTheme
      .titleLarge!
      .copyWith(fontSize: 24, color: Colors.blue),
);
