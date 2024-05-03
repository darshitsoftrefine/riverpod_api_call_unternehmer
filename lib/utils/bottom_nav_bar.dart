import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/themes.dart';
import 'string_constants.dart';


  GestureDetector bottomNavigationBar() {
    return GestureDetector(
      onTap: () {Get.back();},
      child: Container(
        width: 50,
        height: 60,
        decoration: const BoxDecoration(color: CustomColor.primaryColors,),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 18.0, top: 5.0),
          child: Center(
            child: Text(ConstantStrings.backButtonText,style: CustomTheme.lightTheme().textTheme.labelMedium),
          ),
        ),
      ),
    );
}