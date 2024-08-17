class Article {
  const Article(
      {required this.id,
      required this.data,
      required this.parentId,
      required this.pos});

  final int id;
  final int parentId;
  final int pos;
  final String data;

  /// Returns parsed article body
  get body {
    String body = data;
    RegExp exp = RegExp(r'(§( ?)+\d+)');
    Iterable<RegExpMatch> links = exp.allMatches(data);
    for (final m in links) {
      String link = m[0]!.replaceAll(' ', '');
      body = data.replaceAll(m[0] as Pattern, '[$link]($link)');
    }
    return body;
  }
}
