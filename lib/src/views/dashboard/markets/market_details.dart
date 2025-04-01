import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:delapanbelasfx/src/helpers/focus_manager.dart';
import 'package:delapanbelasfx/src/helpers/format_currencies.dart';
import 'package:delapanbelasfx/src/models/example_data_models.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MarketDetails extends StatefulWidget {
  final String? title;
  const MarketDetails({super.key, required this.title});

  @override
  State<MarketDetails> createState() => _MarketDetailsState();
}

class _MarketDetailsState extends State<MarketDetails> {
  TextEditingController lotsController = TextEditingController();
  late List<ChartSampleData> _chartData;
  late TrackballBehavior _trackballBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  bool candleStickView = true;

  @override
  void initState() {
    lotsController.text = "0.10";
    _chartData = getChartData();
    _zoomPanBehavior = ZoomPanBehavior(
      // enableMouseWheelZooming: true,
      enableDoubleTapZooming: true,
      enablePinching: true,
      enableSelectionZooming: true,
      selectionRectBorderColor: Colors.red,
      selectionRectBorderWidth: 1,
      // selectionRectColor: Colors.grey,
      // maximumZoomLevel: 0.3,
      // zoomMode: ZoomMode.xy,
      enablePanning: true,
      );
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: focusManager,
      child: Scaffold(
        backgroundColor: GlobalVariablesType.backgroundColor,
        appBar: kDefaultAppBarCustom(
          context,
          title: Container(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(formatCurrencyUs.format(0.85), style: kDefaultTextStyleCustom(fontSize: 17)),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text("Demo", style: kDefaultTextStyleCustom(color: Colors.white, fontSize: 10, fontWeight: FontWeight.normal),),
                    ),
                    const SizedBox(width: 5),
                    Text("23729942", style: kDefaultTextStyleCustom(fontWeight: FontWeight.normal, color: Colors.white),),
                    const Icon(Icons.arrow_drop_down)
                  ],
                ),
              ],
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.info, color: Colors.black45))
          ]
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: GlobalVariablesType.mainColor
                              ),
                              child: Row(
                                children: [
                                  Text(widget.title ?? 'Unknown'),
                                  const Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: GlobalVariablesType.mainColor
                              ),
                              child: const Text("M1"),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: GlobalVariablesType.mainColor
                              ),
                              child: const Icon(CupertinoIcons.function, size: 19, color: Colors.black45),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: GlobalVariablesType.mainColor
                              ),
                              child: const Icon(Icons.edit_outlined, size: 19, color: Colors.black45),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: GlobalVariablesType.mainColor
                              ),
                              child: const Icon(Icons.layers_outlined, size: 19, color: Colors.black45),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: GlobalVariablesType.mainColor
                              ),
                              child: const Icon(CupertinoIcons.settings_solid, size: 19, color: Colors.black45),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.8,
                  color: Colors.transparent,
                  child: SfCartesianChart(
                    legend: Legend(isVisible: true, textStyle: kDefaultTextStyleCustom()),
                    zoomPanBehavior: _zoomPanBehavior,
                    plotAreaBorderWidth: 0,
                    crosshairBehavior: CrosshairBehavior(enable: true),
                    trackballBehavior: _trackballBehavior,
                    indicators: [
                      SmaIndicator<dynamic, dynamic>(
                        seriesName: 'HiloOpenClose',
                        period: 4,
                        signalLineWidth: 0.9, 
                        valueField: 'close'),
                      SmaIndicator<dynamic, dynamic>(
                        seriesName: 'HiloOpenClose',
                        period: 9,
                        signalLineColor: Colors.red,
                        signalLineWidth: 0.9, 
                        valueField: 'close'),
                    ],
                    series: <CandleSeries>[
                      CandleSeries<ChartSampleData, DateTime>(
                        // trendlines: [
                        //   Trendline(
                        //     type: TrendlineType.linear,
                        //   )
                        // ],
                          dataSource: _chartData,
                          name: 'HiloOpenClose',
                          enableSolidCandles: true,
                          xValueMapper: (ChartSampleData sales, _) => sales.x,
                          lowValueMapper: (ChartSampleData sales, _) => sales.low,
                          highValueMapper: (ChartSampleData sales, _) => sales.high,
                          openValueMapper: (ChartSampleData sales, _) => sales.open,
                          closeValueMapper: (ChartSampleData sales, _) => sales.close)
                      ],
                      primaryXAxis: DateTimeAxis(
                        enableAutoIntervalOnZooming: true,
                        dateFormat: DateFormat.yMMMd(),
                        interval: 1,
                        majorGridLines: const MajorGridLines(
                          dashArray: <double>[7,7],
                          width: 0.2),
                        ),
                      enableAxisAnimation: true,
                      // borderColor: Colors.white.withOpacity(0.4),
                      borderWidth: 0,
                      primaryYAxis:  NumericAxis(
                        numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                        opposedPosition: true,
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        minimum: 80,
                        maximum: 130,
                        interval: 10,
                        majorGridLines: const MajorGridLines(
                        dashArray: <double>[7,7], 
                          width: 0.2)
                      // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                // button and pending order
                Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: GlobalVariablesType.mainColor.withOpacity(0.6)
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: GlobalVariablesType.mainColor
                                    ),
                                    child: const Icon(Icons.add, color: Colors.white),
                                  ),
                                  const SizedBox(width: 5),
                                  Text("PENDING ORDER", style: kDefaultTextStyleCustom(fontSize: 14),)
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: GlobalVariablesType.mainColor.withOpacity(0.8)
                              ),
                              child: const Icon(Icons.notifications, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(right: 10),
                              width: MediaQuery.of(context).size.width / 4,
                              height: 70,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(6),
                                  bottomRight: Radius.circular(6),
                                  bottomLeft: Radius.circular(40),
                                ),
                                color: Colors.green
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("SELL", style: kDefaultTextStyleCustom(fontWeight: FontWeight.normal, fontSize: 15, color: Colors.white)),
                                  Text("1.085.62", style: kDefaultTextStyleCustom(fontWeight: FontWeight.normal, fontSize: 15, color: Colors.white))
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: 70,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: GlobalVariablesType.mainColor.withOpacity(0.8)
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(onPressed: (){}, icon: const Icon(Icons.remove, color: Colors.white,)),
                                  Expanded(
                                    child: Column(  

                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("LOTS", style: kDefaultTextStyleCustom(color: Colors.white),),
                                        TextField(
                                          textAlign: TextAlign.center,
                                          cursorHeight: 25,
                                          cursorRadius: const Radius.circular(5),
                                          cursorColor: Colors.black,
                                          style: kDefaultTextStyleCustom(fontSize: 15,),
                                          controller: lotsController,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(onPressed: (){}, icon: const Icon(Icons.add, color: Colors.white,)),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              width: MediaQuery.of(context).size.width / 4,
                              height: 70,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40),
                                  topLeft: Radius.circular(6),
                                  bottomLeft: Radius.circular(6),
                                  bottomRight: Radius.circular(40),
                                ),
                                color: Colors.red
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("BUY", style: kDefaultTextStyleCustom(fontWeight: FontWeight.normal, fontSize: 15, color: Colors.white)),
                                  Text("1.085.72", style: kDefaultTextStyleCustom(fontWeight: FontWeight.normal, fontSize: 15, color: Colors.white))
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}