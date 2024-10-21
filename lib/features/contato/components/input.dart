import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatefulWidget {
  final String? hint;
  final String? Function(String?)? validator;
  final TextStyle? hintStyle;
  final void Function(String)? onChanged;
  final Text? label;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final bool senha;
  const Input({super.key, this.label, this.hint, this.hintStyle, this.validator, this.onChanged, this.controller, this.inputFormatters, this.senha = false});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.senha,
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      onChanged: widget.onChanged,
      validator: widget.validator,
      style: const TextStyle(fontSize: 20, color: Colors.white),
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontSize: 15, overflow: TextOverflow.clip),
        errorMaxLines: 2,
        // errorStyle: TextStyle(color: Colors.black),
        border: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        disabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: widget.hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        label: widget.label,
        hintStyle: widget.hintStyle ?? TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(.5)),
        labelStyle: const TextStyle(fontSize: 20, color: Colors.white),
        suffixIcon: widget.senha
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
                icon: Icon(
                  obscure ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ))
            : null,
      ),
    );
  }
}
