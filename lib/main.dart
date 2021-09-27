import 'package:flutter/material.dart';
import 'package:sales_app/routes/routes.dart';
import 'package:sales_app/shared/constant.dart';
import 'package:sales_app/shared/theme.dart';

void main() {
  runApp(const SalesApp());
}

class SalesApp extends StatelessWidget {
  const SalesApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: defaultTitle,
      theme: theme,
      debugShowCheckedModeBanner: false,
      initialRoute: loginRoute,
      routes: routes,
    );
  }
}
