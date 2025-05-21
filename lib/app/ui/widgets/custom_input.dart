import 'package:flutter/material.dart';

class InputX extends StatefulWidget {
  final String placeHolderTxt;
  final IconData customIcon;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const InputX({
    super.key,
    required this.placeHolderTxt,
    required this.customIcon,
    required this.isPassword,
    required this.controller,
    required this.validator,
  });

  @override
  State<InputX> createState() => _InputXState();
}

class _InputXState extends State<InputX> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          prefixIcon:Icon(widget.customIcon),
          hintText: widget.placeHolderTxt,
          hintStyle: const TextStyle(color: Colors.black),
          border: const OutlineInputBorder(),
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.only(),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.5),
              borderSide:
              const BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.5),
              borderSide:
              const BorderSide(color: Colors.red)),
        ),
        style: const TextStyle(color: Colors.black),
        obscureText: widget.isPassword,

      ),
    );
  }
}
