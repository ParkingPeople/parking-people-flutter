class Holder<T> {
  const Holder(this.value);

  final T value;
}

class WordBreakStrategy extends Holder<String> {
  const WordBreakStrategy(super.value);

  static const ZWNBSP = '\uFEFF';
  static const ZWSP = '\u200B';

  String get never => value.graphs.join(ZWNBSP);

  String get onSpace => never.replaceAll('$ZWNBSP $ZWNBSP', ' ');

  String get anywhere => value.graphs.join(ZWSP);
}

extension StringUtils on String {
  Iterable<String> get graphs => runes.map(String.fromCharCode);

  WordBreakStrategy get lineBreak => WordBreakStrategy(this);
}
