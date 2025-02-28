import 'package:flutter/cupertino.dart';
import 'package:mova/utils/search.dart';

import '../i18n/ua.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchTextFieldExampleState();
}

class _SearchTextFieldExampleState extends State<Search> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void routeToSearch(BuildContext context) {
    FocusScope.of(context).unfocus();
    textController.clear();

  }

  void searchAction(BuildContext context) {
    search(context, textController.text);
    textController.value = TextEditingValue.empty;
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();

    return CupertinoSearchTextField(
      autocorrect: false,
      autofocus: false,
      controller: textController,
      placeholder: searchHintText,
      onChanged: (value) => searchAction(context),
      onTap: () => searchAction(context),
      onSuffixTap: () => textController.clear(),
    );
  }
}