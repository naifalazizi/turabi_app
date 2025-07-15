import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/responsive_helper.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

  const AppText(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  });

  // Factory constructors for common text styles
  const AppText.headlineLarge(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  })  : style = null,
        fontSize = 32,
        fontWeight = FontWeight.bold;

  const AppText.headlineMedium(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  })  : style = null,
        fontSize = 28,
        fontWeight = FontWeight.bold;

  const AppText.headlineSmall(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  })  : style = null,
        fontSize = 24,
        fontWeight = FontWeight.bold;

  const AppText.titleLarge(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  })  : style = null,
        fontSize = 22,
        fontWeight = FontWeight.w600;

  const AppText.titleMedium(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  })  : style = null,
        fontSize = 16,
        fontWeight = FontWeight.w600;

  const AppText.titleSmall(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  })  : style = null,
        fontSize = 14,
        fontWeight = FontWeight.w500;

  const AppText.bodyLarge(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  })  : style = null,
        fontSize = 16,
        fontWeight = FontWeight.normal;

  const AppText.bodyMedium(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  })  : style = null,
        fontSize = 14,
        fontWeight = FontWeight.normal;

  const AppText.bodySmall(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  })  : style = null,
        fontSize = 12,
        fontWeight = FontWeight.normal;

  const AppText.labelLarge(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  })  : style = null,
        fontSize = 14,
        fontWeight = FontWeight.w500;

  const AppText.labelMedium(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  })  : style = null,
        fontSize = 12,
        fontWeight = FontWeight.w500;

  const AppText.labelSmall(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  })  : style = null,
        fontSize = 10,
        fontWeight = FontWeight.w500;

  @override
  Widget build(BuildContext context) {
    final responsiveFontSize = ResponsiveHelper.responsiveFontSize(
      context,
      fontSize ?? 14,
    );

    final textStyle = style ??
        GoogleFonts.cairo(
          fontSize: responsiveFontSize,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color ?? AppColors.textPrimary,
        );

    return Text(
      text,
      style: textStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
