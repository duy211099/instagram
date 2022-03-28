import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String content;
  final BuildContext context;

  const ErrorDialog(
      {Key? key,
      this.title = 'Error',
      this.content = '',
      required this.context})
      : super(key: key);

  @override
  Widget build(context) {
    return Platform.isIOS
        ? _showIosDialog(context)
        : _showAndroidDialog(context);
  }

  CupertinoAlertDialog _showIosDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Ok'),
        )
      ],
    );
  }

  AlertDialog _showAndroidDialog(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Ok'),
        )
      ],
    );
  }
}
