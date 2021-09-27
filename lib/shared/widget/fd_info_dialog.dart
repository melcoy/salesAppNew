import 'package:flutter/material.dart';

import '../theme.dart';
import 'fd_button.dart';

class InfoDialog extends StatefulWidget {
  final String message;
  const InfoDialog({Key? key, required this.message}) : super(key: key);
  @override
  _InfoDialogState createState() => _InfoDialogState(message);
}

class _InfoDialogState extends State<InfoDialog> {
  String message;

  _InfoDialogState(this.message);
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: defaultRadius,
      ),
      contentPadding: const EdgeInsets.all(16),
      children: <Widget>[
        const Icon(Icons.pin_drop),
        const SizedBox(height: 8),
        // Text(
        //   message.toString(),
        //   textAlign: TextAlign.center,
        //   style: const TextStyle(
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        const SizedBox(height: 16),
        const SizedBox(
          width: double.infinity,
          child: Divider(
            color: primaryColor,
            thickness: 4.5,
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Container(
            child: Text(
              message.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        FDButton(
          onPressed: () {
            Navigator.pop(context);
          },
          text: "Back",
        ),
      ],
    );
  }
}
