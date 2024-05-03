import 'package:flutter/material.dart';
import 'string_constants.dart';

class AppBarFunction {

  AppBar appBarView(BuildContext context, Color backgroundColor) {
    return MediaQuery.of(context).size.width < 740
        ? AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 80.0,
            backgroundColor: backgroundColor,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Image.asset(ConstantStrings.appBarImageText, width: MediaQuery.of(context).size.width / 2, height: MediaQuery.of(context).size.width / 2,
              ),
            ),
          )
        : AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 80.0,
            backgroundColor: backgroundColor,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Image.asset(ConstantStrings.appBarImageText, width: MediaQuery.of(context).size.width / 4, height: MediaQuery.of(context).size.width / 4,
              ),
            ),
          );
  }
}
