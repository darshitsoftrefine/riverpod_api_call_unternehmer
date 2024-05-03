import  'package:flutter/material.dart';
import '../../theme/themes.dart';

  Padding orderAndSalesCardReuseTabletAndWeb(BuildContext context, Function() onTap, EdgeInsetsGeometry padding, EdgeInsetsGeometry titlePadding, String titleText, String subtitleText, String numberText, String secondNumberText, Column triangle) {
    var currentWidth = MediaQuery.of(context).size.width;

    return Padding(padding: const EdgeInsets.only(right: 6.0, left: 6),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: onTap,
                  child:  currentWidth < 740
                      ? SizedBox(
                        width: currentWidth / 2.3,
                        child: orderCardReuse(padding, CrossAxisAlignment.start, titleText, subtitleText, 8.0, EdgeInsets.zero, Alignment.topLeft, numberText, const EdgeInsets.only(left: 5.0), EdgeInsets.zero, MainAxisAlignment.start, secondNumberText, 5.0, triangle)
                  ) : orderCardReuse(padding, CrossAxisAlignment.center, titleText, subtitleText, 14.0, const EdgeInsets.only(left: 10.0), Alignment.bottomRight, numberText, EdgeInsets.zero, const EdgeInsets.only(left: 30.0), MainAxisAlignment.end, secondNumberText, 10.0, triangle)
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

   Column titleCardTabletAndWeb(String titleText, String subtitleText, double subtitleFontSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titleText, overflow: TextOverflow.ellipsis, style: CustomTheme.lightTheme().textTheme.titleLarge),
        Text(subtitleText, style: CustomTheme.lightTheme().textTheme.headlineLarge?.copyWith(overflow: TextOverflow.ellipsis, fontSize: subtitleFontSize),)
      ],
    );
  }

  Card orderCardReuse(EdgeInsetsGeometry padding, CrossAxisAlignment crossAxisAlignment, String titleText, String subtitleText, double fontSize, EdgeInsetsGeometry secondPadding, AlignmentGeometry alignment, String numberText, EdgeInsetsGeometry thirdPadding, EdgeInsetsGeometry fourthPadding, MainAxisAlignment mainAxisAlignment, String secondNumberText, double width, Column triangle) {
    var customTheme = CustomTheme.lightTheme().textTheme;
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)
      ),
      color: Colors.white,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Padding(padding: const EdgeInsets.only(right: 24.0),
              child: titleCardTabletAndWeb(titleText, subtitleText, fontSize),
            ),
            Padding(padding: secondPadding,
              child: Align(
                alignment: alignment,
                child: Text(numberText, overflow: TextOverflow.ellipsis, style: customTheme.bodyMedium),
              ),
            ),
            Padding(
              padding: thirdPadding,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(padding: fourthPadding,
                  child: Row(
                    mainAxisAlignment: mainAxisAlignment,
                    children: [
                      Text(secondNumberText, overflow: TextOverflow.ellipsis, style: customTheme.bodySmall),
                      SizedBox(width: width,),
                      triangle,
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
