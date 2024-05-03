import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/themes.dart';
import '../../utils/string_constants.dart';
import '../../views/details_screen/business_account_details_screen.dart';

  Padding businessAccountCardView(BuildContext context, EdgeInsetsGeometry padding, double minWidth, double maxWidth, double minHeight, double maxHeight,) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 6.0, bottom: 10),
      child: GestureDetector(
        onTap: (){
          Get.to(() =>  BusinessAccountDetailsScreen(), transition: Transition.downToUp);
          },
        child: screenWidth < 740
            ? SizedBox(
              width: screenWidth / 1.11,
              child: Card(
                elevation: 0.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                color: Colors.white,
                child: Padding(padding: padding,
                  child: descriptionReuse(),
                ),
              ))
            : Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
              color: Colors.white,
              child: Padding(padding: padding,
                child: Container(
                  constraints: BoxConstraints(minWidth: minWidth, maxWidth: maxWidth, minHeight: minHeight, maxHeight: maxHeight),
                  child: descriptionReuse(),
                ),
              ),
            )
      ),
    );
  }

  Row descriptionReuse() {
    var customTheme = CustomTheme.lightTheme().textTheme;
    return Row(children: [
      Stack(
        children: [
          const Align(
            alignment: Alignment.centerRight,
            child: SizedBox(width: 80, height: 80,
              child: CircleAvatar(backgroundColor: CustomColor.primaryColors),
            ),
          ),
          const Positioned(top: 12, right: 20, left: 18,
            child: SizedBox(width: 15, height: 10,
                child: CircleAvatar(backgroundColor: Colors.white)),
          ),
          Positioned(top: 15, right: 15, left: 25,
            child: Text("S", style: customTheme.headlineSmall?.copyWith(fontSize: 40.0)),
          ),
        ],
      ),
      Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    children: [
                      const Icon(Icons.home, color: Colors.black),
                      Text(ConstantStrings.holsteinGiroBusinessText, overflow: TextOverflow.ellipsis, style: customTheme.displaySmall)
                    ]),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ConstantStrings.businessAccountNumberText, style: customTheme.titleMedium),
                        Text("66.747,14 \u{20AC}", style: customTheme.titleLarge?.copyWith(fontSize: 20, fontWeight: FontWeight.w500)),
                        Text(ConstantStrings.lastUpdatedText, style: customTheme.titleMedium?.copyWith(fontSize: 8))
                      ]),
                ),
              ]),
        ),
      ),
    ]);
  }