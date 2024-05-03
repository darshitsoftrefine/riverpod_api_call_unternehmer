import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/chart_data.dart';
import '../../theme/themes.dart';
import '../../utils/app_bar.dart';
import '../../utils/bottom_nav_bar.dart';
import '../../utils/string_constants.dart';
import '../../utils/triangle_painter.dart';

class SalesDetailsScreen extends StatelessWidget {
  SalesDetailsScreen({super.key});

  final ScrollController _scrollController = ScrollController();
  final ZoomPanBehavior _zoomPanBehavior = ZoomPanBehavior(
    enablePanning: true,
  );

  @override
  Widget build(BuildContext context) {
    var customTheme = CustomTheme.lightTheme().textTheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBarFunction().appBarView(context, CustomColor.primaryColors),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      width: 1000,
                      height: 360,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black54),
                      child: Padding(padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headingView(),
                            const SizedBox(height: 2,),
                            Text("${ConstantStrings.declarationsText} fur 2023", style: customTheme.titleMedium,),
                            const SizedBox(height: 10,),
                            SingleChildScrollView(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                width: 1300,
                                height: 190,
                                child: stackedColumnChartReuse(),
                              ),
                            ),
                            const Divider(color: CustomColor.secondaryColor,),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                 salesDetails(ConstantStrings.salesDecemberText, "921.60 \u{20AC}", "November +24.37 \u{20AC}"),
                                  const SizedBox(height: 70, child: VerticalDivider(color: CustomColor.secondaryColor,)),
                                 salesDetails(ConstantStrings.excessDecemberText, "921.60 \u{20AC}", "November +24.37 \u{20AC}")
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(color: CustomColor.secondaryColor),
                orderDetails('20001512', '11.12.2023', Theme.of(context).scaffoldBackgroundColor, 'Good Morning', '149.00 \u{20AC}'),
                orderDetails('20015235', '18.11.2023', Theme.of(context).scaffoldBackgroundColor, 'Matthias Bar', '49.00 \u{20AC}'),
                orderDetails('20015235', '18.11.2023', Theme.of(context).scaffoldBackgroundColor, 'KEYZERS Plannen', '199.00 \u{20AC}'),
                orderDetails('20015235', '18.11.2023', CustomColor.primaryColors, 'Purebeau New cosmetics GmbH', '199.00 \u{20AC}'),
                orderDetails('20015235', '18.11.2023', CustomColor.primaryColors, 'DB Fernverkehr AG', '49.00 \u{20AC}'),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Column orderDetails(String id, String date, Color color, String name, String price) {
    var customTheme = CustomTheme.lightTheme().textTheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
                children: [
                  Text(id, style: customTheme.headlineLarge?.copyWith(fontSize: 12.0)),
                  const SizedBox(width: 10,),
                  CircleAvatar(radius: 3.5, backgroundColor: color),
                ]),
            Text(date, style: customTheme.headlineLarge?.copyWith(fontSize: 12.0))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, overflow: TextOverflow.ellipsis, style: customTheme.headlineSmall?.copyWith(fontSize: 14.0)),
            Text(price, style: customTheme.headlineSmall?.copyWith(fontSize: 14.0))
          ],
        ),
        const SizedBox(height: 10,),
        const Divider(color: CustomColor.secondaryColor,)
      ],
    );
  }

  Row triangle(Color color, String direction, double fontSize, MainAxisAlignment mainAxisAlignment) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        CustomPaint(
          painter: TrianglePainter(color: color, direction: direction,),
          size: const Size(8, 8),
        ),
        const SizedBox(height: 4,),
        Text(" 36.82%", style: CustomTheme.lightTheme().textTheme.displaySmall?.copyWith(fontSize: fontSize, color: Colors.red),)
      ],);
  }

  Row headingView() {
    var customTheme = CustomTheme.lightTheme().textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(ConstantStrings.salesStatisticsText, style: customTheme.headlineMedium,),
        Row(
          children: [
            const CircleAvatar(backgroundColor: CustomColor.primaryColors, radius: 3,),
            const SizedBox(width: 3,),
            Text(ConstantStrings.salesVolumeText, style: customTheme.titleMedium?.copyWith(fontSize: 8),),
            const SizedBox(width: 20,),
            const CircleAvatar(backgroundColor: CustomColor.secondaryColor, radius: 3,),
            const SizedBox(width: 3,),
            Text(ConstantStrings.declarationsText, style: customTheme.titleMedium?.copyWith(fontSize: 8),)
          ],
        )
      ],
    );
  }

  SfCartesianChart stackedColumnChartReuse()  {
    return SfCartesianChart(
      tooltipBehavior: TooltipBehavior(
        enable: true,
        textStyle: const TextStyle(fontSize: 12)
      ),
      enableAxisAnimation: true,
      plotAreaBorderWidth: 0.0,
      series: <CartesianSeries<ChartData, String>>[
        StackedColumnSeries(
          width: 0.9,
          spacing: 0.2,
          groupName: 'Group A',
          color: CustomColor.primaryColors,
          dataSource: getSalesData(),
          xValueMapper: (ChartData data, _) => data.name,
          yValueMapper: (ChartData data, _) => data.amount,
        ),
        StackedColumnSeries(
          width: 0.9,
          spacing: 0.2,
          groupName: 'Group B',
          color: CustomColor.secondaryColor,
          dataSource: getDeclarationsData(),
          xValueMapper: (ChartData data, _) => data.name,
          yValueMapper: (ChartData data, _) => data.amount,
        ),
      ],
      zoomPanBehavior: _zoomPanBehavior,
      primaryXAxis: CategoryAxis(
          labelStyle: CustomTheme.lightTheme().textTheme.displaySmall?.copyWith(fontSize: 15, color: CustomColor.secondaryColor),
          majorGridLines: const MajorGridLines(width: 0),
          axisLine: const AxisLine(color: CustomColor.secondaryColor),
          majorTickLines: const MajorTickLines(color: CustomColor.secondaryColor)),
      primaryYAxis: NumericAxis(
        isVisible: true,
        labelFormat: '{value} \u{20AC}',
        labelStyle: CustomTheme.lightTheme().textTheme.displaySmall?.copyWith(fontSize: 10, color: CustomColor.secondaryColor),
        minimum: 200,
        maximum: 1000,
        majorTickLines: const MajorTickLines(color: CustomColor.secondaryColor),
        majorGridLines: const MajorGridLines(width: 0, color: CustomColor.secondaryColor),),
    );
  }

  Column salesDetails(String title, String salesAmount, String salesMonth) {
    var customTheme = CustomTheme.lightTheme().textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: customTheme.titleMedium,),
        Row(
          children: [
            Text(salesAmount, style: customTheme.headlineMedium?.copyWith(fontSize: 12),),
            const SizedBox(width: 5,),
            triangle(Colors.red, 'bottom', 10, MainAxisAlignment.end)
          ],
        ),
        Text(salesMonth, style: customTheme.titleMedium?.copyWith(fontSize: 8),)
      ],
    );
  }

  List<ChartData> getSalesData() {
    final data = {
      'Jan': 600, 'Feb': 250, 'Mar': 800, 'Apr': 450,
      'May': 350, 'Jun': 730, 'Jul': 530, 'Aug': 330,
      'Sept': 720, 'Oct': 250, 'Nov': 640, 'Dec': 920,
    };

    return data.entries.map((entry) => ChartData(entry.key, entry.value.ceilToDouble(), '', CustomColor.primaryColors)).toList();
  }

  List<ChartData> getDeclarationsData() {
    final data = {
      'Jan': 400, 'Feb': 500, 'Mar': 400, 'Apr': 350,
      'May': 450, 'Jun': 800, 'Jul': 630, 'Aug': 430,
      'Sept': 500, 'Oct': 300, 'Nov': 500, 'Dec': 820,
    };

    return data.entries.map((entry) => ChartData(entry.key, entry.value.ceilToDouble(), '', CustomColor.secondaryColor)).toList();
  }
}