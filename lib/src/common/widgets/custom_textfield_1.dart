// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextField1 extends StatefulWidget {
  TextEditingController editingController;
  String? labelText;
  String? Function(String?)? validator;
  CustomTextField1({
    required this.editingController,
    this.labelText,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomTextField1> createState() => _CustomTextField1State();
}

class _CustomTextField1State extends State<CustomTextField1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(10.0),
      height: 50.0,
      width: 300.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Theme.of(context).highlightColor,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.editingController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(2.5, 0.25, 2.5, 12.0),
          border: InputBorder.none,
          hintText: widget.labelText,
          hintStyle: const TextStyle(
            color: Colors.black38,
          ),
        ),
      ),
    );
  }
}
