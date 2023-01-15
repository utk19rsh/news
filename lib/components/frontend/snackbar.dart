import 'package:flutter/material.dart';
import 'package:news/constants.dart';

buildSnackBar(BuildContext context, String? snackMsg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('$snackMsg'),
      backgroundColor: black,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(
        milliseconds: 1500,
      ),
      elevation: 0,
      padding: const EdgeInsets.fromLTRB(30, 15, 10, 15),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
