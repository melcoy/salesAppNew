import 'package:expandable/expandable.dart';

import 'package:flutter/material.dart';
import 'package:sales_app/shared/theme.dart';

import '../size_config.dart';

class FDBoxField extends StatefulWidget {
  final Widget label;
  final String? contains;
  final int maxLine;
  final Color? color;

  final TextEditingController? controller;
  final String? route;

  const FDBoxField(
      {required this.label,
      required this.maxLine,
      this.color,
      this.controller,
      this.route,
      this.contains});

  @override
  _FDBoxFieldState createState() => _FDBoxFieldState();
}

class _FDBoxFieldState extends State<FDBoxField> {
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
            child: Card(
              elevation: 5,
              child: ListTile(
                title: Container(
                  height: SizeConfig.blockVertical * 4,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: widget.contains == ""
                      ? Text(
                          "Choose Your Address",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  color: primaryColor,
                                  fontSize: SizeConfig.blockVertical * 1.5,
                                  fontWeight: FontWeight.bold),
                        )
                      : Text(
                          widget.contains ?? "Choose Your Address",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  color: primaryColor,
                                  fontSize: SizeConfig.blockVertical * 1.5,
                                  fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            )),
        const SizedBox(),
      ],
    ));
  }
}
