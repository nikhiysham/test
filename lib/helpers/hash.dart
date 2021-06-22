import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

class Hash {
  static generateMd5(String input) {
    var md5 = crypto.md5;
    return md5.convert(utf8.encode(input)).toString();
  }
}
