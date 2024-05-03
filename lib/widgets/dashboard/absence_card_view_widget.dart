import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/tenants_model.dart';
import '../../theme/themes.dart';
import '../../utils/string_constants.dart';
import '../../views/details_screen/absence_card_details_screen.dart';

Padding absenceCardView(BuildContext context, TenantsData data, EdgeInsetsGeometry screenSizePadding) {
  var screenWidth = MediaQuery.of(context).size.width;

  return Padding(padding: const EdgeInsets.only(right: 6.0, left: 6.0, bottom: 10.0),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => AbsenceCardDetailsScreen(data: data), transition: Transition.downToUp);
              },
            child: screenWidth < 740
                ? SizedBox(
                  width: screenWidth / 2.3,
                  child: absenceCardReuse(screenSizePadding, '${data.title}', '${data.subtitle}', 8.0,
                      data.data!.absenceData![ConstantStrings.absenceDataSickText].length,
                      data.data!.absenceData![ConstantStrings.absenceDataHolidayText].length, 10.0, 40.0, 20.0)
                )
                : absenceCardReuse(screenSizePadding, '${data.title}', '${data.subtitle}', 14.0,
                data.data!.absenceData![ConstantStrings.absenceDataSickText].length,
                data.data!.absenceData![ConstantStrings.absenceDataHolidayText].length, 14.0, 70.0, 30.0)
          )
        ]),
    )
  );
  }

  Card absenceCardReuse(EdgeInsetsGeometry screenSizePadding, String title, String subtitle, double subtitleFontSize, int absenceCount, int holidayCount, double fontSize, double width, double width2) {
    var customTheme = CustomTheme.lightTheme().textTheme;
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
      color: Colors.white,
      child: Padding(
        padding: screenSizePadding,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: customTheme.titleLarge, overflow: TextOverflow.ellipsis),
                    Text(subtitle, style: customTheme.headlineLarge?.copyWith(fontSize: subtitleFontSize),),
                    Padding(padding: const EdgeInsets.only(left: 5.0),
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(absenceCount.toString(), style: customTheme.bodyLarge,),
                                  Text(ConstantStrings.sickText, style: customTheme.titleSmall!.copyWith(fontSize: fontSize))
                                ]),
                            holidayCount < 10 ? SizedBox(width: width,) : SizedBox(width: width2),
                            Column(
                                children: [
                                  Text(holidayCount.toString(), style: customTheme.bodyLarge,),
                                  Text(ConstantStrings.holidayText, style: customTheme.titleSmall!.copyWith(fontSize: fontSize)),
                                ])
                          ]),
                    )
                  ]),
            ]),
      ),
    );
  }
