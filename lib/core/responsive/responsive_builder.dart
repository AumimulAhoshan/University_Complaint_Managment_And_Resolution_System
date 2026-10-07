import 'package:flutter/material.dart';

import 'device_type.dart';
import 'responsive.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context) mobile;
  final Widget Function(BuildContext context)? tablet;
  final Widget Function(BuildContext context)? desktop;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType = Responsive.deviceType(context);

    switch (deviceType) {
      case DeviceType.mobile:
        return mobile(context);

      case DeviceType.tablet:
        return tablet?.call(context) ?? mobile(context);

      case DeviceType.desktop:
        return desktop?.call(context) ??
            tablet?.call(context) ??
            mobile(context);
    }
  }
}