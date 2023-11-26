import 'package:flutter/material.dart';

var myInputDecoration = InputDecorationTheme(
  contentPadding: const EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.circular(12),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.circular(12),
  ),
  filled: true,
  fillColor: const Color(0xFFFFFFFF),
);

