import 'package:flutter/material.dart';
import 'package:hemura/utils/enums/text_field_type.dart';

class MyTextformfield extends StatefulWidget {
  const MyTextformfield({
    required this.label,
    required this.editingController,
    required this.type,
    super.key,
  });

  final String label;
  final TextEditingController editingController;
  final TextFieldType type;

  @override
  State<MyTextformfield> createState() => _MyTextformfieldState();
}

class _MyTextformfieldState extends State<MyTextformfield> {
  bool isVisible = false;

  void changeVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  String? _validateField(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo ${widget.label} é obrigatório';
    }
    switch (widget.type) {
      case TextFieldType.email:
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(value)) return 'E-mail inválido';
        break;
      case TextFieldType.password:
        if (value.length < 8) return 'A senha deve ter pelo menos 6 caracteres';
        break;
      case TextFieldType.text:
        if (value.length < 3) return 'Mínimo de 3 caracteres';
        break;
      case TextFieldType.phone:
        final phoneRegex = RegExp(r'^\d{10,11}$');
        if (!phoneRegex.hasMatch(value)) return 'Telefone inválido';
        break;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.editingController,
      obscureText: widget.type == TextFieldType.password && !isVisible,
      validator: _validateField,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon:
            widget.type == TextFieldType.password
                ? IconButton(
                  icon:
                      isVisible
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                  onPressed: changeVisibility,
                )
                : null,
      ),
    );
  }
}
