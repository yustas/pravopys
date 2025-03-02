import 'package:shared_preferences/shared_preferences.dart';

const key = 'search_history';
const maxHistory = 12;

Future<SharedPreferences> getPrefs() async {
  return await SharedPreferences.getInstance();
}

Future<List<String>?> getHistory([SharedPreferences? instance]) async {
  final prefs = instance ?? await getPrefs();

  return prefs.getStringList(key);
}

Future<List<String>?> setHistory(String word) async
{
  final prefs = await getPrefs();
  List<String>? history = await getHistory(prefs);

  history ??= List.empty(growable: true);
  // To test error widget uncomment and search for something
  // history = List.empty();

  if (history.isEmpty) {
    history.add(word);
    prefs.setStringList(key, history);
  } else {
    bool exists = history.last == word || history.last.contains(word);
    if (!exists) {
      if (word.contains(history.last)) {
        history.removeLast();
      }

      if (history.length >= maxHistory) {
        history.removeAt(0);
      }

      history.add(word);
      prefs.setStringList(key, history);
    }
  }

  return history.reversed.toList();
}

