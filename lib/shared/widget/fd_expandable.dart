import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class FDExpandable extends StatelessWidget {
  final Widget label;
  final Widget title;
  final List<Widget>? children;
  final Color? color;

  FDExpandable({
    Key? key,
    required this.label,
    required this.title,
    this.children,
    this.color,
  }) : super(key: key);

  final ExpandableController _expandableController =
      ExpandableController(initialExpanded: false);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      controller: _expandableController,
      child: FDRootExpandable(
        label: label,
        title: title,
        key: key,
        controller: _expandableController,
        color: color,
        children: children,
      ),
    );
  }
}

class FDRootExpandable extends StatefulWidget {
  final Widget label;
  final Widget title;
  final List<Widget>? children;
  final Color? color;
  final ExpandableController controller;

  const FDRootExpandable({
    Key? key,
    required this.label,
    required this.title,
    required this.controller,
    this.children,
    this.color,
  }) : super(key: key);

  @override
  _FDRootExpandableState createState() => _FDRootExpandableState();
}

class _FDRootExpandableState extends State<FDRootExpandable> {
  @override
  Widget build(BuildContext context) {
    final BorderSide borderSide = BorderSide(
      color: widget.color ?? Theme.of(context).primaryColor,
    );
    return Column(
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
        Expandable(
          collapsed: _buildExpandableHeader(context),
          expanded: Column(
            children: <Widget>[
              _buildExpandableHeader(context),
              if (widget.children != null)
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: borderSide,
                      left: borderSide,
                      right: borderSide,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.children!
                        .map(
                          (Widget child) => Padding(
                            padding: const EdgeInsets.all(8),
                            child: child,
                          ),
                        )
                        .toList(),
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpandableHeader(BuildContext context) {
    final BorderSide borderSide = BorderSide(
      color: widget.color ?? Theme.of(context).primaryColor,
    );

    return ExpandableButton(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border(
            left: borderSide,
            top: borderSide,
            right: borderSide,
            bottom: ExpandableController.of(context)!.expanded &&
                    widget.children != null
                ? BorderSide.none
                : borderSide,
          ),
          // border: Border.all(
          //   color: widget.color ?? Theme.of(context).primaryColor,
          // ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            widget.title,
            Icon(
              ExpandableController.of(context)!.expanded
                  ? Icons.horizontal_rule
                  : Icons.add,
              color: widget.color ?? Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
