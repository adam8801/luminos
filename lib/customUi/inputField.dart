import 'package:flutter/material.dart';

Widget inputField(BuildContext context, Decoration decoration, String label, String helper, TextEditingController controller, int val, IconData icon) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      width: MediaQuery.of(context).size.width,
      decoration: decoration,
      child: TextFormField(
        maxLengthEnforced: true,
        maxLength: val,
        controller: controller,
        validator: (value) {
          if(value.isEmpty){
            return "Field can't be empty";
          }
          return null;
        },
        maxLines: null,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: label,
          helperText: helper,
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
        ),
      )
  );
}

Widget inputField1(BuildContext context, String label, String helper, TextEditingController controller, int val, IconData icon) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white,width: 8),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.7),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        maxLengthEnforced: true,
        maxLength: val,
        controller: controller,
        validator: (value) {
          if(value.isEmpty){
            return "Field can't be empty";
          }
          return null;
        },
        maxLines: null,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: label,
          helperText: helper,
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
        ),
      )
  );
}