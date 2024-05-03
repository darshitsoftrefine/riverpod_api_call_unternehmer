import 'package:flutter/material.dart';

import '../../theme/themes.dart';
import '../../utils/app_bar.dart';
import '../../utils/bottom_nav_bar.dart';
import '../../utils/string_constants.dart';

class OrderCardDetailsScreen extends StatelessWidget {
  const OrderCardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      child: orderInvoicesAndOfferCardWidget(),
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
        bottomNavigationBar: bottomNavigationBar()
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

  Container orderInvoicesAndOfferCardWidget() {
    var customTheme = CustomTheme.lightTheme().textTheme;
    return Container(
      width: 500,
      height: 260,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black54),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Text(ConstantStrings.openInvoicesText, style: customTheme.labelSmall?.copyWith(fontSize: 20.0)),
            const SizedBox(height: 10,),
            Text("755.486,48 \u{20AC}", style: customTheme.titleLarge?.copyWith(fontSize: 25.0, fontWeight: FontWeight.normal)),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(ConstantStrings.numberText, style: customTheme.titleLarge?.copyWith(fontSize: 12.0, fontWeight: FontWeight.normal)),
                const SizedBox(width: 10,),
                Text("314", style: customTheme.labelSmall?.copyWith(fontSize: 10.0)),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(color: CustomColor.primaryColors,),
            const SizedBox(height: 10),
            Text(ConstantStrings.openOfferText, style: customTheme.labelSmall?.copyWith(fontSize: 20.0)),
            const SizedBox(height: 10),
            Text("486.882,19 \u{20AC}", style: customTheme.titleLarge?.copyWith(fontSize: 25.0, fontWeight: FontWeight.normal)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(ConstantStrings.numberText, style: customTheme.titleLarge?.copyWith(fontSize: 12.0, fontWeight: FontWeight.normal)),
                const SizedBox(width: 5,),
                Text("24", style: customTheme.labelSmall?.copyWith(fontSize: 10.0)),
              ]),
          ]),
      ),
    );
  }
}
