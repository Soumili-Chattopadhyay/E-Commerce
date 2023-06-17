import 'package:flutter/material.dart';

class CustomButton1 extends StatefulWidget {
  Color? bodyColor;
  Color borderColor;
  double borderWidth;
  double buttonHeight;
  double buttonWidth;
  String childText;
  double? childTextScaleFactor;
  Color? childTextColor;
  void Function() onTap;
  CustomButton1({
    Key? key,
    this.bodyColor,
    required this.borderColor,
    required this.borderWidth,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.childText,
    this.childTextScaleFactor,
    this.childTextColor,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CustomButton1> createState() => _CustomButton1State();
}

class _CustomButton1State extends State<CustomButton1> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        
        height: widget.buttonHeight,
        width: widget.buttonWidth,
        decoration: BoxDecoration(
          color: widget.bodyColor,
          border: Border.all(
            color: widget.borderColor,
            width: widget.borderWidth,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            widget.childText,
            textScaleFactor: widget.childTextScaleFactor,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: widget.childTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
