import 'package:flutter/material.dart';

import '../theme.dart';

class FDTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final bool? emailText;

  const FDTextField(
      {this.placeholder,
      this.controller,
      this.prefixIcon,
      this.keyboardType,
      this.obscureText,
      this.emailText});

  @override
  _FDTextFieldState createState() => _FDTextFieldState();
}

class _FDTextFieldState extends State<FDTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        if (widget.obscureText == null && widget.emailText != null) {
          if (value == null || value.isEmpty || !value.isValidEmail()) {
            return 'Enter Correct Email ';
          }
        } else if (widget.obscureText == null && widget.emailText == null) {
          if (value == null || value.isEmpty) {
            return 'Enter Field ';
          }
        } else {
          if (value == null || value.isEmpty) {
            return 'Enter Password';
          }
        }
      },
      keyboardType: widget.keyboardType ?? TextInputType.text,
      obscureText: widget.obscureText ?? false,
      decoration: InputDecoration(
        filled: true,
        hintText: widget.placeholder,
        focusedBorder: OutlineInputBorder(
          borderRadius: circularRadius,
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        border: const OutlineInputBorder(
          borderRadius: circularRadius,
        ),
        prefixIcon: Icon(
          widget.prefixIcon,
          color: Theme.of(context).primaryColor,
        ),
        focusColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
