import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class IconBottomBar extends StatelessWidget {
  IconBottomBar({
    Key? key,
    required this.text,
    required this.icon,
    required this.selected,
    // required this.onTap
  }) : super(key: key);

  final String text;
  final IconData icon;
  final bool selected;

  ThemeData theme = AppTheme.theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 32, child: Icon(icon, color: selected ? theme.primaryColor : Colors.blueGrey[400])),
        FxText.bodySmall(text,  color: selected ? theme.primaryColor : Colors.blueGrey[400])
      ],
    );
  }
}