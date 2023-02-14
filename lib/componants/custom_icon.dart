import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget customImageIcon({String? folderPath, @required String? imageName, String? imagePath, double? width, double? height, BoxFit fit = BoxFit.contain, color}) {
  return Image.asset(
    'assets/${folderPath ?? "images"}/$imageName.${imagePath ?? "png"}',
    color: color,
    width: width ?? 30,
    height: height ?? 25,
    fit: fit,
  );
}

Widget customImageIconSVG({@required String? imageName, double? height, double? width, Color? color}) {
  return SizedBox(
    width: width,
    height: height,
    child: SvgPicture.asset(
      'assets/svgs/$imageName.svg',
      color: color,
    ),
  );
}
