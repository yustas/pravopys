class Example {
  const Example(
      {required this.id,
        required this.word,
        required this.wordTranslit,
        required this.content});

  final int id;
  final String word;
  final String wordTranslit;
  final List<int> content;
}
