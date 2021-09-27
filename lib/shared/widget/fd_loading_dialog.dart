import 'package:flutter/material.dart';

import 'package:sales_app/shared/theme.dart';

class LoadingDialog extends StatefulWidget {
  final String message;
  const LoadingDialog({Key? key, required this.message}) : super(key: key);

  @override
  _LoadingDialogState createState() => _LoadingDialogState(message);
}

class _LoadingDialogState extends State<LoadingDialog> {
  String message;

  _LoadingDialogState(this.message);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SimpleDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: defaultRadius,
        ),
        contentPadding: const EdgeInsets.all(16),
        children: <Widget>[
          const Icon(Icons.pin_drop),
          const SizedBox(height: 8),
          Text(
            message.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const SizedBox(
            width: double.infinity,
            child: Divider(
              color: primaryColor,
              thickness: 4.5,
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
