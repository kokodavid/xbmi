import 'package:flutter/material.dart';

import '../utlis/widget_utils.dart';

double appBarHeight(BuildContext context) {
  return screenAwareSize(80.0, context) + MediaQuery.of(context).padding.top;
}