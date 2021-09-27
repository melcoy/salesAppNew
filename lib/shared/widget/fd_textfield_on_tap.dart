import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sales_app/shared/constant.dart';

import '../size_config.dart';
import '../theme.dart';

class FDTextFieldOnTap extends StatefulWidget {
  TextEditingController? controller;
  final String? placeholder;
  final IconData? prefixIcon;
  final String title;
  final String route;
  void Function()? onTapCheck;

  FDTextFieldOnTap({
    Key? key,
    this.placeholder,
    this.controller,
    this.prefixIcon,
    required this.route,
    required this.title,
  }) : super(key: key);

  @override
  _FDTextFieldOnTapState createState() => _FDTextFieldOnTapState();
}

class _FDTextFieldOnTapState extends State<FDTextFieldOnTap> {
  @override
  void initState() {
    super.initState();
    widget.controller!.text = "Choose Customer";
  }

  @override
  Widget build(BuildContext context) {
    DateTime? pickedDate = DateTime.now();
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: SizeConfig.blockHorizontal * 3),
          child: Text(
            widget.title,
            style: TextStyle(
                fontSize: SizeConfig.blockVertical * 2,
                fontWeight: FontWeight.bold,
                color: primaryColor),
          ),
        ),
        TextFormField(
          controller: widget.controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Value';
            }
          },
          onTap: () async => {},
          decoration: InputDecoration(
            filled: true,
            hintText: widget.placeholder,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
            ),
            // contentPadding: const EdgeInsets.symmetric(
            //   horizontal: 24,
            // ),
            fillColor: Colors.transparent,
            prefixIcon: Icon(
              widget.prefixIcon,
              color: Theme.of(context).primaryColor,
            ),
            focusColor: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
