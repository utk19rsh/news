import 'package:flutter/material.dart';

String? validateEmail(String? value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern as String);
  if (value == null) return "Empty email";
  return (regex.hasMatch(value)) ? null : "Invalid email.";
}

push(BuildContext context, Widget destination) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (builder) => destination),
  );
}

pushReplacement(BuildContext context, Widget destination) {
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (builder) => destination),
  );
}

String hideEmail(String value) {
  List<String> arr = value.split("@");
  value = arr[0];
  String result = "";
  if (value.length > 3) {
    result = value.substring(0, 3);
    for (int i = 2; i < value.length; i++) {
      result += "*";
    }
  } else {
    result = value;
  }
  return "$result@${arr[1]}";
}
