import 'package:flutter/material.dart';
import 'package:tripleuglobal/components/text_field_container.dart';
import 'package:tripleuglobal/constants/constant_color.dart';


class RoundedInputField extends StatelessWidget {
  final String hintText;
  final TextInputType? textInputType;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.textInputType,
    this.icon = Icons.email,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        keyboardType:textInputType ,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}