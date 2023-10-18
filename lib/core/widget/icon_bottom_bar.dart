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
        SizedBox(height: 32, child: Icon(icon, size: 30, color: selected ? theme.primaryColor : Colors.blueGrey[400])),
        const SizedBox(
          height: 10,
        ),
        Text(text, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, height: 0.1, color: selected ? theme.primaryColor : Colors.blueGrey[400]))
      ],
    );
  }
}