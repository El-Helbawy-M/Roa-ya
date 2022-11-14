import 'package:flutter/material.dart';

class BlankWidget extends StatelessWidget {
  const BlankWidget({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);
  final double height, width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
    );
  }
}
