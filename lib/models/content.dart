class Content {
  const Content(
      {required this.id,
      required this.level,
      required this.data,
      required this.prefix,
      required this.parent,
      required this.pos});

  final int id;
  final int level;
  final String data;
  final String prefix;
  final int parent;
  final int pos;

  get numeration => prefix.isEmpty ? '' : '$prefix ';
  get name => numeration + data;
}
