import 'package:flutter/material.dart';

// Enum value for device type
enum DeviceType { mobile, tablet, desktop }

class SizeConfig {
  static late double screenHeight;
  static late double screenWidth;
  static late double heightMultiplier;
  static late double widthMultiplier;
  static late double textMultiplier;
  static late double iconMultiplier;
  static late double imageMultiplier;
  static late DeviceType deviceType;
  static late Orientation orientation;

  // Singleton instance to ensure a single initialization
  static final SizeConfig _instance = SizeConfig._internal();

  factory SizeConfig() {
    return _instance;
  }

  SizeConfig._internal();

  // Initialize the SizeConfig
  static void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    screenHeight = mediaQuery.size.height;
    screenWidth = mediaQuery.size.width;
    orientation = mediaQuery.orientation;

    // Determine device type based on screen size and orientation
    if (orientation == Orientation.portrait) {
      if (screenWidth < 450 && screenHeight < 1000) {
        deviceType = DeviceType.mobile;
      } else if (screenWidth >= 450 && screenWidth < 800 && screenHeight >= 900 && screenHeight < 1400) {
        deviceType = DeviceType.tablet;
      } else {
        deviceType = DeviceType.desktop;
      }
    } else {
      if (screenHeight < 450 && screenWidth < 1000) {
        deviceType = DeviceType.mobile;
      } else if (screenWidth >= 900 && screenWidth < 1400 && screenHeight >= 500 && screenHeight < 800) {
        deviceType = DeviceType.tablet;
      } else {
        deviceType = DeviceType.desktop;
      }
    }

    _updateMultipliers();
  }

  // Update multipliers based on device type and orientation
  static void _updateMultipliers() {
    switch (deviceType) {
      case DeviceType.mobile:
        if (orientation == Orientation.portrait) {
          heightMultiplier = screenHeight / 1000;
          widthMultiplier = screenWidth / 450;
        } else {
          heightMultiplier = screenWidth / 1000;
          widthMultiplier = screenHeight / 450;
        }
        break;
      case DeviceType.tablet:
        if (orientation == Orientation.portrait) {
          heightMultiplier = screenHeight / 1000 * 1.5;
          widthMultiplier = screenWidth / 450 * 1.5;
        } else {
          heightMultiplier = screenWidth / 1000 * 1.5;
          widthMultiplier = screenHeight / 450 * 1.5;
        }
        break;
      case DeviceType.desktop:
        if (orientation == Orientation.portrait) {
          heightMultiplier = screenHeight / 1000 * 2;
          widthMultiplier = screenWidth / 450 * 2;
        } else {
          heightMultiplier = screenWidth / 1000 * 2;
          widthMultiplier = screenHeight / 450 * 2;
        }
        break;
    }
  }

  static double getHeight(double height) {
    return height * heightMultiplier;
  }

  static double getWidth(double width) {
    return width * widthMultiplier;
  }

  static double getFontSize(double fontSize) {
    return fontSize * heightMultiplier;
  }

  static double getIconSize(double iconSize) {
    return iconSize * heightMultiplier;
  }

  static double getImageSize(double imageSize) {
    return imageSize * widthMultiplier;
  }

  static double getRadius(double radius) {
    return radius * heightMultiplier;
  }

  static int getMaxLines(double containerHeight, double lineHeight) {
    int maxLines = (containerHeight / lineHeight).floor();
    return maxLines > 2 ? maxLines : 10;
  }
}
