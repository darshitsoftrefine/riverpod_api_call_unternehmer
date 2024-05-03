import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/themes.dart';
import '../utils/app_bar.dart';
import '../utils/string_constants.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBarFunction().appBarView(context, CustomColor.primaryColors),
      body: SafeArea(
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    MediaQuery.of(context).size.width > 700
                        ? SizedBox(width: MediaQuery.of(context).size.width / 1.9, child: loginCard(),)
                        : loginCard()
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }

  Card loginCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: Colors.white,
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              userFieldAndPasswordField(false, userNameController, ConstantStrings.userNameText),
              const SizedBox(height: 25,),
              userFieldAndPasswordField(true, passwordController, ConstantStrings.passwordText),
              const SizedBox(height: 20,),
              forgotPassword(),
              const SizedBox(height: 20,),
              _showLoginButton(),
              const SizedBox(height: 15,),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField userFieldAndPasswordField(bool obscure, TextEditingController controller, String label) {
    return TextFormField(
      style: CustomTheme.lightTheme().textTheme.displaySmall,
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: label,
        labelStyle: CustomTheme.lightTheme().textTheme.displayMedium,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Colors.black, style: BorderStyle.solid),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: CustomColor.loginButtonColor, width: 1.0,),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: CustomColor.secondaryColor, width: 1.0,),
        ),
      ),
    );
  }

  Container forgotPassword(){
    return Container(
        alignment: Alignment.bottomRight,
        child: Text(ConstantStrings.forgotPasswordText, style: CustomTheme.lightTheme().textTheme.labelSmall?.copyWith(color: CustomColor.loginButtonColor)
        )
    );
  }

  Center _showLoginButton() {
    var customTheme = CustomTheme.lightTheme().textTheme;
    return Center(
        child: ElevatedButton(
          onPressed: () async {
            Get.offAll(() => HomeScreen());
            },
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColor.primaryColors,
            minimumSize: const Size(596, 45),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
                side: const BorderSide(color: CustomColor.loginButtonColor)),
          ),
          child: Text(ConstantStrings.loginButtonText, style: customTheme.displayLarge),
        ));
  }
}