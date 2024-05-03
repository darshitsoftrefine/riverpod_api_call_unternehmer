import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/chart_data.dart';
import '../theme/themes.dart';
import '../views/details_screen/order_card_details.dart';
import '../views/details_screen/sales_details_screen.dart';
import 'dashboard/absence_card_view_widget.dart';
import 'dashboard/business_account_card_view_widget.dart';
import 'dashboard/order_sales_card_view_widget.dart';
import '../utils/string_constants.dart';
import '../utils/triangle_painter.dart';
import 'dashboard/sales_pipeline_bar_chart_card_view_widget.dart';
import 'dashboard/top_article_pie_chart_card_view_widget.dart';

class CustomWidgets {

  Builder orderCardWidget(String orderNumberText, String secondNumberText, String price, Color color, String direction, String subtitleText) {
    var mobilePadding = const EdgeInsets.only(top: 12, right: 5, left: 10, bottom: 18);
    var tabletPadding = const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 15);
    var webPadding = const EdgeInsets.only(top: 12, right: 10, left: 15, bottom: 18);
    return Builder(builder: (context) {
      return MediaQuery.of(context).size.width < 740
          ? orderAndSalesCardReuseTabletAndWeb(context, () {Get.to(() => const OrderCardDetailsScreen(), transition: Transition.downToUp);}, mobilePadding, const EdgeInsets.only(right: 24.0), ConstantStrings.orderReceiptText, subtitleText, orderNumberText, secondNumberText, triangle(color, direction, 8, CrossAxisAlignment.center, price))
          : MediaQuery.of(context).size.width >= 740 && MediaQuery.of(context).size.width < 1350 ?
            orderAndSalesCardReuseTabletAndWeb(context, () {Get.to(() => const OrderCardDetailsScreen(), transition: Transition.downToUp);}, tabletPadding, const EdgeInsets.only(right: 10.0), ConstantStrings.orderReceiptText, subtitleText, orderNumberText, secondNumberText, triangle(color, direction, 12, CrossAxisAlignment.start, price))
          : orderAndSalesCardReuseTabletAndWeb(context, () {Get.to(() => const OrderCardDetailsScreen(), transition: Transition.downToUp);}, webPadding, const EdgeInsets.only(right: 15.0), ConstantStrings.orderReceiptText, subtitleText, orderNumberText, secondNumberText, triangle(color, direction, 12, CrossAxisAlignment.start, price));
    });
  }

  Builder salesCardWidget(String salesNumberText, String secondNumberText, String price, Color color, String direction, String subtitleText) {
    var mobilePadding = const EdgeInsets.only(top: 12, right: 5, left: 10, bottom: 18);
    var tabletPadding = const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 15);
    var webPadding = const EdgeInsets.only(top: 12, right: 10, left: 15, bottom: 18);
    return Builder(builder: (context) {
      return MediaQuery.of(context).size.width < 740
          ? orderAndSalesCardReuseTabletAndWeb(context, () {Get.to(() =>  SalesDetailsScreen(), transition: Transition.downToUp);}, mobilePadding, const EdgeInsets.only(right: 24.0), ConstantStrings.salesVolumeText, subtitleText, salesNumberText, secondNumberText, triangle(color, direction, 8, CrossAxisAlignment.center, price))
          : MediaQuery.of(context).size.width >= 740 && MediaQuery.of(context).size.width < 1350
          ? orderAndSalesCardReuseTabletAndWeb(context, () {Get.to(() =>  SalesDetailsScreen(), transition: Transition.downToUp);}, tabletPadding, const EdgeInsets.only(left: 10.0, right: 8.0), ConstantStrings.salesVolumeText, subtitleText, salesNumberText, secondNumberText, triangle(color, direction, 12, CrossAxisAlignment.start, price))
          : orderAndSalesCardReuseTabletAndWeb(context, () {Get.to(() =>  SalesDetailsScreen(), transition: Transition.downToUp);}, webPadding, const EdgeInsets.only(right: 15.0), ConstantStrings.salesVolumeText, subtitleText, salesNumberText, secondNumberText, triangle(color, direction, 12, CrossAxisAlignment.start, price));
    });
  }

  Builder absenceCardWidget(absenceData) {
    var smallScreenPadding= const EdgeInsets.only(top: 10, left: 10, right: 6, bottom: 8);
    var mediumScreenPadding= const EdgeInsets.only(top: 10, left: 10, right: 20, bottom: 2);
    var largeScreenPadding= const EdgeInsets.only(top: 10, left: 10, right: 16, bottom: 10);
    return Builder(builder: (context) {
      return MediaQuery.of(context).size.width < 740
          ? absenceCardView(context, absenceData, smallScreenPadding)
          : MediaQuery.of(context).size.width >= 740 && MediaQuery.of(context).size.width < 1350
          ? absenceCardView(context, absenceData, mediumScreenPadding)
          : absenceCardView(context, absenceData, largeScreenPadding);
    });
  }

  Builder topArticlePieChartCardWidget(articleData) {
    var mobilePadding = const EdgeInsets.only(top: 5.0, left: 5.0, bottom: 2.0);
    var tabletPadding = const EdgeInsets.only(top: 5.0, left: 10.0, bottom: 8.0, right: 10.0);
    var webPadding = const EdgeInsets.only(top: 5.0, left: 10.0, bottom: 5.0);
    var mobileBoxConstraintsText = const BoxConstraints(minWidth: 150.0, maxWidth: 155.0, minHeight: 40.0, maxHeight: 41.5);
    var tabletBoxConstraintsText = const BoxConstraints(minWidth: 100.0, maxWidth: 150.0, minHeight: 32.0, maxHeight: 45.0);
    var webBoxConstraintsText = const BoxConstraints(minWidth: 150.0, maxWidth: 155.0, minHeight: 40.0, maxHeight: 45.0);
    var mobileBoxConstraintsPieChart = const BoxConstraints(minWidth: 170.0, maxWidth: 175.0, minHeight: 74.0, maxHeight: 74.1);
    var tabletBoxConstraintsPieChart = const BoxConstraints(minWidth: 180.0, maxWidth: 185.0, minHeight: 50.0, maxHeight: 75.0);
    var webBoxConstraintsPieChart = const BoxConstraints(minWidth: 170.0, maxWidth: 175.0, minHeight: 80.0, maxHeight: 90.0);

    return Builder(builder: (context) {
      return MediaQuery.of(context).size.width < 740
          ? pieChartViewWidget(context, articleData, mobilePadding, mobileBoxConstraintsText, mobileBoxConstraintsPieChart)
          : MediaQuery.of(context).size.width >= 740 && MediaQuery.of(context).size.width < 1350
          ? pieChartViewWidget(context, articleData, tabletPadding, tabletBoxConstraintsText, tabletBoxConstraintsPieChart)
          : pieChartViewWidget(context, articleData, webPadding, webBoxConstraintsText, webBoxConstraintsPieChart);
    });
  }

  Builder salesPipelineBarChartCardWidget() {
    return Builder(builder: (context) {
      return MediaQuery.of(context).size.width < 740
          ? salesPipelineBarChartCardViewWidget(context, 48, 8.0, MediaQuery.of(context).size.width / 1.19, MediaQuery.of(context).size.height / 9, salesPipelineBarChart(8))
          : MediaQuery.of(context).size.width >= 740 && MediaQuery.of(context).size.width < 1350
          ? salesPipelineBarChartCardViewWidget(context, 40, 14.0, MediaQuery.of(context).size.width / 1.55, MediaQuery.of(context).size.height / 3, salesPipelineBarChart(12))
          : salesPipelineBarChartCardViewWidget(context, 38, 14.0, MediaQuery.of(context).size.width / 1.95, MediaQuery.of(context).size.height / 3, salesPipelineBarChart(12));
    });
  }

  Builder businessAccountCardWidget() {
    var mobilePadding = const EdgeInsets.symmetric(horizontal: 9.0, vertical: 25.0);
    var tabletPadding = const EdgeInsets.symmetric(horizontal: 21.0, vertical: 24.5);
    var webPadding = const EdgeInsets.symmetric(horizontal: 21.0, vertical: 26.0);
    return Builder(builder: (context) {
      return MediaQuery.of(context).size.width < 740
          ? businessAccountCardView(context, mobilePadding, 0.0, 0.0, 0.0, 0.0)
          : MediaQuery.of(context).size.width >= 740 &&MediaQuery.of(context).size.width < 1350
          ? businessAccountCardView(context, tabletPadding ,300, 350, 80, 90)
          : businessAccountCardView(context, webPadding, 300, 350, 80, 90);
    });
  }

  Column triangle(Color color, String direction, double fontSize, CrossAxisAlignment crossAxisAlignment, String price) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        CustomPaint(
          painter: TrianglePainter(color: color, direction: direction,),
          size: const Size(13, 12),
        ),
        const SizedBox(height: 4,),
        Text(price, style: CustomTheme.lightTheme().textTheme.displaySmall?.copyWith(fontSize: fontSize),)
      ],);
  }

  SfCartesianChart salesPipelineBarChart(double fontSize) {
    var data = {
      ConstantStrings.leadsText : 58, ConstantStrings.contactText: 25, ConstantStrings.presentationText: 10,
      ConstantStrings.offerText: 20, ConstantStrings.followUpText: 50, ConstantStrings.completedText: 30
    };

    return SfCartesianChart(
      plotAreaBorderWidth: 0.0,
      series: <CartesianSeries<ChartData, String>>[
        ColumnSeries<ChartData, String>(
          color: CustomColor.primaryColors,
          dataSource: data.entries.map((e) => ChartData(e.key, e.value.toDouble(), '', CustomColor.primaryColors)).toList(),
          xValueMapper: (ChartData data, _) => data.name,
          yValueMapper: (ChartData data, _) => data.amount,
        )
      ],
      primaryXAxis: CategoryAxis(
          labelStyle: CustomTheme.lightTheme().textTheme.displaySmall?.copyWith(fontSize: fontSize),
          majorGridLines: const MajorGridLines(width: 0),
          axisLine: const AxisLine(color: Colors.black),
          majorTickLines: const MajorTickLines(color: Colors.white)),
      primaryYAxis: const NumericAxis(majorGridLines: MajorGridLines(width: 0), isVisible: false),
    );
  }
}