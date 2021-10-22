import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function? onPressed;
  final Color? color;
  final String? text;
  final TextStyle? textStyle;
  final BorderSide? borderSide;
  final Icon? icon;

  const Button({
    Key? key,
    this.onPressed,
    this.color,
    this.text,
    this.textStyle,
    this.borderSide,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: borderSide == null
            ? const BorderSide(
                color: Colors.transparent,
              )
            : borderSide!,
      ),
      onPressed: () => {onPressed!()},
      child: icon != null
          ? Row(
              children: [
                icon!,
                const SizedBox(width: 10.0),
                Text(
                  text ?? "",
                  style: textStyle,
                ),
              ],
            )
          : Text(
              text ?? "",
              style: textStyle,
            ),
    );
  }
}
