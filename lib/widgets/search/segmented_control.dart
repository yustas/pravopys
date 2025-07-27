import 'package:flutter/cupertino.dart';

import '../../i18n/ua.dart';

enum SearchSegment { rules, examples }

class SegmentedControl extends StatelessWidget {
  const SegmentedControl(
      {super.key, required this.selectedSegment, required this.fieldValue});

  final SearchSegment selectedSegment;
  final ValueChanged<SearchSegment> fieldValue;

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<SearchSegment>(
      proportionalWidth: true,
      groupValue: selectedSegment,
      onValueChanged: (SearchSegment? value) {
        if (value != null) {
          fieldValue(value);
        }
      },
      children: const {
        SearchSegment.rules: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(rulesSwitch),
        ),
        SearchSegment.examples: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(exampleSwitch),
        ),
      },
    );
  }
}