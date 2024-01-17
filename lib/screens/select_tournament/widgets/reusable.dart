import 'package:flutter/material.dart';

tabtext(text) {
  return Tab(
    text: text,
  );
}

tealcolor() {
  return const TextStyle(
      color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 30);
}

font17() {
  return const TextStyle(
      color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500);
}

underlineDecoration() {
  return UnderlineTabIndicator(
      borderSide:const BorderSide(width: 3.0, color: Colors.grey),
      borderRadius: BorderRadius.circular(6),
      insets:const EdgeInsets.symmetric(horizontal: 66.0));
}
