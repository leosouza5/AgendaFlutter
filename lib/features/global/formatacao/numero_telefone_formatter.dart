import 'package:flutter/services.dart';

class TelefoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    final String textoFormatado = aplicarMascaraTelefone(newValue.text);

    return TextEditingValue(
      text: textoFormatado,
      selection: TextSelection.collapsed(offset: textoFormatado.length),
    );
  }
}

String aplicarMascaraTelefone(String input) {
  String textoLimpo = input.replaceAll(RegExp(r'\D'), '');

  if (textoLimpo.length > 11) {
    textoLimpo = textoLimpo.substring(0, 11);
  }

  String textoFormatado = textoLimpo;

  if (textoLimpo.length >= 2) {
    textoFormatado = '(${textoLimpo.substring(0, 2)})';
  }
  if (textoLimpo.length > 2) {
    textoFormatado += ' ${textoLimpo.substring(2, 3)}';
  }
  if (textoLimpo.length > 3) {
    textoFormatado += textoLimpo.substring(3, 7);
  }
  if (textoLimpo.length > 7) {
    textoFormatado += '-${textoLimpo.substring(7, 11)}';
  }

  return textoFormatado;
}
