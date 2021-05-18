import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableWidgets{

  TextFormField textFormField(String labelText,
      bool isObscureText,
      TextInputType textInputType){
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return "This field can't be empty.";
        }
        if (value.length < 10) {
          return "Your password is too short!";
        }
        return null;
      },
      keyboardType: textInputType,
      style: GoogleFonts.montserrat(
          fontSize: 18
      ),
      cursorColor: Colors.black12,
      cursorWidth: 1,
      obscureText: isObscureText,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black87, width: 2.0),
          ),
          border: const OutlineInputBorder(),
          labelText: labelText,
          labelStyle: GoogleFonts.montserrat(
              color: Colors.black.withOpacity(0.6)
          )
      ),
    );
  }

  ElevatedButton elevatedButton(Function function, String outlineButtonText){
    return ElevatedButton(
        onPressed: function,
        child: Text(outlineButtonText, style: GoogleFonts.montserrat(
          fontSize: 20,
          color: Colors.black87
        )),
    );
  }

}