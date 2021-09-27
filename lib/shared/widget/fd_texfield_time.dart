import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../size_config.dart';
import '../theme.dart';

class FDTextFieldTime extends StatefulWidget {
  TextEditingController? controller;
  final String? placeholder;
  final IconData? prefixIcon;
  final String title;

  void Function()? onTapCheck;

  FDTextFieldTime({
    Key? key,
    this.placeholder,
    this.controller,
    this.prefixIcon,
    required this.title,
  }) : super(key: key);

  @override
  _FDTextFieldTimeState createState() => _FDTextFieldTimeState();
}

class _FDTextFieldTimeState extends State<FDTextFieldTime> {
  @override
  void initState() {
    super.initState();
    widget.controller!.text =
        "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}";
  }

  @override
  Widget build(BuildContext context) {
    TimeOfDay? time = TimeOfDay.now();
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
          readOnly: true,
          controller: widget.controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Time';
            }
          },
          onTap: () async => {
            time = (await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            )),
            if (time != null)
              {
                widget.controller!.text = "${time!.hour}:${time!.minute}",
              }
          },
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
