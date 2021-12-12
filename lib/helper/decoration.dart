import 'package:flutter/material.dart';
import 'package:tripleuglobal/constants/string_constants.dart';

class ViewDecoration{

  static InputDecoration textFiledDecoration(String fieldname) {
    return InputDecoration(
        isDense: true,
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 8),
        filled: true,
        hintStyle: new TextStyle(color: Colors.grey[800]),
        hintText: fieldname,
        fillColor: Colors.white70);
  }

  static TextStyle textFieldStyle() {
    return TextStyle(
        color: Colors.black,
        fontFamily: StringConstants.roboto,
        fontWeight: FontWeight.w400,
        fontSize: 16);
  }

  static TextStyle textStyleRegular(Color color,double textsize) {
    return TextStyle(
        color: color,
        fontFamily: StringConstants.roboto,
        fontWeight: FontWeight.w400,
        fontSize: textsize);
  }
  static TextStyle textStyleBold(Color color,double textsize) {
    return TextStyle(
        color: color,
        fontFamily: StringConstants.roboto,
        fontWeight: FontWeight.w700,
        fontSize: textsize);
  }

  static Widget buildCustomPrefixIcon(IconData iconData) {
    return Container(
      width: 0,
      alignment: Alignment(-0.99, 0.0),
      child: Icon(
        iconData,
      ),
    );
  }
}