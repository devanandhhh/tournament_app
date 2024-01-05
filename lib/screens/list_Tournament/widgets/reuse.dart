import 'package:flutter/material.dart';

editingtextform({required String labeltxt, required controller}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(labelText: labeltxt),
  );
}
