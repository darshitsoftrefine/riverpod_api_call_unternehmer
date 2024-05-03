import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/chart_data.dart';
import '../../model/tenants_model.dart';
import '../../theme/themes.dart';
import '../../utils/string_constants.dart';
import '../../views/details_screen/details_screen.dart';

Padding pieChartViewWidget(BuildContext context, TenantsData data, EdgeInsetsGeometry padding, BoxConstraints boxConstraintsText, BoxConstraints boxConstraintsPieChart){
  var screenWidth = MediaQuery.of(context).size.width;

  return Padding(
    padding: const EdgeInsets.only(right: 6.0, left: 6.0),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Column(
            children: [
              GestureDetector(
                  onTap: () {Get.to(() => DetailsScreen(data: data,), transition: Transition.downToUp);},
                  child:  screenWidth < 740 ? SizedBox(
                      width: screenWidth / 2.3,
                      child: topArticleViewReuse(padding, boxConstraintsText, '${data.title}', '${data.subtitle}', 8.0, boxConstraintsPieChart, 9.0, data.data?.articles),
                  ) : topArticleViewReuse(const EdgeInsets.only(left: 10.0, right: 8.0, top: 5.0, bottom: 4.0), boxConstraintsText, '${data.title}', '${data.subtitle}', 14.0, boxConstraintsPieChart, 12.0, data.data?.articles),
              ),
              const SizedBox(height: 10,)
            ],
          ),
        ],
      ),
    ),
  );
}

SfCircularChart topArticlesPieChart(double fontSize, data) {
  var customTheme = CustomTheme.lightTheme().textTheme;
  List<ChartData> list = <ChartData>[];
  List<Color> colors = [CustomColor.primaryColors, Colors.black, CustomColor.secondaryColor, CustomColor.loginButtonColor, Colors.brown];
  var currency = "";
  for (var i = 0; i < data.length; i++) {
    currency = data[i].currency;
    list.add(ChartData(data[i].name, double.parse(data[i].amount.toString()), data[i].currency, colors[i]));
  }

  return SfCircularChart(
    annotations: <CircularChartAnnotation>[
      CircularChartAnnotation(
        widget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(ConstantStrings.orderScanText, style: customTheme.displaySmall?.copyWith(fontSize: 4),),
            Text('${getSum(data).toString()} $currency', style: customTheme.displaySmall?.copyWith(fontSize: 4),),
          ]),
      )
    ],
    legend: Legend(
        padding: 10,
        itemPadding: 3.0,
        isVisible: true,
        textStyle: customTheme.displaySmall?.copyWith(fontSize: fontSize),
        iconHeight: 5,
        iconWidth: 5,
        position: LegendPosition.left),
    series: <CircularSeries>[
      DoughnutSeries<ChartData, String>(
          dataSource: list,
          xValueMapper: (ChartData data, _) => data.name,
          yValueMapper: (ChartData data, _) => data.amount,
          pointColorMapper: (ChartData data, _) => data.color,
          strokeColor: Colors.white,
          legendIconType: LegendIconType.circle,
          radius: '120%',
          innerRadius: '60%',
          explode: true,
          explodeIndex: null,
          explodeOffset: "0.5%",
          explodeAll: true)
    ],
  );
}

double getSum(data) {
  double sums = 0.00;
  for (int i = 0; i < data.length; i++) {
    sums = sums + double.parse(data[i].amount.toString());
  }
  return sums;
}

Card topArticleViewReuse(EdgeInsetsGeometry padding, BoxConstraints constraints, String title, String subtitle, double subtitleFontSize, BoxConstraints pieChartConstraints, double fontSize, dynamic data) {
  var customTheme = CustomTheme.lightTheme().textTheme;
  return Card(
    elevation: 0.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    color: Colors.white,
    child: Padding(padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: constraints,
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 8.0, top: 5.0, bottom: 1.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(title, overflow: TextOverflow.ellipsis, style: customTheme.titleLarge),
                    Text(subtitle, style: customTheme.headlineLarge?.copyWith(overflow: TextOverflow.ellipsis, fontSize: subtitleFontSize))
                  ],
                ),
              ),
            ),
          ),
          Container(
            constraints: pieChartConstraints,
            child: topArticlesPieChart(fontSize, data),
          ),
          const SizedBox(height: 10,)
        ],
      ),
    ),
  );
}