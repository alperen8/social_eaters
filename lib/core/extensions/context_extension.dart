import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;

  double get superLowValue => height * 0.003;
  double get lowValue => height * 0.01;
  double get normalValue => height * 0.02;
  double get mediumValue => height * 0.04;
  double get highValue => height * 0.1;

  double dynamicWidth(double val) => width * val;
  double dynamicHeight(double val) => height * val;
}

extension PaddingExtension on BuildContext {
  EdgeInsets get horizontalPaddingLow => EdgeInsets.symmetric(horizontal: height * 0.01);
  EdgeInsets get horizontalPaddingNormal => EdgeInsets.symmetric(horizontal: height * 0.05);

  EdgeInsets get paddingSuperLow => EdgeInsets.all(superLowValue);
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);
}

extension RadiusExtension on BuildContext {
  BorderRadius get normalBorderRadius => BorderRadius.all(Radius.circular(width * 0.05));
  BorderRadius get lowBorderRadius => BorderRadius.all(Radius.circular(width * 0.02));
  BorderRadius get highBorderRadius => BorderRadius.all(Radius.circular(width * 0.1));

  Radius get lowRadius => Radius.circular(width * 0.02);
  Radius get normalRadius => Radius.circular(width * 0.05);
  Radius get highRadius => Radius.circular(width * 0.1);
// Radius get baseCursorRadius => Radius.circular(20.0);
}

extension SizedBoxExtension on BuildContext {
  Widget get emptySizedWidthBoxLow3x => SizedBox(width: width * 0.03);
  Widget get emptySizedWidthBoxLow => SizedBox(width: width * 0.01);
  Widget get emptySizedHeightBoxLow => SizedBox(height: width * 0.01);
  Widget get emptySizedHeightBoxLow3x => SizedBox(height: width * 0.03);
  Widget get emptySizedHeightBoxNormal => SizedBox(height: width *0.05);
  Widget get emptySizedHeightBoxHigh => SizedBox(height: width * 0.1);
}