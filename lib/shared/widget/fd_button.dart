import 'package:flutter/material.dart';

import '../theme.dart';

class FDButton extends StatelessWidget {
  final void Function()? onPressed;
  final double? width;
  final String? text;
  final Color? color;
  final Color? textColor;
  final ShapeBorder? shape;
  final Widget? child;
  const FDButton({
    Key? key,
    this.onPressed,
    this.text,
    this.width,
    this.color,
    this.textColor,
    this.shape,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color ?? Theme.of(context).primaryColor,
      elevation: 0,
      shape: shape ??
          const RoundedRectangleBorder(
            borderRadius: circularRadius,
          ),
      child: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          child: child ??
              Center(
                child: Text(
                  text ?? "",
                  style: TextStyle(
                    color: textColor ?? Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
