import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/chart_data.dart';
import '../../model/tenants_model.dart';
import '../../theme/themes.dart';
import '../../utils/app_bar.dart';
import '../../utils/bottom_nav_bar.dart';
import '../../utils/string_constants.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.data});

  final TenantsData data;
  @override
  Widget build(BuildContext context) {
    var customTheme = CustomTheme.lightTheme().textTheme;
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBarFunction().appBarView(context, CustomColor.primaryColors),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 10),
                  child: Container(
                    width: 500,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black54),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 65,
                            width: 150,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18.0, right: 8.0, top: 18.0, bottom: 1.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${data.title}', style: customTheme.headlineMedium),
                                    Text('${data.subtitle}', style: customTheme.labelSmall),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            height: 170,
                            child: Align(alignment: Alignment.bottomRight, child: pieChartCardReuse(16),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.all(18.0), child: detailColumn())
              ],
            ),
          ),
        ),
        bottomNavigationBar: bottomNavigationBar()
    );
  }

  SfCircularChart pieChartCardReuse(double fontSize) {
    var customTheme = CustomTheme.lightTheme().textTheme;
    List<ChartData> list = <ChartData>[];
    List<Color> colors = [CustomColor.primaryColors, Colors.black54, CustomColor.secondaryColor, CustomColor.loginButtonColor, Colors.brown];
    String? currency = "";

    for (var i = 0; i < data.data!.articles!.length; i++) {
      currency = data.data!.articles![i].currency;
      list.add(
          ChartData(
              data.data!.articles![i].name,
              double.parse(data.data!.articles![i].amount.toString()),
              data.data!.articles![i].currency,
              colors[i])
      );
    }
    return SfCircularChart(
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
          widget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(ConstantStrings.orderScanText, style: customTheme.titleSmall?.copyWith(fontSize: 8),),
              Text('${getSum().toString()} $currency', style: customTheme.headlineSmall),
            ],
          ),
        )
      ],
      legend: Legend(
          padding: 5,
          itemPadding: 9.0,
          isVisible: true,
          textStyle: TextStyle(fontSize: fontSize, color: Colors.white),
          iconHeight: 10,
          iconWidth: 10,
          position: LegendPosition.left),
      series: <CircularSeries>[
        DoughnutSeries<ChartData, String>(
            dataSource: list,
            xValueMapper: (ChartData data, _) => data.name,
            yValueMapper: (ChartData data, _) => data.amount,
            pointColorMapper: (ChartData data, _) => data.color,
            strokeColor: Colors.transparent,
            legendIconType: LegendIconType.circle,
            radius: '100%',
            innerRadius: '60%',
            explode: true,
            explodeIndex: null,
            explodeOffset: "1.9%",
            explodeAll: true)
      ],
    );
  }

  Widget detailColumn() {
    var customTheme = CustomTheme.lightTheme().textTheme;
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.data!.articles!.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${data.data!.articles![index].name}", style: customTheme.headlineMedium),
                    Row(
                      children: [
                        Text("${data.data!.articles![index].amount}" ' ' "${data.data!.articles![index].currency}", style: customTheme.headlineMedium
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15.0,),
              ],
            );
          },
        ),
        const Divider(color: CustomColor.secondaryColor,),
        const SizedBox(height: 15.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(ConstantStrings.totalSumText, style: customTheme.headlineMedium),
            Text("${getSum()} ${data.data!.articles![0].currency}", style: customTheme.headlineMedium)
          ],
        )
      ],
    );
  }

  double getSum() {
    double sums = 0.00;
    for (int i = 0; i < data.data!.articles!.length; i++) {
      sums = sums + double.parse("${data.data!.articles![i].amount}");
    }
    return sums;
  }
}
