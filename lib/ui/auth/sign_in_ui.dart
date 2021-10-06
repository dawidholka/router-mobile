import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:core';
import 'package:get/get.dart';
import 'package:router/ui/components/components.dart';
import 'package:router/helpers/helpers.dart';
import 'package:router/controllers/controllers.dart';

class SignInUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SignInUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FormInputFieldWithIcon(
                    controller: authController.loginController,
                    iconPrefix: Icons.person,
                    labelText: 'auth.loginFormField'.tr,
                    validator: Validator().login,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                    authController.loginController.text = value!,
                  ),
                  FormVerticalSpace(),
                  FormInputFieldWithIcon(
                    controller: authController.passwordController,
                    iconPrefix: Icons.lock,
                    labelText: 'auth.passwordFormField'.tr,
                    validator: Validator().password,
                    obscureText: true,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                    authController.passwordController.text = value!,
                    maxLines: 1,
                  ),
                  FormVerticalSpace(),
                  PrimaryButton(
                      labelText: 'auth.signInButton'.tr,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          authController.signIn(context);
                        }
                      }),
                  FormVerticalSpace(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}