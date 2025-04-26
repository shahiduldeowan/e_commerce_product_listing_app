import 'package:flutter/material.dart';

extension SizeFormatExtension on num {
  EdgeInsets toAllEdgeInsets() {
    return EdgeInsets.all(toDouble());
  }

  EdgeInsets toHorizontalEdgeInsets() {
    return EdgeInsets.symmetric(horizontal: toDouble());
  }

  EdgeInsets toLeftEdgeInsets() {
    return EdgeInsets.only(left: toDouble());
  }

  EdgeInsets toSymmetricEdgeInsets({double? vertical, double? horaizontal}) {
    return EdgeInsets.symmetric(
      vertical: vertical ?? toDouble(),
      horizontal: horaizontal ?? toDouble(),
    );
  }

  BorderRadius toRoundedBorderRadius() {
    return BorderRadius.circular(toDouble());
  }
}
