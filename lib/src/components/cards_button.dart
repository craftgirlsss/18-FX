import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/helpers/date_formatted.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

class CardsButton {
  static CupertinoButton cardMutasi({
    String? type,
    String? from,
    String? transactionID,
    String? amount,
    int? status,
    String? date
  }){
    String? statusName;
    Color? color;
    String? typeString;
    IconData? iconData;
    switch (type) {
      case "Withdrawal":
        iconData = Iconsax.wallet_minus_bold;
        typeString = "Ke Rekening";
        break;
      case "Deposit":
        iconData = Iconsax.wallet_add_bold;
        typeString = "Dari Rekening";
        break;
      default:
    }

    switch (status) {
      case 1:
        statusName = "Pending";
        color = Colors.orange;
        break;
      case 2:
        statusName = "Canceled";
        color = Colors.red;
        break;
      case -1:
        statusName = "Confirmed";
        color = Colors.green;
        break;
      default:
        statusName = "Unknown";
        color = Colors.blue;
    }
    return CupertinoButton(
      onPressed: (){},
      padding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(20),
          color: GlobalVariablesType.mainColor
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white54,
                  ),
                  child: Icon(iconData, color: Colors.black26, size: 30),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(type ?? "Unknown", style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),
                    Text("$typeString Bank $from", style: const TextStyle(color: Colors.black45, fontSize: 12)),
                    const SizedBox(height: 4),
                    const Text("ID Transaksi", style: TextStyle(color: Colors.black26, fontSize: 11)),
                    Text(transactionID ?? "0", style: const TextStyle(color: Colors.black45, fontSize: 13)),
                  ],
                )
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("\$ $amount", style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(statusName, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 4),
                Text(DateFormatted.formattedDate(date: date), style: const TextStyle(color: Colors.black26, fontSize: 12)),
                Text(DateFormatted.formattedTime(date: date), style: const TextStyle(color: Colors.black26, fontSize: 12)),
              ],
            )
          ],
        ),
      ),
    );
  }

  static CupertinoButton cardDocument({Size? size, Function()? onPressed, String? dateCreated, String? documentTitle}){
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        height: size!.width / 5,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: GlobalVariablesType.mainColor
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white54,
                  ),
                  child: const Icon(AntDesign.file_pdf_outline, color: Colors.black26, size: 30),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(documentTitle ?? "Unknown Document Name", style: const TextStyle(color: Colors.black54, fontSize: 14)),
                    Text("Tanggal dibuat : ${DateFormatted.formattedDate(date: dateCreated)}", style: const TextStyle(color: Colors.black26, fontSize: 11)),
                  ],
                )
              ],
            ),
            const Icon(EvaIcons.download_outline, color: Colors.black54)
          ],
        ),
      ),
    );
  }

  static CupertinoButton cardNews({
    String? author,
    String? title,
    String? urlImage,
    String? dateTime,
    String? readTime,
    String? like,
    String? watch,
    String? newsID,
    Function()? onPressed
  }){
    return CupertinoButton(
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white30,
          border: Border.all(color: Colors.white12),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Colors.black45, offset: Offset(1, 1))]
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // title and author
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 10,
                            backgroundImage: AssetImage('assets/images/ic_launcher.png'),
                            backgroundColor: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Text(author ?? "Unknown Author", style: const TextStyle(fontSize: 14, color: Colors.white)),
                        ],
                      ),
                      Text(title ?? "Unknown Title", style: const TextStyle(fontSize: 20, color: Colors.white), overflow: TextOverflow.clip, maxLines: 2)
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 120,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    image: DecorationImage(image: NetworkImage(urlImage!), fit: BoxFit.cover)
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(DateFormat('MMMM dd, yyyy').format(DateTime.now()), style: const TextStyle(color: Colors.white38, fontSize: 12)),
                    const SizedBox(width: 5),
                    const Icon(Icons.circle, color: Colors.white38, size: 8),
                    const SizedBox(width: 5),
                    Text("${readTime ?? 0} min read", style: const TextStyle(color: Colors.white38, fontSize: 12))
                  ],
                ),
                Row(
                  children: [
                    const Icon(Clarity.eye_solid, color: Colors.white24, size: 18),
                    const SizedBox(width: 5),
                    Text(watch ?? "0", style: const TextStyle(color: Colors.white70)),
                    const SizedBox(width: 10),
                    const Text(" | ", style: TextStyle(color: Colors.white38)),
                    const SizedBox(width: 10),
                    const Icon(CupertinoIcons.hand_thumbsup_fill, color: Colors.redAccent, size: 18),
                    const SizedBox(width: 5),
                    Text(like ?? "0", style: const TextStyle(color: Colors.white70)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}