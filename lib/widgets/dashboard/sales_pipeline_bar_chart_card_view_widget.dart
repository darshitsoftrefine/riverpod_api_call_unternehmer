import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../theme/themes.dart';
import '../../utils/string_constants.dart';
import '../../views/details_screen/sales_pipeline_details_screen.dart';


Padding salesPipelineBarChartCardViewWidget(BuildContext context, double titleHeight, double subtitleFontSize, double barChartWidth, double barChartHeight, SfCartesianChart salesPipelineBarChart) {
  var customTheme = CustomTheme.lightTheme().textTheme;
  return Padding(
    padding: const EdgeInsets.only(left: 6.0, right: 6.0),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              Get.to(() => const SalesPipelineDetailsScreen(), transition: Transition.downToUp);
            },
            child: SizedBox(
              child: Card(
                elevation: 0.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                color: Colors.white,
                child: Padding(padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: const EdgeInsets.only(left: 8.0,  right: 8.0, top: 8.0, bottom: 0),
                        child: SizedBox(
                          height: titleHeight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(ConstantStrings.salesPipelineText, style: customTheme.titleLarge),
                              Text(ConstantStrings.weightedSalesPerSalesPhaseText, style: customTheme.headlineLarge?.copyWith(overflow: TextOverflow.ellipsis, fontSize: subtitleFontSize),)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: barChartWidth,
                        height: barChartHeight,
                        child: salesPipelineBarChart,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,)
        ],
      ),
    ),
  );
}