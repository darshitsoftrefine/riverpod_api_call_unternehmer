import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive/hive.dart';
import 'package:reorderables/reorderables.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/tenants_model.dart';
import '../model/widget_model.dart';
import '../provider/tenants_provider.dart';
import '../theme/themes.dart';
import '../utils/app_bar.dart';
import '../widgets/custom_widgets.dart';
import '../utils/string_constants.dart';

class HomeScreen extends ConsumerWidget {
   HomeScreen({super.key});

  final ScrollController controller = ScrollController();
  String tenantId = ConstantStrings.dynamicId;
  ValueNotifier<String> bottomBarText = ValueNotifier(ConstantStrings.todayText);
  ValueNotifier<String> orderNumberText = ValueNotifier("61.912 \u{20AC}");
  ValueNotifier<String> orderSecondNumberText = ValueNotifier("42.749 \u{20AC}");
  ValueNotifier<String> salesNumberText = ValueNotifier("49.528 \u{20AC}");
  ValueNotifier<String> salesSecondNumberText = ValueNotifier("54.729 \u{20AC}");
  List unternehmerData = [];
  int? articleIndex;
  int? absenceIndex;
  late SharedPreferences prefs;
  StreamSubscription? subscription;
  ValueNotifier<bool> checkConnection = ValueNotifier(false);
  String subtitleText = ConstantStrings.todayVsLastYearText;
  String orderPrices = "+9.02";
  Color orderStockColor = Colors.green;
  String orderDirection = 'top';
  String salesPrices = "-5.02";
  Color salesStockColor = Colors.red;
  String salesDirection = 'bottom';
  List<Model> model = [
    Model(index: 0, title: ConstantStrings.orderText),
    Model(index: 1, title: ConstantStrings.salesText),
    Model(index: 2, title: ConstantStrings.absenceText),
    Model(index: 3, title: ConstantStrings.topArticleText),
    Model(index: 4, title: ConstantStrings.salesPipelineText),
    Model(index: 5, title: ConstantStrings.businessAccountText)
  ];

  // @override
  @override
  Widget build(BuildContext context, ref) {
    var currentWidth = MediaQuery.of(context).size.width;
    final data = ref.watch(userDataProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBarFunction().appBarView(context, CustomColor.primaryColors),

      body: data.when(data: (data){
        List<TenantsData> userList = data.map((e) => e).toList();
        var smallScreenPadding = EdgeInsets.only(top: 10, bottom: 10, left: currentWidth * 0.18, right: currentWidth * 0.18);
        var mediumScreenPadding = EdgeInsets.only(top: 10.0, bottom: 10, left: currentWidth * 0.09, right: currentWidth * 0.09,);
        var largeScreenPadding = EdgeInsets.only(top: 10, bottom: 10, left: currentWidth * 0.10, right: currentWidth * 0.10);
        var otherScreenPadding = EdgeInsets.all(currentWidth * 0.03);

        dragCards.value = getDragCards(userList, ref);
        configToNewPosition();
        return SafeArea(
          child: userList.isEmpty ? const Center(child: CircularProgressIndicator(color: Colors.white,),
          ) :
          SingleChildScrollView(
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth > 1350) {
                      return Center(child: valueListenableBuilderWidget(smallScreenPadding));
                    } else if (constraints.maxWidth < 1350 && constraints.maxWidth > 740) {
                      return OrientationBuilder(
                        builder: (BuildContext context, Orientation orientation) {
                          return orientation == Orientation.portrait
                              ? valueListenableBuilderWidget(mediumScreenPadding)
                              : Center(child: valueListenableBuilderWidget(largeScreenPadding));
                        },
                      );
                    } else {
                      return valueListenableBuilderWidget(otherScreenPadding);
                    }},
                ),
              ],
            ),
          )
        );
      },
          error: (err, s) => Center(child: Text(err.toString())),
          loading: () => const Center(
            child: CircularProgressIndicator(color: Colors.white,),
          )),
      // body: SafeArea(
      //     child: GetBuilder<TenantsController>(
      //       builder: (getController) {
      //         CheckInternetConnectivity().checkInternetConnection().then((hasInternet) {
      //           if (hasInternet) {
      //             unternehmerData = getController.tenantsItem;
      //           } else {
      //             unternehmerData = getDataFromLocal();
      //             unternehmerData.isEmpty ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ConstantStrings.noInternetAndNoData, style: CustomTheme.lightTheme().textTheme.headlineSmall?.copyWith(fontSize: 14))))
      //                 : const SizedBox();
      //           }
      //         });
      //         if(unternehmerData.isNotEmpty){
      //           dragCards.value = getDragCards(unternehmerData);
      //         }
      //         var smallScreenPadding = EdgeInsets.only(top: 10, bottom: 10, left: currentWidth * 0.18, right: currentWidth * 0.18);
      //         var mediumScreenPadding = EdgeInsets.only(top: 10.0, bottom: 10, left: currentWidth * 0.09, right: currentWidth * 0.09,);
      //         var largeScreenPadding = EdgeInsets.only(top: 10, bottom: 10, left: currentWidth * 0.10, right: currentWidth * 0.10);
      //         var otherScreenPadding = EdgeInsets.all(currentWidth * 0.03);
      //
      //         return unternehmerData.isEmpty ? const Center(child: CircularProgressIndicator(color: Colors.white))
      //             : SingleChildScrollView(
      //               child: Column(
      //                 children: [
      //                   internetConnectionCheck(),
      //                   LayoutBuilder(
      //                     builder: (BuildContext context, BoxConstraints constraints) {
      //                   if (constraints.maxWidth > 1350) {
      //                     return Center(child: valueListenableBuilderWidget(smallScreenPadding));
      //                   } else if (constraints.maxWidth < 1350 && constraints.maxWidth > 740) {
      //                     return OrientationBuilder(
      //                       builder: (BuildContext context, Orientation orientation) {
      //                         return orientation == Orientation.portrait
      //                             ? valueListenableBuilderWidget(mediumScreenPadding)
      //                             : Center(child: valueListenableBuilderWidget(largeScreenPadding));
      //                       },
      //                     );
      //                   } else {
      //                     return valueListenableBuilderWidget(otherScreenPadding);
      //                   }},
      //                   ),
      //                 ],
      //               ),
      //             );
      //       },)
      // ),
      bottomNavigationBar: bottomBar(context),
    );
  }

  getDataFromLocal(){
    List localDBData = Hive.box(ConstantStrings.localDB).get(ConstantStrings.dbKey);
    return localDBData.map((tenantsData) => TenantsData.fromJson(tenantsData)).toList();
  }

  // getDataAfterInternetOn() async {
  List<Widget>  dragCardList = [];

  ValueNotifier<List<Widget>> dragCards = ValueNotifier([]);

  List<Widget> getDragCards(List<TenantsData> unternehmerData, WidgetRef ref) {
    absenceIndex = unternehmerData.indexWhere((book) => book.title?.contains(ConstantStrings.absenceText) as bool);
    articleIndex = unternehmerData.indexWhere((book) => book.title?.contains(ConstantStrings.topArticleText) as bool);
    List<Widget> widgetBuilders = [
      ValueListenableBuilder(
        valueListenable: orderNumberText,
        builder: (BuildContext context, value, Widget? child) {
          return ValueListenableBuilder(
            valueListenable: orderSecondNumberText,
            builder: (BuildContext context, String value1, Widget? child) {
              return CustomWidgets().orderCardWidget(value, value1, orderPrices, orderStockColor, orderDirection, subtitleText);
            },
          );
        },),
      ValueListenableBuilder(
        valueListenable: salesNumberText,
        builder: (BuildContext context, value, Widget? child) {
          return ValueListenableBuilder(
            valueListenable: salesSecondNumberText,
            builder: (BuildContext context, String value1, Widget? child) {
              return CustomWidgets().salesCardWidget(value, value1, salesPrices, salesStockColor, salesDirection, subtitleText);
            },
          );
        },),
      CustomWidgets().absenceCardWidget(unternehmerData[absenceIndex!]),
      CustomWidgets().topArticlePieChartCardWidget(unternehmerData[articleIndex!]),
      CustomWidgets().salesPipelineBarChartCardWidget(),
      CustomWidgets().businessAccountCardWidget(),
    ];

    dragCardList.clear();
    model.map((e) {
      dragCardList.add(widgetBuilders[e.index]);
      }).toList();
    return dragCardList;
  }

  valueListenableBuilderWidget(EdgeInsets screenSizePadding){
    return Padding(
      padding: screenSizePadding,
      child: ValueListenableBuilder(
          valueListenable: dragCards,
          builder: (context, value, child) {
            return ReorderableWrap(
                buildDraggableFeedback: (context, constraints, child) {
                  return Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white),
                    child: child,
                  );
                },
                controller: controller,
                children: value,
                onReorder: (oldIndex, newIndex) {
                  Widget card = dragCards.value.removeAt(oldIndex);
                  dragCards.value.insert(newIndex, card);
                  Model newCardIndex = model.removeAt(oldIndex);
                  model.insert(newIndex, newCardIndex);
                  prefs.setStringList(ConstantStrings.sharedPreferencesKey, model.map((e) => e.index.toString()).toList());
                });
          }),
    );
  }

  GestureDetector bottomBar(BuildContext context) {
    var customTheme = CustomTheme.lightTheme().textTheme;
    return GestureDetector(
      onTap: () {
        Theme.of(context).brightness == Brightness.dark ? showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.zero,
              child: CupertinoActionSheet(
                cancelButton: cupertinoActionSheetActionWidget(ConstantStrings.cancelText, CustomColor.primaryColors, 16, FontWeight.bold, ConstantStrings.cancelText1),
                actions: [
                  cupertinoActionSheetActionWidget(ConstantStrings.selectButtonTitle, CustomColor.secondaryColor, 12, FontWeight.normal, bottomBarText.value),
                  cupertinoActionSheetActionWidget(ConstantStrings.todayText, Colors.white, 16, FontWeight.normal, ConstantStrings.todayText),
                  cupertinoActionSheetActionWidget(ConstantStrings.yesterdayText, Colors.white, 16, FontWeight.normal, ConstantStrings.yesterdayText),
                  cupertinoActionSheetActionWidget(ConstantStrings.thisWeekText, Colors.white, 16, FontWeight.normal, ConstantStrings.thisWeekText),
                  cupertinoActionSheetActionWidget(ConstantStrings.thisMonthText, Colors.white, 16, FontWeight.normal, ConstantStrings.thisMonthText),
                  cupertinoActionSheetActionWidget(ConstantStrings.thisYearText, Colors.white, 16, FontWeight.normal, ConstantStrings.thisYearText),
                ],
              ),
            );
          },
        ) : showCupertinoModalPopup(context: context,  builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.zero,
            child: CupertinoActionSheet(
              cancelButton: cupertinoActionSheetActionWidget(ConstantStrings.cancelText, CustomColor.primaryColors, 16, FontWeight.bold, ConstantStrings.cancelText1),
              actions: [
                cupertinoActionSheetActionWidget(ConstantStrings.selectButtonTitle, CustomColor.secondaryColor, 12, FontWeight.normal, bottomBarText.value),
                cupertinoActionSheetActionWidget(ConstantStrings.todayText, Colors.black, 16, FontWeight.normal, ConstantStrings.todayText),
                cupertinoActionSheetActionWidget(ConstantStrings.yesterdayText, Colors.black, 16, FontWeight.normal, ConstantStrings.yesterdayText),
                cupertinoActionSheetActionWidget(ConstantStrings.thisWeekText, Colors.black, 16, FontWeight.normal, ConstantStrings.thisWeekText),
                cupertinoActionSheetActionWidget(ConstantStrings.thisMonthText, Colors.black, 16, FontWeight.normal, ConstantStrings.thisMonthText),
                cupertinoActionSheetActionWidget(ConstantStrings.thisYearText, Colors.black, 16, FontWeight.normal, ConstantStrings.thisYearText),
              ],
            ),
          );
        });
      },
      child: Container(
        width: 50,
        height: 60,
        decoration: const BoxDecoration(color: CustomColor.primaryColors,),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Center(
            child:  ValueListenableBuilder(
              valueListenable: bottomBarText,
              builder: (BuildContext context, String period, Widget? child) {
                return Text(period, style: customTheme.labelMedium);
              },
            ),
          ),
        ),
      ),
    );
  }

  cupertinoActionSheetActionWidget(String text, Color colorData, double fontSize, FontWeight fontWeight, String onTab){
    var customTheme = CustomTheme.lightTheme().textTheme;
    return CupertinoActionSheetAction(
      onPressed: () { _handleOnPressed(onTab);
      },
      child: Center(
          child: Text(text, style: customTheme.displayMedium!.copyWith(color: colorData, fontSize: fontSize, fontWeight: fontWeight))
      ),
    );
  }

  void configToNewPosition() async {
    await SharedPreferences.getInstance().then((pref) {
      prefs = pref;
      List<String>? lst = pref.getStringList(ConstantStrings.sharedPreferencesKey);
      List<Model> newDragCardPosition = [];
      if(lst != null && lst.isNotEmpty){
        newDragCardPosition = lst.map((e) => model.where((Model item) => int.parse(e) == item.index).first,).toList();
        model = newDragCardPosition;
      }

    });
  }

  ValueListenableBuilder internetConnectionCheck(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return ValueListenableBuilder(valueListenable: checkConnection,
            builder: (BuildContext context, isConnected, Widget? child) {
              return isConnected ? Container() : Padding(
               padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Container(alignment: Alignment.topLeft, height: currentWidth < 740 ? 20 : 30, width: double.infinity, color: Theme.of(context).scaffoldBackgroundColor,
                  child: Row(
                  children: [
                    currentWidth < 740 ? const Icon(Icons.wifi_off_sharp, color: Colors.white, size: 20.0,) : const Icon(Icons.wifi_off_sharp, color: Colors.white, size: 30.0,),
                    const SizedBox(width: 5,),
                    currentWidth < 740 ? const Text(ConstantStrings.noInternetText, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),)
                        : const Text(ConstantStrings.noInternetText, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
                  ],
                ),),
              );
              },
    );
  }

  void _handleOnPressed(String tabValue) {
    if (tabValue == ConstantStrings.cancelText1) {
      Get.back();
    } else {
      bottomBarText.value = tabValue;
      if(bottomBarText.value == ConstantStrings.thisYearText) {
        changeCardData("12.47 Mio \u{20AC}", "8.2 Mio", "10.2 Mio \u{20AC}", "5.3 Mio ", '+9.02', CustomColor.greenColor, 'top', '+12.32', CustomColor.greenColor, 'top', ConstantStrings.yearPeriodText);
      } else if(bottomBarText.value == ConstantStrings.thisMonthText){
        changeCardData("1.27 Mio \u{20AC}", '0.3 Mio', "9.58 Mio \u{20AC}", "2.3 Mio", '-42.30', CustomColor.primaryColors, 'bottom', '+54.21', CustomColor.greenColor, 'top', ConstantStrings.monthPeriodText);
      } else if(bottomBarText.value == ConstantStrings.thisWeekText){
        changeCardData("282.458 \u{20AC}", "125.203", "545.236 \u{20AC}", "236.512", '+9.02', CustomColor.greenColor, 'top', '-12.32', CustomColor.primaryColors, 'bottom', ConstantStrings.weekPeriodText);
      } else if (bottomBarText.value == ConstantStrings.yesterdayText){
        changeCardData("39.658 \u{20AC}", "26.235", "16.254 \u{20AC}", "42.562", '-42.30', CustomColor.primaryColors, 'bottom', '+54.21', CustomColor.greenColor, 'top', ConstantStrings.yesterdayPeriodText);
      } else{
        changeCardData("61.912 \u{20AC}", "42.749", "49.528 \u{20AC}", "54.729", '+9.02', CustomColor.greenColor, 'top', '-12.32', CustomColor.primaryColors, 'bottom', ConstantStrings.todayVsLastYearText);
      }
      Get.back();
    }
  }

  void changeCardData(String orderData, String orderData1, String salesData, String salesData1, String orderPrice, Color orderColor, String orderDirections, String salePrice, Color saleColor, String saleDirections, String subtitle) {
    orderNumberText.value = orderData;
    orderSecondNumberText.value = orderData1;
    salesNumberText.value = salesData;
    salesSecondNumberText.value = salesData1;

  }
}
