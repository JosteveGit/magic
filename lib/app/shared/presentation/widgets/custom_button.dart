import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/core/framework/theme/colors/app_theme_provider.dart';

class CustomButton extends ConsumerWidget {
  final bool? expanded;
  final String? text;
  final Color? color;
  final VoidCallback? onPressed;
  final Color? textColor;
  final EdgeInsets? padding;
  final bool Function()? validator;
  final double? width;
  final double? radius;
  final Widget? prefixWidget;
  final double? fontSize;
  final bool isSecondary;

  const CustomButton({
    super.key,
    this.expanded = false,
    @required this.text,
    this.color,
    @required this.onPressed,
    this.textColor,
    this.padding,
    this.validator,
    this.width,
    this.radius,
    this.prefixWidget,
    this.fontSize,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.read(appThemeProvider).colors;
    final buttonColor =
        color ?? (isSecondary ? colors.always26292C : colors.primary);
    return SizedBox(
      width: width ?? (expanded! ? double.maxFinite : null),
      child: ElevatedButton(
        onPressed: (validator == null ? true : validator!()) ? onPressed : null,
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            padding ?? const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
          ),
          elevation: WidgetStateProperty.all(0.0),
          backgroundColor: (validator == null ? true : validator!())
              ? WidgetStateProperty.all(buttonColor)
              : WidgetStateProperty.all(
                  (buttonColor).withOpacity(0.5),
                ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 30),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixWidget ?? Container(),
            Text(
              "$text",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: textColor ?? (isSecondary ? Colors.white : Colors.black),
                fontSize: fontSize ?? 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
