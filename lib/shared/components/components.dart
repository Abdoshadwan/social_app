import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/constants/constants.dart';

void navigateto(context, Widget screen) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
void navigatet_close(context, Widget screen) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => screen), (route) => false);

Widget defaulttextfield({
  required TextEditingController controller,
  required String? Function(String?) validator,
  required TextInputType keyboardType,
  VoidCallback? ontp,
  Function(String)? onSubmit,
  Function(String)? onchange,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool obscure = false,
}) =>
    TextFormField(
      cursorWidth: 1,
      obscureText: obscure,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      onFieldSubmitted: onSubmit,
      onChanged: onchange,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: color1, style: BorderStyle.solid)),
        border: UnderlineInputBorder(),
        prefixIconColor: color2,
        suffixIcon: GestureDetector(
          onTap: ontp,
          child: Icon(suffix),
        ),
      ),
    );

Widget defaultbutton(
        {required VoidCallback onpress,
        required String text,
        double w = 100}) =>
    ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(w, 40),
          backgroundColor: color1,
        ),
        onPressed: onpress,
        child: Text(
          '${text.toUpperCase()}',
          style: TextStyle(color: Colors.black),
        ));

void showtost({required String message, required toaststates statuss}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: choosetoastcolor(statuss),
        textColor: Colors.white,
        fontSize: 16);

enum toaststates { success, error, warning }

Color choosetoastcolor(toaststates statuss) {
  switch (statuss) {
    case toaststates.success:
      return Colors.green;
    case toaststates.error:
      return Colors.red;
    case toaststates.warning:
      return Colors.yellow;
  }
}

buttonsNav({
  required VoidCallback press,
  required String text,
  required IconData icona,
  required Color color,
}) =>
    MaterialButton(
        animationDuration: Duration(milliseconds: 800),
        focusElevation: 50,
        hoverElevation: 20,
        minWidth: 40,
        onPressed: press,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icona,
              size: 30,
              color: color,
            ),
            Text(text)
          ],
        ));
