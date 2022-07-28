import 'package:flutter/cupertino.dart';

class Dimension {
  static bool land = false;
  static double? width;
  static double? height;
  static MediaQueryData? query;

  static init(BuildContext context) {
    query = MediaQuery.of(context);
    land = query!.orientation == Orientation.landscape;
    width = query!.size.width;
    height = query!.size.height - query!.viewPadding.vertical;
  }

  static dynamic scalePixel(double px) {
    return px * (land ? height! : width!) / 100;
  }

  static double mapValue(x, inMin, inMax, outMin, outMax) {
    return (x - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
  }
}
