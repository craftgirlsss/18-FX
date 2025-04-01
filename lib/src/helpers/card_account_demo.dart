import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:flutter/material.dart';

class CardAccountDemo extends StatefulWidget {
  final String? margin;
  final String? tradingID;
  final String? balance;
  final String? depositAmount;
  const CardAccountDemo({super.key, this.margin, this.tradingID, this.balance, this.depositAmount});

  @override
  State<CardAccountDemo> createState() => _CardAccountDemoState();
}

class _CardAccountDemoState extends State<CardAccountDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white38),
        color: GlobalVariablesType.backgroundColor,
        boxShadow: const [BoxShadow(color: Colors.white54, blurRadius: 3, offset: Offset(3, 3))]
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white54),
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(7)
                ),
                child: Center(child: Text("DEMO - ${widget.tradingID ?? '0'}", style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.bold))),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Expanded(child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Divider(color: Colors.white54),
              )),
              Text("Margin \$${widget.margin ?? 0}", style: const TextStyle(color: Colors.white54)),
              const Expanded(child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Divider(color: Colors.white54),
              )),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Balance", style: TextStyle(color: Colors.white54, fontSize: 15)),
                  Text("\$ ${widget.balance ?? "0.00"}", style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white70))
                ],
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text("Deposit : \$${widget.depositAmount ?? 0}", style: const TextStyle(color: Colors.white54, fontSize: 12)),
              //   ],
              // )
            ],
          ),
        ],
      ),
    );
  }
}