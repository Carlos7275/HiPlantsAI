import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  const InputText(
      {super.key,
      required this.controller,
      required this.callback,
      required this.message,
      this.message2,
      this.icon,
      this.obscure = false});

  final TextEditingController controller;
  final bool obscure;
  final String? Function(String?) callback;
  final Icon? icon;
  final String? message, message2;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: callback,
      controller: controller,
      cursorColor: Colors.black,
      obscureText: obscure,
      style: const TextStyle(fontSize: 12),
      decoration: InputDecoration(
          alignLabelWithHint: true,
          border: const UnderlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          fillColor: Colors.white,
          filled: true,
          labelText: message,
          hintText: message2,
          prefixIcon: icon),
    );
  }
}
