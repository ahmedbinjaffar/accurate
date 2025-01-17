import 'dart:ui';

class AssetsImages {
  static AssetsImages instance = AssetsImages();

  static const String imagePath = "assets/images";

  final String logoimage = "$imagePath/logoImage.jfif";
  final String nointernetimage = "$imagePath/no-internet.png";
}

class AppClr {
  static const Color primaryColor = Color(0xFF0D47A1);
  static const Color gradientcolor1 = Color(0xFFCDFFFD);
  static const Color gradientcolor2 = Color(0xFFD8EAFD);
  static const Color gradientcolor3 = Color(0xFFBDC6FA);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static Color homeblue =
      const Color.fromARGB(166, 25, 124, 204).withOpacity(0.2);
}
