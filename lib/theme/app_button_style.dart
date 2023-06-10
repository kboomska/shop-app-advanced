import 'package:flutter/material.dart';

import 'package:shop_app/theme/app_colors.dart';

abstract class AppButtonStyle {
  static final ButtonStyle blueButton = ButtonStyle(
    backgroundColor: const MaterialStatePropertyAll(
      AppColors.buttonBackground,
    ),
    foregroundColor: const MaterialStatePropertyAll(
      Colors.white,
    ),
    overlayColor: const MaterialStatePropertyAll(
      AppColors.buttonPressed,
    ),
    splashFactory: NoSplash.splashFactory,
    minimumSize: const MaterialStatePropertyAll(
      Size.fromHeight(48),
    ),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    side: const MaterialStatePropertyAll(BorderSide.none),
  );
}
