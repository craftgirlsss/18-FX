import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:url_launcher/url_launcher.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariablesType.backgroundColor,
      appBar: kDefaultAppBarCustom(context, centerTitle: true, title: const Text("FAQ")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ExpansionTile(
                iconColor: GlobalVariablesType.mainColor,
                collapsedIconColor: GlobalVariablesType.mainColor,
                title: Text(
                  'Memulai Trading?',
                  style: kDefaultTextStyleCustom(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: GlobalVariablesType.mainColor),
                ),
                children: <Widget>[
                  Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 5),
                        child: Text(
                          "Anda bebas memilih jenis akun yang sesuai dengan keinginan Anda.",
                          style:
                              kDefaultTextStyleCustom(fontSize: 13),
                        ),
                      );
                    },
                  ),
                ],
              ),
              ExpansionTile(
                iconColor: GlobalVariablesType.mainColor,
                collapsedIconColor: GlobalVariablesType.mainColor,
                title: Text(
                  'Deposit & Penarikan Dana?',
                  style: kDefaultTextStyleCustom(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: GlobalVariablesType.mainColor),
                ),
                children: <Widget>[
                  Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 5),
                        child: Text(
                          "Deposit bank lokal aman, cepat, dan mudah. Atau pilih dari beragam metode pembayaran dari kartu bank dan transfer hingga sistem pembayaran elektronik.",
                          style:
                              kDefaultTextStyleCustom(fontSize: 13),
                        ),
                      );
                    },
                  ),
                ],
              ),
              ExpansionTile(
                iconColor: GlobalVariablesType.mainColor,
                collapsedIconColor: GlobalVariablesType.mainColor,
                title: Text(
                  'Tips Berinvestasi?',
                  style: kDefaultTextStyleCustom(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: GlobalVariablesType.mainColor),
                ),
                children: <Widget>[
                  Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 5),
                        child: Text(
                          """
1. Gunakan idle money atau dana menganggur yang belum akan digunakan

2. Lakukan analisis pada produk sebelum mulai berinvestasi

3. Lakukan diferensiasi produk untuk meminimalisasi potensi risiko

4. Disiplin dan konsisten dalam berinvestasi

""",
                          style:
                              kDefaultTextStyleCustom(fontSize: 13),
                        ),
                      );
                    },
                  ),
                ],
              ),
              ExpansionTile(
                iconColor: GlobalVariablesType.mainColor,
                collapsedIconColor: GlobalVariablesType.mainColor,
                title: Text(
                  'Langkah Pengaduan Nasabah',
                  style: kDefaultTextStyleCustom(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: GlobalVariablesType.mainColor),
                ),
                children: <Widget>[
                  Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 5),
                        child: Text(
                          """
1. Menu tiket di aplikasi 18FX

2. Nasabah bisa datang langsung ke kantor PT. Delapan Belas Berjangka 

3. Melalui surat tercatat

4. Surat elektronik cs@18fx.co.id

5. Nomor Telepon 021-50322008

6. Nomor WhatsApp 081190056817
""",
                          style:
                              kDefaultTextStyleCustom(fontSize: 13),
                        ),
                      );
                    },
                  ),
                ],
              ),
              ExpansionTile(
                iconColor: GlobalVariablesType.mainColor,
                collapsedIconColor: GlobalVariablesType.mainColor,
                title: Text(
                  'Pengaduan Bappebti',
                  style: kDefaultTextStyleCustom(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: GlobalVariablesType.mainColor),
                ),
                children: <Widget>[
                  Builder(
                    builder: (BuildContext context) {
                      return Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 5),
                          child: RichText(
                            text: TextSpan(
                              text:
                                  'Peraturan Kepala Badan Pengawas Perdagangan Berjangka Komoditi Republik Indonesia Nomor 4 Tahun 2020.\n',
                              style: kDefaultTextStyleCustom(fontSize: 13),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'https://pengaduan.bappebti.go.id/',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        if (!await launchUrl(Uri.parse(
                                            "https://pengaduan.bappebti.go.id/"))) {
                                          throw Exception('Could not launch');
                                        }
                                      },
                                    style: kDefaultTextStyleCustom(
                                        color: CupertinoColors.link)),
                              ],
                            ),
                          ));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    // return CupertinoPageScaffold(
    //   backgroundColor: CupertinoColors.systemBackground,
    //   navigationBar: CupertinoNavigationBar(
    //     automaticallyImplyLeading: true,
    //     previousPageTitle: "Back",
    //     middle: Text(
    //       "FAQ",
    //       style: kDefaultTextStyleBold(fontSize: 17),
    //     ),
    //   ),
    //   child: SafeArea(
    //     child: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           CupertinoListTile(title: Text("Hello"))],
    //       ),
    //     ),
    //   ),
    // );
  }
}