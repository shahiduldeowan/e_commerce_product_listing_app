import 'dart:async';
import 'package:flutter/foundation.dart';

class Debouncer {
  Debouncer({required this.milliseconds});

  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
