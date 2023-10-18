import 'package:fashion_app/core/utils/flutx/lib/responsive/responsive.dart';
import 'package:flutter/material.dart';

class FxFlexItem extends StatelessWidget {
  final Widget child;
  final String? sizes;
  final String? displays;

  Map<FxScreenMediaType, int> get flex =>
      FxScreenMedia.getFlexedDataFromString(sizes);
  Map<FxScreenMediaType, FxDisplayType> get display =>
      FxScreenMedia.getDisplayDataFromString(displays);

  FxFlexItem({
    super.key,
    required this.child,
    this.sizes,
    this.displays,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
