import 'package:cookie/cookie.dart' as cookie;
import 'dart:html';

void main() {
  if (cookie.get('connSession').contains("valid"))
    window.location.replace('games.html');
}