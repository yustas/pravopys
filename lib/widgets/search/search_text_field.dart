
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../i18n/ua.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField(
      {super.key, required this.fieldValue, required this.subject});

  final ValueChanged<String> fieldValue;
  final String subject;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late TextEditingController textController;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.subject);
    textController.addListener(() {
      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 300), () {
        widget.fieldValue(textController.text);
      });
    });
  }

  @override
  void didUpdateWidget(SearchTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.subject != widget.subject) {
      textController.text = widget.subject;
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      autocorrect: false,
      autofocus: true,
      controller: textController,
      placeholder: searchHintText,
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
    );
  }
}
