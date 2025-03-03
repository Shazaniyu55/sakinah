// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sakinah_app/constants/constant.dart';

class BottomRectangularBtn extends StatelessWidget {
  final Function onTapFunc;
  final String btnTitle;
  final Color? color;
  final Color? buttonTextColor;

  const BottomRectangularBtn({
    super.key,
    required this.onTapFunc,
    required this.btnTitle,
    this.color,
    this.buttonTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTapFunc.call();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: color ?? COLOR_CUSTOM,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text(
            btnTitle,
            style: TextStyle(
              color: buttonTextColor ?? Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
