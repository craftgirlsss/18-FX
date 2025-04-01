import 'package:flutter/material.dart';
import 'package:delapanbelasfx/src/components/buttons.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';

  Widget noOrders() {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/no_order.png', width: 100),
          const SizedBox(height: 10),
          Text("No active orders", style: kDefaultTextStyleCustom(fontSize: 20)),
        ],
      ),
    );
  }

  Widget noHistory() {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/no_order.png', width: 100),
          const SizedBox(height: 10),
          Text("No history orders", style: kDefaultTextStyleCustom(fontSize: 20)),
        ],
      ),
    );
  }

  Widget noAccountSelected() {
    return Container(
      padding: const EdgeInsets.all(30),
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/no_order.png', width: 100),
          const SizedBox(height: 5),
          Text("Tidak ada akun trading", style: kDefaultTextStyleCustom(fontSize: 20)),
          const SizedBox(height: 7),
          Text("Mohon pilih terlebih dahulu akun real yang telah anda buat menu di atas", textAlign: TextAlign.center,style: kDefaultTextStyleCustom(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white54)),
        ],
      ),
    );
  }

  Widget noRealAccountAdded({Function()? onPressed, String? idUserAccount}) {
    return Container(
      padding: const EdgeInsets.all(30),
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/no_order.png', width: 100),
          const SizedBox(height: 10),
          Text("Tidak ada akun trading", style: kDefaultTextStyleCustom(fontSize: 20)),
          const SizedBox(height: 5),
          Text("Tidak ada akun trading pada akun id $idUserAccount, Anda dapat menambahkan akun real yang telah anda buat untuk ditambahkan ke dalam akun trading", textAlign: TextAlign.center ,style: kDefaultTextStyleCustom(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white54)),
          const SizedBox(height: 7),
          kDefaultButtonLogin(
            onPressed: onPressed,
            backgroundColor: GlobalVariablesType.mainColor,
            title: "Tambah akun trading"
          )
        ],
      ),
    );
  }

  Widget noHistoryRecent({String? tanggal}) {
    return Container(
      padding: const EdgeInsets.all(30),
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/no_history.png', width: 100),
          const SizedBox(height: 10),
          Text("Tidak ada history trading", style: kDefaultTextStyleCustom(fontSize: 20)),
          const SizedBox(height: 5),
          Text("Tidak ada riwayat trading pada tanggal $tanggal sampai sekarang", textAlign: TextAlign.center ,style: kDefaultTextStyleCustom(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white54)),
          // const SizedBox(height: 7),
          // kDefaultButtonLogin(
          //   onPressed: onPressed,
          //   backgroundColor: GlobalVariablesType.mainColor,
          //   title: "Ubah Periode"
          // )
        ],
      ),
    );
  }

  Widget noActivePendingTransaction({String? dateStart, String? dateEnd, Function()? onPressed}) {
    return Container(
      padding: const EdgeInsets.all(30),
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/no_history.png', width: 100),
          const SizedBox(height: 10),
          Text("Tidak ada transaksi trading", style: kDefaultTextStyleCustom(fontSize: 20)),
          const SizedBox(height: 5),
          Text("Tidak ada transaksi trading untuk saat ini", textAlign: TextAlign.center ,style: kDefaultTextStyleCustom(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white54)),
        ],
      ),
    );
  }
