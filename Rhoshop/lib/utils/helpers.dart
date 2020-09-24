import 'package:flutter/material.dart';

void dismissKeyboard(context) {
  FocusScope.of(context).requestFocus(FocusNode());
}
