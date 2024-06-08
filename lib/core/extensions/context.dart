import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  EdgeInsets get padding => MediaQuery.of(this).padding;
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;
  double get statusBarHeight => MediaQuery.of(this).padding.top;
  double get bottomBarHeight => MediaQuery.of(this).padding.bottom;
  double get viewInsetsBottom => MediaQuery.of(this).viewInsets.bottom;
  double get viewInsetsTop => MediaQuery.of(this).viewInsets.top;
  double get viewPaddingBottom => MediaQuery.of(this).viewPadding.bottom;
  double get viewPaddingTop => MediaQuery.of(this).viewPadding.top;
  double get viewPaddingRight => MediaQuery.of(this).viewPadding.right;
  double get viewPaddingLeft => MediaQuery.of(this).viewPadding.left;
  double get viewInsetsRight => MediaQuery.of(this).viewInsets.right;
  double get viewInsetsLeft => MediaQuery.of(this).viewInsets.left;
  double get viewPaddingHorizontal => viewPaddingLeft + viewPaddingRight;
  double get viewPaddingVertical => viewPaddingTop + viewPaddingBottom;
  double get viewInsetsHorizontal => viewInsetsLeft + viewInsetsRight;
  double get viewInsetsVertical => viewInsetsTop + viewInsetsBottom;
  double get viewHorizontal => viewPaddingHorizontal + viewInsetsHorizontal;
  double get viewVertical => viewPaddingVertical + viewInsetsVertical;
  double get viewWidth => width - viewHorizontal;
  double get viewHeight => height - viewVertical;
  double get viewWidthPortrait =>
      isPortrait ? viewWidth : height - viewVertical;
  double get viewHeightPortrait =>
      isPortrait ? viewHeight : width - viewHorizontal;
  double get viewWidthLandscape =>
      isLandscape ? viewWidth : height - viewVertical;
  double get viewHeightLandscape =>
      isLandscape ? viewHeight : width - viewHorizontal;
  double get viewWidthSquare => viewWidth < viewHeight ? viewWidth : viewHeight;
  double get viewHeightSquare =>
      viewHeight < viewWidth ? viewHeight : viewWidth;

  // Text Styles

  TextStyle get label24500 => textTheme.displayLarge!;
  TextStyle get label20500 => textTheme.displayMedium!;
  TextStyle get label16500 => textTheme.displaySmall!;

  TextStyle get label24700 => textTheme.headlineLarge!;
  TextStyle get label20700 => textTheme.headlineMedium!;
  TextStyle get label16700 => textTheme.headlineSmall!;

  TextStyle get label24400 => textTheme.bodyLarge!;
  TextStyle get label20400 => textTheme.bodyMedium!;
  TextStyle get label16400 => textTheme.bodySmall!;

  TextStyle get label14700 => textTheme.titleLarge!;
  TextStyle get label12700 => textTheme.titleMedium!;
  TextStyle get label10700 => textTheme.titleSmall!;

  TextStyle get label14500 => textTheme.labelLarge!;
  TextStyle get label12500 => textTheme.labelMedium!;
  TextStyle get label10500 => textTheme.labelSmall!;

  // Colors
  Color get primaryColor => colorScheme.primary;
  Color get backgroundColor => colorScheme.surface;
  Color get secondaryColor => colorScheme.secondary;
  Color get errorColor => colorScheme.error;
  Color get outlineColor => colorScheme.outline;
  Color get outlineColor2 => colorScheme.outlineVariant;
  Color get onPrimary => colorScheme.onPrimary;
  Color get onSecondary => colorScheme.onSecondary;

  // SizedBoxes
  SizedBox get bottomPadding => SizedBox(height: viewPaddingBottom);
  SizedBox get topPadding => SizedBox(height: viewPaddingTop);
}
