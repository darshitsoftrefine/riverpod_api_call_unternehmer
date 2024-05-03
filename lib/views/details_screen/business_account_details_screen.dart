import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../theme/themes.dart';
import '../../utils/app_bar.dart';
import '../../utils/bottom_nav_bar.dart';
import '../../utils/string_constants.dart';

class BusinessAccountDetailsScreen extends StatelessWidget {
  BusinessAccountDetailsScreen({super.key});

  final data = [5.45, 6.12, 1.88, 7.02, 7.02, 7.02, 4.49, 3.40, 2.20, 1.21, 1.10, 0.50, 5.80, 5.82, 8.56, 8.60, 12.03, 12.03,
    12.03, 6.62, 6.62, 6.62, 2.79, 2.79, 2.97, 2.83, 2.95, 3.10, 2.68, 2.95,].asMap();

  final List<Color> gradientColors = [Colors.lightGreen, Colors.black54];

  @override
  Widget build(BuildContext context) {
    var customTheme = CustomTheme.lightTheme().textTheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBarFunction().appBarView(context, CustomColor.primaryColors),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          width: 500,
                          height: 370,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black54),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 0.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: SizedBox(width: 45, height: 35,
                                                  child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: CustomColor.primaryColors),),
                                                ),
                                              ),
                                              const Positioned(top: 5, right: 20, left: 18,
                                                child: SizedBox(width: 10, height: 5,
                                                    child: CircleAvatar(backgroundColor: Colors.white)),
                                              ),
                                              Positioned(top: 5, right: 20, left: 15.5,
                                                child: Text("S", style: customTheme.headlineSmall?.copyWith(fontSize: 20.0)),
                                              ),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(width: 15,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(ConstantStrings.businessAccountSavingBankText, style: customTheme.headlineMedium?.copyWith(fontWeight: FontWeight.normal, fontSize: 13),),
                                            Text(ConstantStrings.businessAccountNumberText, style: customTheme.titleMedium),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                const Divider(color: CustomColor.secondaryColor,),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 500,
                                        height: 200 ,
                                        child: LineChart(mainData()),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(onPressed: (){},
                                    style: ElevatedButton.styleFrom(
                                        maximumSize: const Size(500, 50),
                                        minimumSize: const Size(500, 50),
                                        backgroundColor: Colors.blueGrey,
                                        shape: const RoundedRectangleBorder()
                                    ), child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("12.495,22 \u{20AC}", style: customTheme.titleMedium?.copyWith(color: Colors.green, fontSize: 16),),
                                        Text("05.12.2023, 09:28", style: customTheme.headlineSmall,)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.black,),
              Padding(padding: const EdgeInsets.fromLTRB(15, 25, 15, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ConstantStrings.liquidityPlannerText, style: customTheme.displayLarge,),
                    Text(ConstantStrings.developmentEndDecemberText, style: customTheme.labelSmall,),

                    const SizedBox(height: 20,),
                    businessDetails(ConstantStrings.bankBalanceText, "6.747,14", customTheme.headlineMedium!.copyWith(fontSize: 14), customTheme.headlineMedium!.copyWith(fontSize: 14),),
                    const Divider(color: Colors.white,),
                    businessDetails(ConstantStrings.billsText, "+973,00", customTheme.headlineMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.normal), customTheme.headlineMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.normal)),
                    businessDetails(ConstantStrings.invoicesSubscription, "+2891,42", customTheme.headlineMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.normal), customTheme.headlineMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.normal)),
                    businessDetails(ConstantStrings.salesTaxText, "77.59", customTheme.headlineMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.normal), customTheme.headlineMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.normal)),
                    businessDetails(ConstantStrings.expensesText, "-1464,00", customTheme.headlineMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.normal), customTheme.headlineMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.normal)),
                    const Divider(color: Colors.blueGrey,),
                    const SizedBox(height: 15,),
                    businessDetails(ConstantStrings.balanceForecastText, "9225.15", customTheme.headlineMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.bold, color: CustomColor.primaryColors), customTheme.headlineMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.bold, color: CustomColor.primaryColors))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Column businessDetails(String title, String amount, TextStyle titleTextStyle, TextStyle amountTextStyle) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: titleTextStyle,),
            Text("$amount \u{20AC}", style: amountTextStyle,),
          ],
        ),
        const SizedBox(height: 15,)
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: const FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 10,
            interval: 15,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 50,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: CustomColor.secondaryColor, width: 1)),
      maxY: 16,
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (final entry in data.entries)
              FlSpot(entry.key.toDouble(), entry.value.toDouble())
          ],
          color: Colors.green,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text = const Text('', style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: CustomColor.secondaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text = const {
      6: '+6000',
      12: '+12T',
    }[value.toInt()] ??
        '';
    return Text(text, style: style, textAlign: TextAlign.left);
  }
}