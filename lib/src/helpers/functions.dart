import 'package:flutter/material.dart';

extension LightenDarken on Color {
  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}

int responsiveGridColumnCount(double maxWidth,
    [int maxColumnCount = 4, double sensitivity = 1]) {
  if (maxWidth < 300 * sensitivity) {
    return 1;
  } else if (maxWidth < 700 * sensitivity && maxColumnCount >= 2) {
    return 2;
  } else if (maxWidth < 900 * sensitivity && maxColumnCount >= 3) {
    return 3;
  } else if (maxWidth < 1200 * sensitivity && maxColumnCount >= 4) {
    return 4;
  } else {
    return maxColumnCount;
  }
}

extension ResolveWithAll<T> on MaterialStateProperty<T> {
  T resolveWithAll() {
    final allStates = MaterialState.values.toSet();
    return resolve(allStates);
  }
}
