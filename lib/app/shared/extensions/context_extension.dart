import 'package:flutter/material.dart';

extension Extras on BuildContext {
  void _showSnackBar(
    String message, {
    Color? color,
    Color? textColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontFamily: 'PlusJakartaDisplay',
            fontSize: 16,
            color: textColor ?? Colors.white,
          ),
        ),
        backgroundColor: color,
      ),
    );
  }

  void showError(String message) {
    _showSnackBar(message, color: Colors.red);
  }

  void showSuccess(String message) {
    _showSnackBar(
      message,
      color: const Color(0xffdbff54),
      textColor: Colors.black,
    );
  }
}
