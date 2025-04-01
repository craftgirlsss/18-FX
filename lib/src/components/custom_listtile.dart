import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomListtile {

  static String dateFormatted({DateTime? time}){
    return DateFormat("yyyy-MM-dd hh:mm:ss").format(time ?? DateTime.now());
  }

  static ExpansionTile openPosition({
    Size? size,
    int? profit,
    String? symbol,
    String? orderType,
    String? lot,
    String? openPrice,
    String? sl,
    String? tp,
    String? openTime,
    String? tiketID
  }){
    return ExpansionTile(
      backgroundColor: Colors.white10,
      collapsedIconColor: Colors.white24,
      iconColor: Colors.white,
      collapsedBackgroundColor: Colors.white10,
      trailing: Text("${profit ?? 0}", style: TextStyle(color: profit! < 0 ? Colors.red : Colors.blue, fontSize: 14)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: "$symbol",
              style: const TextStyle(fontSize: 12),
              children: <TextSpan>[
                TextSpan(text: "$orderType", style: TextStyle(color: orderType == "buy" || orderType == "buy limit" || orderType == "buy stop" ? Colors.blue : Colors.red, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 3),
          Text("$lot lot from price $openPrice", style: const TextStyle(color: Colors.white38, fontSize: 12)),
        ],
      ),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
          width: size!.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("T / P :", style: TextStyle(color: Colors.white38, fontSize: 12)),
                          Text(" $tp", style: const TextStyle(color: Colors.white38, fontSize: 12)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("ID :", style: TextStyle(color: Colors.white38, fontSize: 12)),
                          Text(" #$tiketID", style: const TextStyle(color: Colors.white38, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("S / L :", style: TextStyle(color: Colors.white38, fontSize: 12)),
                          Text(" $sl", style: const TextStyle(color: Colors.white38, fontSize: 12)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Open :", style: TextStyle(color: Colors.white38, fontSize: 12)),
                          Text("${dateFormatted(time: DateTime.tryParse(openTime!)!.add(const Duration(hours: 7)))} WIB", overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white38, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}