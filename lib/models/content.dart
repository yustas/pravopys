class Content {
  const Content({
    required this.id,
    required this.level,
    required this.data,
    required this.parent,
    // required this.version
  });

  final int id;
  final int level;
  final String data;
  final int parent;
  // final int version;
}
