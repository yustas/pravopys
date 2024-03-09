class Article {
  const Article({
    required this.id,
    required this.data,
    required this.parentId,
    required this.pos
  });

  final int id;
  final String data;
  final int parentId;
  final int pos;
}
