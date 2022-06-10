int cyrillicCompare(String a, String b) {
  return _removeDiacritics(a).compareTo(_removeDiacritics(b));
}

String _removeDiacritics(String text) {
  final result = <int>[];

  for (var symbol in text.codeUnits) {
    // replace `ё` with `е`
    if (symbol == 1105) {
      result.add(1077);
      continue;
    }

    // replace `Ё` with `Е`
    if (symbol == 1025) {
      result.add(1045);
      continue;
    }

    result.add(symbol);
  }

  return String.fromCharCodes(result);
}
