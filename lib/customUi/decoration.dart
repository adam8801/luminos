import 'package:flutter/material.dart';

BoxDecoration boxDecoration(Color forcolor, double radius, Color borcolor, double width, Color shwcolor) {
  return BoxDecoration(
    color: forcolor,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: borcolor,width: width),
    boxShadow: [
      BoxShadow(
        color: shwcolor.withOpacity(0.7),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3),
      ),
    ],
  );
}

showAlertDialog(BuildContext context, String label) {
  AlertDialog alert = AlertDialog(
    title: Text("ALERT"),
    content: Text(label),
    actions: [
      FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("ok")
      )
    ],
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      }
  );
}

InputDecoration textFormDecoration(String labelText, String helperText,IconData icon) {
  return InputDecoration(
    labelText: labelText,
    helperText: helperText,
    helperStyle: TextStyle(color: Colors.red, fontSize: 12),
    border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
        )
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue[900],
          width: 2,
        )
    ),
    prefixIcon: Icon(icon, color: Colors.blue[900],),
  );
}