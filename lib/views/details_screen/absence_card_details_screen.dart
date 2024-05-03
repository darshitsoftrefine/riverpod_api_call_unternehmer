import 'package:flutter/material.dart';

import '../../model/tenants_model.dart';
import '../../theme/themes.dart';
import '../../utils/app_bar.dart';
import '../../utils/bottom_nav_bar.dart';
import '../../utils/get_date.dart';
import '../../utils/string_constants.dart';

class AbsenceCardDetailsScreen extends StatelessWidget {
  const AbsenceCardDetailsScreen({super.key, required this.data});

  final TenantsData data;
  @override
  Widget build(BuildContext context) {
    var customTheme = CustomTheme.lightTheme().textTheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBarFunction().appBarView(context, CustomColor.primaryColors),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                sickAndHolidayCardWidget(ConstantStrings.sickReportsText, '${data.subtitle}', "${data.data!.absenceData![ConstantStrings.absenceDataSickText].length}",
                  ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.data!.absenceData![ConstantStrings.absenceDataSickText].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${data.data!.absenceData![ConstantStrings.absenceDataSickText][index][ConstantStrings.absenceDataNameText]}", style: customTheme.headlineMedium),
                              Text(GetTime().calculateTime("${data.data!.absenceData![ConstantStrings.absenceDataSickText][index][ConstantStrings.absenceDataStartDateText]}"), style: customTheme.titleSmall)
                            ],
                          ),
                          const SizedBox(height: 10,),
                        ],
                      );
                    },
                  ),),
                const SizedBox(height: 20,),
                sickAndHolidayCardWidget(ConstantStrings.holidayText, '${data.subtitle}', "${data.data!.absenceData![ConstantStrings.absenceDataHolidayText].length}",
                    ListView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.data!.absenceData![ConstantStrings.absenceDataHolidayText].length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${data.data!.absenceData![ConstantStrings.absenceDataHolidayText][index][ConstantStrings.absenceDataNameText]}", style: customTheme.headlineMedium),
                                Text(GetTime().calculateRemainingDays("${data.data!.absenceData![ConstantStrings.absenceDataHolidayText][index][ConstantStrings.absenceDataEndDateText]}", "${data.data!.absenceData![ConstantStrings.absenceDataHolidayText][index][ConstantStrings.absenceDataStartDateText]}"), style: customTheme.titleSmall)
                              ],
                            ),
                            const SizedBox(height: 10,),
                          ],
                        );
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
        bottomNavigationBar: bottomNavigationBar()
    );
  }

  Center sickAndHolidayCardWidget(String titleText, String subtitleText, String sickNumber, Widget child) {
    var customTheme = CustomTheme.lightTheme().textTheme;
    return Center(
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(20.0),
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Colors.black54),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titleText, style: customTheme.labelMedium),
            Text(subtitleText, style: customTheme.labelSmall),
            const SizedBox(height: 20,),
            SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(sickNumber, style: customTheme.labelLarge,),
                      Text(ConstantStrings.employeesText, style: customTheme.titleMedium?.copyWith(fontSize: 8),)
                    ],
                  ),
                  const SizedBox(width: 25,),
                  Expanded(child: child,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
