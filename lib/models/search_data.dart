import 'content.dart';

class SearchData extends Content {
  const SearchData({
    required super.data,
    required super.id,
    required super.level,
    required super.parent,
    required super.pos,
    required super.prefix,
    required this.path,
  });

  final String path;
}
