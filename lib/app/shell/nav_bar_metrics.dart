import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../core/theme/dimensions.dart';

const navBarHeight = 60.0;
const navBarBottomGap = 12.0;
const navBarSideInset = 16.0;
const navBarPadding = 4.0;
const navBarReservedHeight = navBarHeight + navBarBottomGap + 24;

double navBarRightInset(double screenWidth) {
  return (screenWidth - math.min(screenWidth, contentMaxWidth)) / 2 + navBarSideInset;
}

double navBarBottomReserve(BuildContext context) {
  return navBarReservedHeight + MediaQuery.paddingOf(context).bottom;
}
