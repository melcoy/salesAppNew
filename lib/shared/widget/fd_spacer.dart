import 'package:flutter/material.dart';

enum Spacing {
  extraSmall,
  small,
  medium,
  large,
}

Map<Spacing, double> spacings = <Spacing, double>{
  Spacing.extraSmall: 8,
  Spacing.small: 16,
  Spacing.medium: 24,
  Spacing.large: 32,
};

class VerticalSpace extends StatelessWidget {
  final Spacing? spacing;

  const VerticalSpace({
    this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: spacings[spacing] ?? spacings[Spacing.small],
    );
  }
}

class HorizontalSpace extends StatelessWidget {
  final Spacing? spacing;

  const HorizontalSpace({
    this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: spacings[spacing] ?? spacings[Spacing.small],
    );
  }
}
