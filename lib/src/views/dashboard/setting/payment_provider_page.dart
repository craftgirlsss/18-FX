import 'package:flutter/material.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';

class PaymentProviderPage extends StatefulWidget {
  const PaymentProviderPage({super.key});

  @override
  State<PaymentProviderPage> createState() => _PaymentProviderPageState();
}

class _PaymentProviderPageState extends State<PaymentProviderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariablesType.backgroundColor,
      appBar: kDefaultAppBarCustom(context, title: Text("New Deposit", style: kDefaultTextStyleCustom(fontSize: 15))),
      body: ListView(),
    );
  }
}