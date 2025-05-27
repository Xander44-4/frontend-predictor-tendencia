import 'package:flutter/material.dart';

class ElevatedBtnX extends StatefulWidget {
  final EdgeInsetsGeometry widthContainer;
  final IconData iconBtn;
  final String textBtn;
  final WidgetStateProperty<Color?> backgroundColor;
  const ElevatedBtnX(
      {super.key,
        required this.widthContainer,
        required this.iconBtn,
        required this.textBtn,
      required this.backgroundColor });

  @override
  State<ElevatedBtnX> createState() => _ElevatedBtnXState();
}

class _ElevatedBtnXState extends State<ElevatedBtnX> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: widget.widthContainer,
        width: double.infinity,
        height: 60,

        child: ElevatedButton.icon(
          onPressed: () {},
          label: Text(
            widget.textBtn,
          ),
          icon: Icon(widget.iconBtn),
          style: ButtonStyle(
            backgroundColor:  widget.backgroundColor,
              foregroundColor: const WidgetStatePropertyAll(Colors.black)),
        ));
  }
}
