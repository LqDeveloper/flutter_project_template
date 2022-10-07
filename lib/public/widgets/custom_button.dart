import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final Widget? child;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final Color? textColor; //在textStyle中设置color无效
  final Color? backgroundColor;
  final Color? overlayColor;
  final BorderRadiusGeometry? borderRadius;
  final double? allRadius;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final BorderSide? side;
  final AlignmentGeometry? alignment;
  final bool? enableFeedback;
  final VoidCallback? onPressed;

  const CustomButton(
      {Key? key,
      this.title,
      this.child,
      this.width,
      this.height,
      this.textStyle,
      this.textColor,
      this.backgroundColor,
      this.overlayColor,
      this.borderRadius,
      this.allRadius,
      this.elevation,
      this.padding,
      this.side,
      this.alignment,
      this.enableFeedback,
      this.onPressed})
      : assert(borderRadius == null || allRadius == null,
            'Cannot provide both a borderRadius and a allRadius'),
        assert(child == null || title == null,
            'Cannot provide both a child and a title'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        style: _buttonStyle,
        onPressed: onPressed,
        child: title != null ? Text(title!) : (child ?? const SizedBox()),
      ),
    );
  }

  ButtonStyle get _buttonStyle {
    BorderRadiusGeometry bRadius = BorderRadius.circular(allRadius ?? 0);
    if (borderRadius != null) {
      bRadius = borderRadius!;
    }
    return ButtonStyle(
        textStyle: ButtonStyleButton.allOrNull(textStyle),
        foregroundColor: ButtonStyleButton.allOrNull(textColor),
        backgroundColor: ButtonStyleButton.allOrNull(backgroundColor),
        overlayColor: ButtonStyleButton.allOrNull(overlayColor),
        shape: ButtonStyleButton.allOrNull(
            RoundedRectangleBorder(borderRadius: bRadius)),
        elevation: ButtonStyleButton.allOrNull(elevation),
        padding: ButtonStyleButton.allOrNull(padding),
        side: ButtonStyleButton.allOrNull(side),
        alignment: alignment,
        enableFeedback: enableFeedback);
  }
}
