import 'package:flutter/material.dart';

class Dialogs {
  static Future<bool> showConfirmationDialog({
    required BuildContext context, 
    required String title, 
    required String subtitle, 
    String trueText = "Yes",
    String falseText = "No",
  }) async {
    bool? confirm;
    confirm = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
        title: Text(title),
        content: Text(subtitle),
        actions: [
          TextButton(
            child: Text(trueText, style: TextStyle(color: Colors.black),),
            onPressed: () => Navigator.of(context).pop(true), 
          ),
          TextButton(
            child: Text(falseText, style: TextStyle(color: Colors.black),),
            onPressed: () => Navigator.of(context).pop(false), 
          ),
        ],
      ),
    );
    return Future.value(confirm??false);
  } 
}