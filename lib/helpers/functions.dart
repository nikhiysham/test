import 'package:flutter/material.dart';

class Functions {
  static showAlertDialog(BuildContext ctx, String msg,
      {Function? okAction, Function? yesAction, Function? noAction}) {
    List<Widget>? actions = [];
    if (okAction != null) {
      actions = [TextButton(child: Text("Ok"), onPressed: () => okAction())];
    } else if (yesAction != null) {
      actions = [
        TextButton(child: Text("Yes"), onPressed: () => yesAction()),
        TextButton(child: Text("No"), onPressed: () => Navigator.of(ctx).pop()),
      ];
    } else {
      actions = [
        TextButton(child: Text("Ok"), onPressed: () => Navigator.of(ctx).pop()),
      ];
    }

    return showDialog(
        context: ctx,
        builder: (_) {
          return AlertDialog(
              title: Text("Dialog"), content: Text(msg), actions: actions);
        });
  }
}
