library clean.statics;

import 'package:flutter/material.dart';

class ButtonStatics {
  static BorderRadius get borderRadius => BorderRadius.circular(11);

  static OutlinedBorder get shape =>
      RoundedRectangleBorder(borderRadius: borderRadius);
}
