import 'package:flutter/material.dart';
import 'package:moniepointflutterapp/shared/res/app_colors.dart';


class InputBorderStyles {
  static var focusBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.brandPrimaryColor),
      borderRadius: BorderRadius.zero
  );
  static var focusedBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.brandPrimaryColor),
    borderRadius: BorderRadius.zero
  );

  static var focusErrorBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.brandPrimaryColor),
      borderRadius: BorderRadius.zero
  );
}
