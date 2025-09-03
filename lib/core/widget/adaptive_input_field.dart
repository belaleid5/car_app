import 'dart:async';


import 'package:car_app/core/functions/build_outline_border.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdaptiveInputField extends StatefulWidget {
  final BuildContext context;
  final TextEditingController controller;
  final String? title;
  final double heightAfterIt;
  final bool readOnly;
  final String hintText;
  final CrossAxisAlignment crossAxisAlignment;
  final String? errorText;
  final TextDirection? textDirection;
  final Widget? prefix;
  final Widget? textFormFieldIcon;
  final String? initialValue;
  final Color? suffixColor;
  final TextInputType? keyboardType;
  final dynamic Function(String)? onSubmit;
  final dynamic Function(String)? onChange;
  final dynamic Function()? onTap;
  final String? Function(String?)? validate;
  final bool isPassword;
  final bool? enabled;
  final Widget? suffix;
  final dynamic Function()? suffixPressed;
  final BoxConstraints? constraints;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final TextAlign textAlign;
  final int? maxLines;
  final String? counterText;
  final int? maxLength;
  final FocusNode? focusNode;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final double radius;
  final bool doOnTapOutside;
  final Color? borderColor;
  final Color? filledColor;
    final Color? hintColor;

  final TextStyle? textStyle;

  const AdaptiveInputField({
    this.hintColor,
    this.borderColor,
    this.filledColor,
    required this.context,
    required this.controller,
    required this.hintText,
    this.validate,
    this.title,
    this.counterText,
    this.maxLength,
    this.heightAfterIt = 0,
    this.doOnTapOutside = true,
    this.focusNode,
    this.textDirection,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.suffixColor,
    this.radius = 10.67,
    this.textFormFieldIcon,
    this.autofocus = false,
    this.readOnly = false,
    this.prefix,
    this.contextMenuBuilder,
    this.initialValue,
    this.onSubmit,
    this.onChange,
    this.onTap,
    this.enabled,
    this.suffix,
    this.suffixPressed,
    this.constraints,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.isPassword = false,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.textStyle,
    super.key,
  });

  @override
  State<AdaptiveInputField> createState() => _AdaptiveInputFieldState();
}

class _AdaptiveInputFieldState extends State<AdaptiveInputField> {
  String _animatedHint = '';
  int _charIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTypingEffect();
  }

  void _startTypingEffect() {
    _timer = Timer.periodic(const Duration(milliseconds: 80), (timer) {
      if (_charIndex < widget.hintText.length) {
        setState(() {
          _animatedHint += widget.hintText[_charIndex];
          _charIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.crossAxisAlignment,
      children: [
        if (widget.title != null)
          Text(widget.title!, style: Theme.of(context).textTheme.labelLarge),
        if (widget.title != null)
        TextFormField(
          readOnly: widget.readOnly,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          onTapOutside:
              widget.doOnTapOutside
                  ? (PointerDownEvent event) =>
                      FocusManager.instance.primaryFocus?.unfocus()
                  : null,
          obscureText: widget.isPassword,
          textDirection: widget.textDirection,
          textAlign: widget.textAlign,
          onFieldSubmitted: widget.onSubmit,
          enabled: widget.enabled,
          autofocus: widget.autofocus,
          onChanged: widget.onChange,
          focusNode: widget.focusNode,
          onTap: widget.onTap,
          contextMenuBuilder: widget.contextMenuBuilder,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          validator: widget.validate,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          textCapitalization: widget.textCapitalization,
          textAlignVertical: TextAlignVertical.center,
          style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium,
          initialValue: widget.initialValue,
          decoration: InputDecoration(
            icon: widget.textFormFieldIcon,
            errorText: widget.errorText,
            fillColor: widget.filledColor ?? AppColor.secondary,
            filled: true,
            hintText: _animatedHint,
            hintStyle: AppTextStyles.poppins14(
              context,
            ).copyWith(color:widget.hintColor?? AppColor.insideColor),

            contentPadding: const EdgeInsets.all(15),
            constraints: widget.constraints,
            counterText: widget.counterText,
            errorStyle: Theme.of(context).textTheme.labelLarge,
            enabledBorder: buildOutlineBorder().copyWith(
              borderSide: BorderSide(
                color:
                    widget.borderColor ?? AppColor.insideColor.withOpacity(0.5),
              ),
            ),
            focusedBorder: buildOutlineBorder().copyWith(
              borderSide: BorderSide(
                color:
                    widget.borderColor ?? AppColor.secondary.withOpacity(0.8),
              ),
            ),
            border: buildOutlineBorder().copyWith(
              borderSide: BorderSide(
                color:
                    widget.borderColor ?? AppColor.insideColor.withOpacity(0.5),
              ),
            ),
            prefixIcon: widget.prefix,
            suffixIcon:
                widget.suffix != null
                    ? IconButton(
                      onPressed: widget.suffixPressed,
                      icon: widget.suffix!,
                      color: widget.suffixColor,
                    )
                    : null,
          ),
        ),
        SizedBox(height: widget.heightAfterIt),
      ],
    );
  }
}
