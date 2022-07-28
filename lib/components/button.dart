import 'package:flutter/material.dart';

class BlockButtonWidget extends StatelessWidget {
  const BlockButtonWidget(
      {Key? key,
      required this.color,
      required this.text,
      required this.onPressed})
      : super(key: key);

  final Color color;
  final Text text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //   borderRadius: BorderRadius.all(Radius.circular(100)),
      // ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 40,
              offset: const Offset(0, 15)),
          BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 13,
              offset: const Offset(0, 3))
        ],
        borderRadius: const BorderRadius.all(Radius.circular(100)),
      ),
      child: FlatButton(
        onPressed: onPressed,
        padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 14),
        color: color,
        shape: const StadiumBorder(),
        child: text,
      ),
    );
  }
}
