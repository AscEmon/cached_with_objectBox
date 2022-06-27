import 'package:flutter/material.dart';
import 'package:caching_test/utils/navigation_service.dart';

class ViewUtil {
  static SSLSnackbar(String msg) {
    //Using ScaffoldMessenger we can easily access
//this snackbar from anywhere

    return ScaffoldMessenger.of(Navigation.key.currentContext!).showSnackBar(
      SnackBar(
        content: Text(msg),
        action: SnackBarAction(
          label: '',
          textColor: Colors.transparent,
          onPressed: () {},
        ),
      ),
    );
  }

  static showTransparentDialog(Widget childWidget) {
    showGeneralDialog(
        context: Navigation.key.currentContext!,
        pageBuilder: (BuildContext buildContext, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return SafeArea(child: childWidget);
        },
        barrierDismissible: false,
        barrierLabel: MaterialLocalizations.of(Navigation.key.currentContext!)
            .modalBarrierDismissLabel,
        barrierColor: Colors.grey.withOpacity(0.8),
        transitionDuration: const Duration(milliseconds: 0));
  }

  //this varialble is for internet connection check
  static bool isPresentedDialog = false;
  static showInternetDialog({
    required VoidCallback onPressed,
  }) async {
    // flutter defined function
    await showDialog(
      context: Navigation.key.currentContext!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Connection Error"),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Internet is not available"),
              TextButton(child: Text("Try Again"), onPressed: onPressed),
            ],
          ),
          actions: [
            // usually buttons at the bottom of the dialog
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

// global alert dialog
  static showAlertDialog(
      {String? title,
      required Widget content,
      List<Widget>? actions,
      BorderRadius? borderRadius}) async {
    // flutter defined function
    await showDialog(
      context: Navigation.key.currentContext!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ??
                  BorderRadius.all(
                    Radius.circular(8.0),
                  ),
            ),
            title: title == null ? null : Text(title),
            content: content,
            actions: actions);
      },
    );
  }
}
