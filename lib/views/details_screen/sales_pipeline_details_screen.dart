import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../theme/themes.dart';
import '../../utils/app_bar.dart';
import '../../utils/bottom_nav_bar.dart';
import '../../utils/string_constants.dart';

class SalesPipelineDetailsScreen extends StatelessWidget {
  const SalesPipelineDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var customTheme = CustomTheme.lightTheme().textTheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBarFunction().appBarView(context, CustomColor.primaryColors),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      width: 500,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black54),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(ConstantStrings.salesPerformanceText, style: customTheme.displayLarge?.copyWith(fontSize: 14),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(ConstantStrings.todayText, style: customTheme.titleSmall,),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               radialGauge(25, "25%", ConstantStrings.closingRateText),
                                radialGauge(75, "75%", ConstantStrings.callRateText)
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      width: 500,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black54),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: barChartDetails(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
        bottomNavigationBar: bottomNavigationBar()
    );
  }

  Widget barChartDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(ConstantStrings.salesPipelineText, style: CustomTheme.lightTheme().textTheme.displayLarge?.copyWith(fontSize: 14),),
        Text(ConstantStrings.todayText, style: CustomTheme.lightTheme().textTheme.titleSmall),
        const SizedBox(height: 20,),
        barChartListDetails(ConstantStrings.leadsText, "6%", "1.47 Mio. \u{20AC}", "12"),
        barChartListDetails(ConstantStrings.contactText, "18%", "815.645 \u{20AC}", "36"),
        barChartListDetails(ConstantStrings.presentationText, "13%", "198.844 \u{20AC}", "25"),
        barChartListDetails(ConstantStrings.offerText, "25%", "408.678 \u{20AC}", "49"),
        barChartListDetails(ConstantStrings.followUpText, "37%", "953.745 \u{20AC}", "74"),
        barChartListDetails(ConstantStrings.completedText, "2%", "794.369 \u{20AC}", "4")
      ],
    );
  }
  
  Widget barChartListDetails(String title, String subtitle, String price, String deals) {
    var customTheme = CustomTheme.lightTheme().textTheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: customTheme.headlineSmall?.copyWith(fontSize: 16)),
                Text(subtitle, style: customTheme.titleSmall),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(price, style: customTheme.headlineSmall?.copyWith(fontSize: 16)),
                Text("$deals Deals", style: customTheme.titleSmall),
              ],
            )
          ],
        ),
        const SizedBox(height: 20,)
      ],
    );
  }
  Widget radialGauge(double rangePointer, String range, String typeRate) {
    return SizedBox(
      width: 140,
      height: 150,
      child: SfRadialGauge(
        enableLoadingAnimation: true,
        axes: <RadialAxis>[
          RadialAxis(minimum: 0, maximum: 101,
            axisLineStyle: const AxisLineStyle(thickness: 0.01, thicknessUnit: GaugeSizeUnit.factor, color: Colors.white,),
            startAngle: 180, endAngle: 0,
            maximumLabels: 3,
            interval: 50,
            axisLabelStyle: const GaugeTextStyle(color: Colors.blueGrey, fontSize: 10, fontWeight: FontWeight.normal,),
            labelsPosition: ElementsPosition.outside,
            ticksPosition: ElementsPosition.outside,
            pointers: [
              RangePointer(value: rangePointer, color: CustomColor.primaryColors, enableAnimation: true,),
              const MarkerPointer(value: 50 ,markerHeight: 5, markerWidth: 5, overlayRadius: 15, color: Colors.blueGrey, markerType: MarkerType.circle,)
            ],
            annotations: [
              GaugeAnnotation(widget: Column(
                children: [
                  const SizedBox(height: 50,),
                  Text(range ,style: CustomTheme.lightTheme().textTheme.displayLarge?.copyWith(fontSize: 14)),
                  Text(typeRate, style: CustomTheme.lightTheme().textTheme.titleSmall)
                ],
              ),
                  angle: 90, positionFactor: 0.5)
            ],
          ),
        ],
      ),
    );
  }
}
