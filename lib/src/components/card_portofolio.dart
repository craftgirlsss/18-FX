import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:delapanbelasfx/src/models/example_data_models.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../helpers/format_currencies.dart';
import 'main_variable.dart';

class CardPortofolio extends StatefulWidget {
  const CardPortofolio({super.key});

  @override
  State<CardPortofolio> createState() => _CardPortofolioState();
}

class _CardPortofolioState extends State<CardPortofolio> {
  bool? isView = false;
  late List<ChartSampleData> _chartData;
  late TrackballBehavior _trackballBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  bool candleStickView = true;

  @override
  void initState() {
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
    return Container(
      margin: const EdgeInsets.all(0),
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Balance", style: kDefaultTextStyleTitleAppBar(fontSize: 16)),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 100,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 26),
                  Text(isView == true ? "****" : formatCurrencyUs.format(293), style: kDefaultTextStyleTitleAppBarBold(fontSize: 40,)),
                  IconButton(
                    onPressed: (){
                      setState(() {
                        isView = !isView!;
                      });
                    }, 
                    icon: isView == true ? const Icon(CupertinoIcons.eye, size: 20, color: Colors.white,) : const Icon(CupertinoIcons.eye_slash_fill, size: 20, color: Colors.white,),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 7, right: 7, top: 3, bottom: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: GlobalVariablesType.buttonTextColor![1].withOpacity(0.3),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_upward_rounded, size: 15),
                      SizedBox(width: 5),
                      Text("3.90%")
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  padding: const EdgeInsets.only(left: 7, right: 7, top: 3, bottom: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black45),
                    color: Colors.transparent,
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_upward_rounded, size: 15),
                      SizedBox(width: 5),
                      Text("USD 12.23")
                    ],
                  ),
                )
              ],
            ),
          ),
          Text("Favorit : EURUSD", style: kDefaultTextStyleTitleAppBar(fontSize: 15),),
          const SizedBox(height: 10),          
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      candleStickView = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: candleStickView ? GlobalVariablesType.buttonSquereColor![0].withOpacity(0.2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: GlobalVariablesType.buttonSquereColor![0]
                      )
                    ),
                    child: const Text("Candle Stick"),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      candleStickView = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: candleStickView == false ? GlobalVariablesType.buttonSquereColor![0].withOpacity(0.2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: GlobalVariablesType.buttonSquereColor![0]
                      )
                    ),
                    child: const Text("Line"),
                  ),
                ),
              ],
            ),
          ),
         Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
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
          Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: (){},
                  child: Container(
                    // height: 70,
                    // width: 150,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.green,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              const Text("BUY", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19)),
                              const SizedBox(width: 3),
                              Text("119.83", style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 15))
                            ],
                          ),
                        ),
                        const Icon(CupertinoIcons.arrow_up_right, color: Colors.white)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: (){},
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.red,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: Colors.transparent,
                          child:  Row(
                            children: [
                              const Text("SELL", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19)),
                              const SizedBox(width: 3),
                              Text("119.83", style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 15))
                            ],
                          ),
                        ),
                        const Icon(CupertinoIcons.arrow_down_right, color: Colors.white)
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

