import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_app/api/auth/auth_repo.dart';
import 'package:sales_app/bloc/auth/bloc/auth_bloc.dart';
import 'package:sales_app/shared/constant.dart';
import 'package:sales_app/shared/theme.dart';

import 'package:sales_app/shared/widget/fd_button.dart';
import 'package:sales_app/shared/widget/fd_info_dialog.dart';
import 'package:sales_app/shared/widget/fd_loading_dialog.dart';
import 'package:sales_app/shared/widget/fd_textfield.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: "");
  final TextEditingController _passwordController =
      TextEditingController(text: "");
  final ApiLoginRepo _apiLoginRepo = ApiLoginRepo();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.of(context).pushReplacementNamed(dashboardRoute);
            }
            if (state is AuthFailure) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return InfoDialog(
                    message: state.errorMessage,
                  );
                },
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 32),
                      const Text(
                        "Login Sales",
                        style: TextStyle(fontSize: 36.0),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      const Divider(
                        color: primaryColor,
                        thickness: 4.5,
                      ),
                      const SizedBox(height: 32),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            FDTextField(
                              placeholder: "Email",
                              controller: _emailController,
                              prefixIcon: Icons.person_rounded,
                              emailText: true,
                            ),
                            const SizedBox(height: 16),
                            FDTextField(
                              placeholder: "Password",
                              controller: _passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              prefixIcon: Icons.lock,
                            ),
                            const SizedBox(height: 16),
                            if (state is AuthLoading)
                              const Center(
                                child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        primaryColor)),
                              )
                            else
                              FDButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _emailController.text = "james@gmail.com";
                                    _passwordController.text = "a";
                                    BlocProvider.of<AuthBloc>(context).add(
                                      LoginButtonPressed(
                                          email: _emailController.text,
                                          password: _passwordController.text),
                                    );
                                  }
                                },
                                text: "Login",
                                textColor: Colors.white,
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
