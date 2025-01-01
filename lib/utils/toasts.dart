import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Message {
  static void show(
      {String message = "Done!",
      ToastGravity gravity = ToastGravity.BOTTOM,
      int time = 1,
      Color backgroudColor = const Color.fromARGB(255, 4, 102, 50),
      Color textColor = Colors.white,
      double fontSize = 16}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroudColor,
        textColor: textColor,
        fontSize: fontSize);
  }
}
