import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tripleuglobal/constants/constant_color.dart';


class DialogHelper {
  static final border = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4),
  );


  static Future showDialogWithTwoButtons(
    BuildContext context,
    String title,
    String content, {
    String positiveButtonLabel = "Yes",
    VoidCallback? positiveButtonPress,
    String negativeButtonLabel = "Cancel",
    VoidCallback? negativeButtonPress,
    barrierDismissible = true,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text(title, textAlign: TextAlign.center),
          content: Text(content),
          shape: border,
          actions: <Widget>[
            FlatButton(
              child: Text(negativeButtonLabel),
              textColor: Colors.black87,
              onPressed: () {
                if (negativeButtonPress != null) {
                  negativeButtonPress();
                } else {
                  Navigator.of(context, rootNavigator: true).pop();
                }
              },
            ),
            FlatButton(
              child: Text(positiveButtonLabel),
              onPressed: () {
                if (positiveButtonPress != null) {
                  positiveButtonPress();
                } else {
                  Navigator.of(context, rootNavigator: true).pop();
                }
              },
            )
          ],
        );
      },
    );
  }



  static showMessage(BuildContext context,String message){
    Flushbar(
      message: message,
      backgroundColor: kPrimaryColor,
      duration:  Duration(seconds: 2),
    )..show(context);
  }

}
