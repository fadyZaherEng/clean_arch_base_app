import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/presentation/screens/home/utils/home_enum.dart';
import 'package:flutter/material.dart';

extension ConverterStatusColorToRealColor on StatusColor {
  Color get toColor {
    switch (this) {
      case StatusColor.success:
        return ColorSchemes.green;
      case StatusColor.notSuccess:
        return ColorSchemes.redError;
    }
  }
}
