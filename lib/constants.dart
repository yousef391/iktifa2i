import 'package:flutter/material.dart';

class Constants {
  // Main brand colors
  static var primaryColor = const Color(0xFF2EB56F); // Green - main brand color
  static var secondaryColor = const Color(
    0xFFFFFFFF,
  ); // White - background color

  // Text colors
  static var textPrimaryColor = const Color(
    0xFF333333,
  ); // Dark grey for main text
  static var textSecondaryColor = const Color(
    0xFF666666,
  ); // Medium grey for secondary text

  // UI element colors
  static var borderColor = const Color(0xFFE0E0E0); // Light grey for borders
  static var accentColor = const Color(
    0xFF34C759,
  ); // Slightly lighter green for accents

  // Social media colors
  static var facebookColor = const Color(0xFF1877F2); // Facebook blue
  static var googleColor = Colors.white; // White for Google button
  static var appleColor = Colors.black; // Black for Apple button

  // Status colors
  static var successColor = const Color(0xFF4CAF50); // Green for success states
  static var warningColor = const Color(0xFFFFC107); // Yellow for warnings
  static var errorColor = const Color(0xFFE53935); // Red for errors

  // Additional colors from original palette (renamed to match our theme)
  static var highlightColor = const Color(
    0xffE88759,
  ); // Orange highlight (was customorange)
  static var notificationColor = const Color(
    0xffFB7785,
  ); // Pink for notifications (was notifcolor)
}
