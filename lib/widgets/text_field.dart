import 'package:flutter/material.dart';

buildTextField(
    BuildContext context, TextEditingController controller, String placeHolder,
    {bool obscure = false,
    @required Function(String value)? onChanged,
    TextAlign? textAlign,
    TextInputType? keyboardType}) {
  return Container(
    margin: const EdgeInsets.only(top: 15),
    width: MediaQuery.of(context).size.width * 0.90,
    child: TextField(
      keyboardType: keyboardType ?? TextInputType.text,
      textAlign: textAlign ?? TextAlign.left,
      onChanged: onChanged,
      obscureText: obscure,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20),
        hintText: placeHolder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  );
}
