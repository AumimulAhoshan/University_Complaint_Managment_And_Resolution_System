import 'package:flutter/material.dart';

import 'device_type.dart';
import 'responsive_breakpoints.dart';

class Responsive {
  Responsive._();

  static DeviceType deviceType(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < ResponsiveBreakpoints.mobile) {
      return DeviceType.mobile;
    }

    if (width < ResponsiveBreakpoints.tablet) {
      return DeviceType.tablet;
    }

    return DeviceType.desktop;
  }

  static bool isMobile(BuildContext context) {
    return deviceType(context) == DeviceType.mobile;
  }

  static bool isTablet(BuildContext context) {
    return deviceType(context) == DeviceType.tablet;
  }

  static bool isDesktop(BuildContext context) {
    return deviceType(context) == DeviceType.desktop;
  }

  static double horizontalPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < ResponsiveBreakpoints.mobile) {
      return 16;
    }

    if (width < ResponsiveBreakpoints.tablet) {
      return 24;
    }

    return 32;
  }

  static double contentMaxWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width >= ResponsiveBreakpoints.desktop) {
      return 1440;
    }

    return width;
  }
}