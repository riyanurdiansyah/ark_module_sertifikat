import 'package:flutter/material.dart';

import 'app_style_text.dart';

class AppStyleTextField {
  static customOutlined(
    String hint,
    Widget? prefixIcon,
    Widget? suffixIcon,
  ) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderSide: const BorderSide(width: 0.6, color: Color(0xFFC0C2C6)),
        borderRadius: BorderRadius.circular(6),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 0.6, color: Color(0xFFC0C2C6)),
        borderRadius: BorderRadius.circular(6),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 0.6, color: Color(0xFFC0C2C6)),
        borderRadius: BorderRadius.circular(6),
      ),
      contentPadding: const EdgeInsets.only(top: 6, left: 14),
      hintStyle: AppStyleText.styleMontserrat(
        fontWeight: FontWeight.w500,
        fontSize: 11,
        color: const Color(0xFFACAEB2),
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }
}
