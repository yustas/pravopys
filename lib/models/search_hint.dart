import 'dart:ffi';
import 'package:flutter/material.dart';

class SearchHint {
  const SearchHint({
    required this.isHistory,
    required this.cards,
  });

  final bool isHistory;
  final List<Widget> cards;
}
