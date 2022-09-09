import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextButton(
        {required String? text, required VoidCallback? onPressed}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text.toString(),
      ),
    );

Widget defaultMaterialButton({
  required VoidCallback onPressed,
  required String text,
}) =>
    MaterialButton(
      onPressed: onPressed,
      color: Colors.blue,
      minWidth: double.infinity,
      child: Text(
        text.toString(),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      height: 50,
    );

Widget defaultTextFormFeild({
  required TextEditingController controller,
  required ValueChanged? submitted,
  required FormFieldValidator? validator,
  required String? lapel,
  Icon? suffixIcon,
  Icon? prefixIcon,
  TextInputType? keyboardType,
}) =>
    TextFormField(
      controller: controller,
      validator: validator,
      onFieldSubmitted: submitted,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        label: Text(
          lapel.toString(),
        ),
        border: OutlineInputBorder(),
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

void showToast({
  required String message,
  required ToastStates toastState,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: choseColorToast(toastState),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { ERROR, SUCCESS, WARNING }

Color choseColorToast(ToastStates state) {
  Color? color;

  switch (state) {
    case ToastStates.ERROR:
      color = Colors.red;
      break;

    case ToastStates.SUCCESS:
      color = Colors.blue;
      break;

    case ToastStates.WARNING:
      color = Colors.amberAccent;
      break;
  }

  return color;
}
