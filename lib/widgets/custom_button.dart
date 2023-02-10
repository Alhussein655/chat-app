import 'dart:ffi';

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({this.width, this.height, this.borderR, this.name, this.color,this.onTap});
  double? width, height, borderR;
  String? name;
  Color? color;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderR!),
          color: color,
        ),
        width: width,
        height: height,
        child: Center(
          child: Text(name!),
        ),
      ),
    );
  }
}
