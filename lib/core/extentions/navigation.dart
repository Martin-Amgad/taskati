import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<T?> pushTo<T>(Widget screen) {
    return Navigator.push<T>(this, MaterialPageRoute(builder: (_) => screen));
  }

  Future<T?> pushWithReplacement<T>(Widget screen) {
    return Navigator.pushReplacement<T, T>(
      this,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  void pop<T extends Object?>([T? result]) {
    Navigator.pop(this, result);
  }
}
