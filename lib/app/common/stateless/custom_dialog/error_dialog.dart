import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:fashion_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';




class ErrorDialog extends StatelessWidget {
  final String message;
  final IconData icon;
  const ErrorDialog({required this.icon,required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = AppTheme.theme;
    CustomTheme customTheme = AppTheme.customTheme;
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
                child: Icon(
                  icon,
                  //MdiIcons.cloudCheckOutline,
                  size: 40,
                  color: customTheme.colorError,
                )),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(
                  child: FxText.titleMedium("Thất bại!", color: customTheme.colorError,)),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: FxText.bodyMedium(message, color: theme.colorScheme.onBackground, textAlign: TextAlign.center,)),
                    ],
                  )
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(
                child: FxButton(
                    elevation: 2,
                    borderRadiusAll: 4,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: FxText.bodySmall("Đồng ý",
                        color: theme.colorScheme.onPrimary)),
              ),
            )
          ],
        ),
      ),
    );
  }
}