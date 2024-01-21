import 'dart:math';

import 'log.dart';

///Random generator
///
/// Generate random values
class Generator {
  static String getRandomString(int length) {
    try {
      const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      // final Random rnd = Random();
      return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(Random().nextInt(chars.length))));
    } catch (e) {
      Log.e(e);
      return '';
    }
  }
}
