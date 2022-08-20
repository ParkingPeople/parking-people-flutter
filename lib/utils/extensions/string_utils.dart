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

  static const _fullWidthRegExp = r'([\uff01-\uff5e])';
  static const _halfWidthRegExp = r'([\u0021-\u007e])';
  static const _halfFullWidthDelta = 0xfee0;

  String _convertWidth(String regExpPattern, int delta) {
    return replaceAllMapped(RegExp(regExpPattern),
        (m) => String.fromCharCode(m[1]!.codeUnits[0] + delta));
  }

  String get toFullWidth =>
      _convertWidth(_halfWidthRegExp, _halfFullWidthDelta);
  String get toHalfWidth =>
      _convertWidth(_fullWidthRegExp, -_halfFullWidthDelta);
}
