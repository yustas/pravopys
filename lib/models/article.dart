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
    RegExp contentLink = RegExp(r'(§( ?)+\d+)');
    Iterable<RegExpMatch> links = contentLink.allMatches(data);
    for (final m in links) {
      String link = m[0]!.replaceAll(' ', '');
      body = body.replaceAll(m[0] as Pattern, '[$link]($link)');
    }

    // // Get rid of the "Note" title
    // RegExp note = RegExp(r'(\*\*Примітка( \d)?\*\*.)');
    // Iterable<RegExpMatch> notes = note.allMatches(data);
    // for (final m in notes) {
    //   body = body.replaceAll(m[0] as Pattern, '');
    // }

    return body;
  }
}
