import 'package:expandable/expandable.dart';

import 'package:flutter/material.dart';
import 'package:sales_app/shared/theme.dart';

class FDSquareTextfield extends StatefulWidget {
  final Widget label;
  final bool typeKeyboard;
  final int maxLine;
  final Color? color;
  final TextEditingController? controller;
  final bool? emailText;
  final bool readOnly;
  final void Function()? onTap;

  const FDSquareTextfield(
      {required this.label,
      required this.readOnly,
      required this.maxLine,
      this.color,
      this.controller,
      required this.typeKeyboard,
      this.emailText,
      this.onTap});

  @override
  _FDSquareTextfieldState createState() => _FDSquareTextfieldState();
}

class _FDSquareTextfieldState extends State<FDSquareTextfield> {
  @override
  Widget build(BuildContext context) {
    final BorderSide borderSide = BorderSide(
      color: widget.color ?? Theme.of(context).primaryColor,
    );

    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          constraints: const BoxConstraints(
            minWidth: 120,
          ),
          decoration: BoxDecoration(
            color: widget.color ?? Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: defaultRadiusValue,
              topRight: defaultRadiusValue,
            ),
          ),
          child: widget.label,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border(
              left: borderSide,
              top: borderSide,
              right: borderSide,
              bottom: borderSide,
            ),
          ),
          child: TextFormField(
            onTap: widget.onTap,
            readOnly: widget.readOnly,
            controller: widget.controller,
            maxLines: widget.maxLine,
            keyboardType: widget.typeKeyboard == true
                ? TextInputType.number
                : TextInputType.text,
            validator: (value) {
              if (widget.emailText == true) {
                if (value == null || value.isEmpty || !value.isValidEmail()) {
                  return 'Empty Emiail';
                }
                return null;
              } else {
                if (value == null || value.isEmpty) {
                  return 'Enter Field';
                }
              }
              return null;
            },
            decoration: const InputDecoration(
                border: InputBorder.none,
                labelStyle: TextStyle(fontSize: 14.0),
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 10.0,
                )),
          ),
        ),
        const SizedBox(),
      ],
    ));
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
