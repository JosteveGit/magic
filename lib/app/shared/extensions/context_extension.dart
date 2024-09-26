import 'package:flutter/material.dart';

extension Extras on BuildContext {
  void _showSnackBar(
    String message, {
    Color? color,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: 'PlusJakartaDisplay',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        backgroundColor: color,
      ),
    );
  }

  void showError(String message) {
    _showSnackBar(message, color: Colors.red);
  }
}
