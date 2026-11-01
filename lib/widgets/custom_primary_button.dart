import 'package:flutter/material.dart';
import 'package:homework/themes/app_colors.dart';

class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isFullWidth,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.height,
    this.borderRadius,
    this.isEnabled,
    this.isLoading,
  });

  final String text;

  final VoidCallback? onPressed;

  final bool? isFullWidth;

  final Color? backgroundColor;

  final Color? textColor;

  final double? fontSize;

  final double? height;

  final double? borderRadius;

  final bool? isEnabled;
  final bool? isLoading;
  @override
  Widget build(BuildContext context) {
    final bool fullWidth = isFullWidth ?? true;
    final Color bgColor = backgroundColor ?? AppColors.primaryColor;
    final Color txtColor = textColor ?? AppColors.whiteColor;
    final double btnHeight = height ?? 56;
    final double btnBorderRadius = borderRadius ?? 16;
    final bool enabled = isEnabled ?? true;
    final bool loading = isLoading ?? false;

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: btnHeight,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: loading ? AppColors.greyColor : bgColor,
          disabledBackgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(btnBorderRadius),
          ),
          elevation: 0,
        ),
        child: loading
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.whiteColor,
                ),
              )
            : Text(
                text.toUpperCase(),
                style: TextStyle(color: txtColor),
              ),
      ),
    );
  }
}
