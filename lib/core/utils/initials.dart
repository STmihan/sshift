import 'package:flutter/widgets.dart';

String initialsOf(String title) {
  final words = title.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();

  if (words.isEmpty) {
    return '';
  }

  if (words.length == 1) {
    return words.first.characters.take(2).toString().toUpperCase();
  }

  return words.take(3).map((w) => w.characters.first).join().toUpperCase();
}
