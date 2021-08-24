import 'package:flutter/material.dart';
import 'package:template_bloc/common/ui/app_colors.dart';

class AppTextStyles {
  static const _text = TextStyle(
    fontStyle: FontStyle.normal,
    color: AppColors.textPrimaryColor,
  );

  // Light
  static TextStyle lightTextStyle = _text.copyWith(
    fontWeight: FontWeight.w300,
  );

  // Regular
  static TextStyle regularTextStyle = _text.copyWith(
    fontWeight: FontWeight.normal,
  );

  // Medium
  static TextStyle mediumTextStyle = _text.copyWith(
    fontWeight: FontWeight.w500,
  );

  // Bold
  static TextStyle boldTextStyle = _text.copyWith(
    fontWeight: FontWeight.bold,
  );
}