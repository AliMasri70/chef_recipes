import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Flushbar<dynamic> FlushBarWidget(String title, String msg) {
  return Flushbar(
    title: "$title",
    message: "$msg",
    duration: Duration(seconds: 3),
    backgroundColor: Color.fromRGBO(69, 90, 100, 1),
    flushbarStyle: FlushbarStyle.FLOATING,
    borderRadius: BorderRadius.circular(25),
    //padding: EdgeInsets.symmetric(vertical: 10),
    margin: EdgeInsets.only(left: 10, right: 10),
    icon: Icon(
      Icons.info_outline,
      color: Colors.red,
    ),
    // leftBarIndicatorColor: Colors.blueGrey[300],
  );
}
