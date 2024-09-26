import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/core/framework/theme/colors/app_theme_provider.dart';

class CustomTextField extends ConsumerStatefulWidget {
  final String? hint;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;
  final TextEditingController? textEditingController;
  final bool? obscureText;
  final Widget? prefix;
  final Widget? suffix;
  final FocusNode? node;
  final VoidCallback? onTap;
  final String? Function(String value)? validator;
  final EdgeInsets? padding;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final Color? textFieldColor;
  final bool? hasBorder;
  final String? headerText;
  final TextInputAction textInputAction;
  final bool isPassword;
  final String? whenValid;
  final ({String tipTitle, String tipText})? tipInfo;
  final bool required;
  final double borderRadius;
  final ValueChanged<String>? onSubmitted;

  const CustomTextField({
    super.key,
    this.hint,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
    this.readOnly,
    this.obscureText,
    this.textEditingController,
    this.prefix,
    this.suffix,
    this.node,
    this.validator,
    this.onTap,
    this.padding,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.headerText,
    this.textInputAction = TextInputAction.next,
    this.hasBorder = false,
    this.textFieldColor,
    this.isPassword = false,
    this.whenValid,
    this.tipInfo,
    this.required = false,
    this.onSubmitted,
    this.borderRadius = 10,
  });

  @override
  ConsumerState<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends ConsumerState<CustomTextField> {
  late final FocusNode node;
  @override
  void initState() {
    node = widget.node ?? FocusNode();
    if (widget.isPassword) {
      obscureText = true;
    }
    super.initState();
  }

  bool obscureText = false;
  bool hasEntered = false;

  @override
  Widget build(BuildContext context) {
    const red = Colors.red;
    final colors = ref.watch(appThemeProvider).colors;
    BoxBorder? getBorder() {
      if (!isValid) {
        return Border.all(
          color: red,
          width: 1,
        );
      } else if (widget.whenValid != null && hasEntered) {
        return Border.all(
          color: red,
          width: 1,
        );
      }
      return Border.all(
        color: colors.secondary,
        width: 1,
      );
    }

    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
        node.requestFocus();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.headerText != null) ...[
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        widget.headerText!,
                        style: TextStyle(
                          color: colors.alwaysWhite,
                          fontSize: 14,
                        ),
                      ),
                      if (widget.required) ...[
                        const SizedBox(width: 5),
                        const Text(
                          "*",
                          style: TextStyle(
                            color: red,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
          ],
          Container(
            padding: widget.padding ??
                const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
            decoration: BoxDecoration(
              color: colors.transparent,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: getBorder(),
            ),
            child: Row(
              children: [
                widget.prefix ?? const SizedBox(),
                Expanded(
                  child: TextField(
                    maxLines: widget.maxLines,
                    maxLength: widget.maxLength,
                    focusNode: node,
                    minLines: widget.minLines,
                    keyboardType: widget.keyboardType,
                    cursorColor: colors.alwaysWhite.withOpacity(.5),
                    onTap: () {
                      if (widget.onTap != null) {
                        widget.onTap!();
                      }
                      node.requestFocus();
                    },
                    onSubmitted: (v) {
                      widget.onSubmitted?.call(v);
                    },
                    onChanged: (v) {
                      v = v.trim();
                      widget.onChanged?.call(v);
                      setState(() {
                        value = v;
                        hasEntered = v.isNotEmpty;
                      });
                    },
                    obscureText: widget.obscureText ?? obscureText,
                    controller: widget.textEditingController,
                    readOnly: widget.readOnly ?? false,
                    inputFormatters: widget.inputFormatters,
                    style: TextStyle(color: colors.alwaysWhite),
                    decoration: InputDecoration.collapsed(
                      hintText: widget.hint,
                      hintStyle: TextStyle(
                        color: colors.alwaysWhite.withOpacity(.5),
                      ),
                    ),
                    textInputAction: widget.textInputAction,
                  ),
                ),
                widget.suffix ?? const SizedBox(),
                if (widget.isPassword)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    child: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off,
                      color: colors.alwaysWhite.withOpacity(.5),
                    ),
                  ),
              ],
            ),
          ),
          if (!isValid)
            Column(
              children: [
                const SizedBox(height: 8),
                Text(
                  widget.validator!(value)!,
                  style: const TextStyle(color: red, fontSize: 12),
                ),
              ],
            ),
        ],
      ),
    );
  }

  String value = "";

  bool get isValid {
    if (widget.validator == null || !hasEntered) {
      return true;
    }
    return widget.validator!(value) == null;
  }
}
