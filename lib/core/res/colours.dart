import 'dart:math';
import 'dart:ui';

class Colours {
  const Colours._();

  static const Color darkBackground = Color(0xFF2A2D2E);
  static const Color light = Color(0xFFFFFFFF);
  static const Color red = Color(0xFFD80000);
  static const Color lightBlue = Color(0xFF02B5EB);
  static const Color lightGrey = Color(0xFF778899);
  static const Color darkGrey = Color(0xFF777777);
  static const Color green = Color(0xFFAAE314);
  static const Color yellow = Color(0xFFFFAA00);
  static const Color lightBackground = Color(0xFF587777);
  static const Color greyBackground = Color(0xFF2C2C33);

  static List<Color> colors = const [
    red,
    lightBlue,
    Color(0xFFFF50FCF),
    Color(0xFFAC0FF5),
    green,
    yellow,
  ];

  static Color randomColour() {
    final random = Random();
    int randomIndex = random.nextInt(Colours.colors.length);
    return Colours.colors[randomIndex];
  }
}
