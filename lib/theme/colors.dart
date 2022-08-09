import 'package:flutter/rendering.dart';

class PokeColors {
  static Map<String, Color> pokeColors = {
    'green': hexToColor('#BBD9D7'),
    'red': hexToColor('#F1D3BB'),
    'blue': hexToColor('#99B1FF'),
    'yellow': hexToColor('#d7bbb9'),
  };

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
