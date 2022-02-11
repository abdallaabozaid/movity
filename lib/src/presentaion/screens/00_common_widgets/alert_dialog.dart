import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movity/config/app_theme.dart';
import 'package:movity/config/colors.dart';
import 'dart:io';

import 'package:movity/src/presentaion/common_widgets/platform_aware_widget.dart';

class AwareAlertDialog extends PlatformAwareWidget {
  final String title;
  final String alertContentText;
  final String? cancelText;

  // ignore: use_key_in_widget_constructors
  const AwareAlertDialog({
    this.cancelText,
    required this.alertContentText,
    required this.title,
  });

  Future<bool?> show(BuildContext context,
      {required bool isDissmissible}) async {
    return Platform.isIOS
        ? await showCupertinoDialog(
            barrierDismissible: isDissmissible,
            context: context,
            builder: (context) => this)
        : await showDialog<bool>(
            context: context,
            builder: (context) => this,
            barrierDismissible: isDissmissible);
  }

  @override
  Widget buildCupertinoWidgt(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(alertContentText),
      actions: _buildAlertDialogActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      actions: _buildAlertDialogActions(context),
      elevation: 10,
      backgroundColor: AppColors.goldenColor.withOpacity(0.4),
      content: Text(alertContentText),
      contentTextStyle: const TextStyle(color: Colors.white),
      contentPadding: const EdgeInsets.all(12),
      insetPadding: const EdgeInsets.all(20),
      buttonPadding: const EdgeInsets.all(12),
      title: Text(title),
      titlePadding: const EdgeInsets.all(12),
      titleTextStyle: const TextStyle(color: Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: AppTheming.appBorderRadius,
        side: const BorderSide(color: Colors.white, width: 1.5),
      ),
    );
  }

  List<Widget> _buildAlertDialogActions(BuildContext context) {
    List<Widget> actions = [];
    actions.add(
      AlertDialogAction(
        child: const Text(
          'Ok',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.of(context).pop(true);
          // Navigator.of(context).pop(true);
        },
      ),
    );
    if (cancelText != null) {
      actions.add(
        AlertDialogAction(
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      );
    }

    return actions;
  }
}

class AlertDialogAction extends PlatformAwareWidget {
  const AlertDialogAction(
      {required this.child, required this.onPressed, Key? key})
      : super(key: key);

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget buildCupertinoWidgt(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
