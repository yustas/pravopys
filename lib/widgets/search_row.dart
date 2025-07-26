import 'package:flutter/cupertino.dart';
import 'package:mova/widgets/search.dart';

import '../i18n/ua.dart';

class SearchRow extends StatefulWidget {
  const SearchRow({super.key});

  @override
  State<SearchRow> createState() => _SearchTextFieldExampleState();
}

class _SearchTextFieldExampleState extends State<SearchRow> {
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
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (ctx) =>
        const Search(),
      ),
    );

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