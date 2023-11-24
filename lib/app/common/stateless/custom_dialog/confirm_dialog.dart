import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final void Function()? btnOkOnPress;
  const ConfirmDialog({required this.title,required this.message, required this.btnOkOnPress,super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = AppTheme.theme;
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        padding: FxSpacing.all(20),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
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
            Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: FxText.titleMedium(title, fontWeight: 600, color: theme.colorScheme.onBackground,),
                  ),
                ),
              ],
            ),
            const Divider(),
            Container(
                margin: FxSpacing.only(top: 8),
                child: FxText.bodyMedium(message, color: theme.colorScheme.onBackground,)
            ),
            Container(
                margin: FxSpacing.top(24),
                alignment: AlignmentDirectional.centerEnd,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FxButton.text(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: FxText.bodyMedium(
                          "Hủy",
                          fontWeight: 600,
                          color: theme.primaryColor,
                        )),
                    FxButton(
                        backgroundColor: theme.primaryColor,
                        borderRadiusAll: 4,
                        elevation: 0,
                        onPressed: btnOkOnPress,
                        child: FxText.bodyMedium("Đồng ý",
                            fontWeight: 600,
                            color: theme.scaffoldBackgroundColor)),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}