import 'package:flutter/material.dart';

extension SizeFormatExtension on num {
  EdgeInsets toHorizontalEdgeInsets() {
    return EdgeInsets.symmetric(horizontal: toDouble());
  }
}
