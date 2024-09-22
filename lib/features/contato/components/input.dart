import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  final String? hint;
  final String? Function(String?)? validator;
  final TextStyle? hintStyle;
  final void Function(String)? onChanged;
  final Text? label;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  const Input({super.key, this.label, this.hint, this.hintStyle, this.validator, this.onChanged, this.controller, this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      style: const TextStyle(fontSize: 20, color: Colors.white),
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontSize: 15, overflow: TextOverflow.clip),
        errorMaxLines: 2,
        // errorStyle: TextStyle(color: Colors.black),
        border: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        disabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        label: label,
        hintStyle: hintStyle ?? TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(.5)),
        labelStyle: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
