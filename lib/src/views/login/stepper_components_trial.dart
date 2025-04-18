import 'package:flutter/material.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';

class NumberStepper extends StatelessWidget {
  final double? width;
  final int? totalSteps;
  final int? curStep;
  final Color? stepCompleteColor;
  final Color? currentStepColor;
  final Color? inactiveColor;
  final double? lineWidth;
  final List<String>? nameStep;
  NumberStepper({
    super.key,
    this.width,
    this.curStep,
    this.stepCompleteColor,
    this.totalSteps,
    this.inactiveColor,
    this.currentStepColor,
    this.lineWidth, this.nameStep,
  }) : assert(curStep! > 0 == true && curStep <= totalSteps! + 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20.0,
        left: 24.0,
        right: 24.0,
      ),
      width: width,
      child: Row(
        children: _steps(),
      ),
    );
  }

  getCircleColor(i) {
    Color? color;
    if (i + 1 < curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep){
      color = currentStepColor;
    }else{
      color = Colors.grey[700];
    }
    return color;
  }

  getBorderColor(i) {
    Color? color;
    if (i + 1 < curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep){
      color = currentStepColor;
    }
    else{
      color = inactiveColor;
    }
    return color;
  }

  getLineColor(i) {
    var color =
        curStep! > i + 1 ?GlobalVariablesType.mainColor.withOpacity(0.4) : Colors.grey[500];
    return color;
  }

  List<Widget> _steps() {
    var list = <Widget>[];
    for (int i = 0; i < totalSteps!; i++) {
      //colors according to state

      var circleColor = getCircleColor(i);
      var borderColor = getBorderColor(i);
      var lineColor = getLineColor(i);

      // step circles
      list.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 28.0,
              height: 28.0,
              decoration: BoxDecoration(
                color: circleColor,
                borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                border: Border.all(
                  color: borderColor,
                  width: 1.0,
                ),
              ),
              child: getInnerElementOfStepper(i),
            ),
            const SizedBox(height: 5),
            Text(nameStep![i], textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.clip, style: kDefaultTextStyleCustom(color: Colors.white),)
          ],
        ),
      );
      list.add(const SizedBox(height: 5));
      //line between step circles
      if (i != totalSteps! - 1) {
        list.add(
          Expanded(
            child: Container(
              height: lineWidth,
              decoration: BoxDecoration(
                color: lineColor,
                borderRadius: BorderRadius.circular(5)
              ),
            ),
          ),
        );
      }
    }

    return list;
  }

  Widget getInnerElementOfStepper(index) {
    if (index + 1 < curStep) {
      return const Icon(
        Icons.check,
        color: Colors.white,
        size: 16.0,
      );
    } else if (index + 1 == curStep) {
      return Center(
        child: Text(
          '$curStep',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
      );
    }
    return Container();
  }
}