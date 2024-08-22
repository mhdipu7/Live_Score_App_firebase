import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toastShow(String text, Color color, Color textColor) => Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: textColor,
      fontSize: 16.0,
    );
