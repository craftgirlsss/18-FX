import 'package:delapanbelasfx/src/components/custom_listtile.dart';
import 'package:delapanbelasfx/src/controllers/trading_account_controller.dart';
import 'package:delapanbelasfx/src/views/dashboard/accounts/mutasi_akun.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'deposit_account.dart';
import 'documents_account.dart';
import 'internal_transfer.dart';
import 'withdrawal_account.dart';

class DetailAccountPage extends StatefulWidget {
  const DetailAccountPage({super.key, this.loginID, this.accountCurrency});
  final String? loginID;
  final String? accountCurrency;

  static const List<Tab> menuTab = <Tab>[
    Tab(text: 'AKSI'),
    Tab(text: 'INFO'),
    Tab(text: 'TRANSAKSI'),
  ];

  @override
  State<DetailAccountPage> createState() => _DetailAccountPageState();
}

class _DetailAccountPageState extends State<DetailAccountPage> {
  
  TradingAccountController tradingAccountController = Get.put(TradingAccountController());
  RxList detailAccount = [].obs;

  @override
  void initState() {
    super.initState();
    for(int i = 0; i < tradingAccountController.listTradingAccount.value!.response.length; i++){
      if(tradingAccountController.listTradingAccount.value!.response[i].login == widget.loginID){
        String? rate;
        if(tradingAccountController.listTradingAccount.value!.response[i].rate == "0"){
          rate = "Floating";
        }else{
          rate = tradingAccountController.listTradingAccount.value!.response[i].rate;
        }
        detailAccount.add({
          "leverage" : tradingAccountController.listTradingAccount.value!.response[i].leverage,
          "fixed_rate" : rate,
          "currency" : tradingAccountController.listTradingAccount.value!.response[i].currency,
          "balance" : tradingAccountController.listTradingAccount.value!.response[i].balance,
          "id" : tradingAccountController.listTradingAccount.value!.response[i].id,
          "type" : tradingAccountController.listTradingAccount.value!.response[i].type!.toUpperCase()
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: DefaultTabController(
        length: DetailAccountPage.menuTab.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Real Akun ${widget.loginID}"),
            bottom: const TabBar(
              tabs: DetailAccountPage.menuTab,
            ),
          ),
          body: TabBarView(
            physics: const BouncingScrollPhysics(),
            children: DetailAccountPage.menuTab.map((Tab tab){
              final String label = tab.text!.toLowerCase();
              switch (label) {
                case "aksi":
                  return ListView(
                    children: [
                      ListTile(onTap: (){
                        Get.to(() => DepositAccount(akunTradingPengirim: widget.loginID, akunTradingID: detailAccount[0]['id'], jumlahBalance: detailAccount[0]['balance'], accountTradingCurrencyType: detailAccount[0]['currency'], rate: detailAccount[0]['fixed_rate']));
                      }, title: const Text('Deposit', style: TextStyle(color: Colors.white70)), leading: const Icon(Iconsax.card_receive_bold, color: Colors.white70), trailing: const CupertinoListTileChevron(), minLeadingWidth: 13),
                      ListTile(onTap: (){
                        Get.to(() => WithdrawalAccount(akunTradingPenerima: widget.loginID, akunTradingID: detailAccount[0]['id'], jumlahBalance: detailAccount[0]['balance'], currencyType: detailAccount[0]['currency'], rate: detailAccount[0]['fixed_rate']));
                      }, title: const Text('Withdrawal', style: TextStyle(color: Colors.white70)), leading: const Icon(Iconsax.card_send_bold, color: Colors.white70), trailing: const CupertinoListTileChevron(), minLeadingWidth: 13),
                      ListTile(onTap: (){
                        Get.to(() => InternalTransfer(
                          accountNumber: widget.loginID,
                          balance: detailAccount[0]['balance'],
                          accountTypeName: detailAccount[0]['type'],
                          accountCurrency: detailAccount[0]['currency'],
                        ));
                      }, title: const Text('Internal Transfer', style: TextStyle(color: Colors.white70)), leading: const Icon(Iconsax.convert_bold, color: Colors.white70), trailing: const CupertinoListTileChevron(), minLeadingWidth: 13),
                      ListTile(onTap: (){
                        Get.to(() => const MutasiAkun());
                      }, title: const Text('Riwayat DP & WD', style: TextStyle(color: Colors.white70)), leading: const Icon(OctIcons.clock_fill, color: Colors.white70), trailing: const CupertinoListTileChevron(), minLeadingWidth: 13),
                      ListTile(onTap: (){
                        Get.to(() => const DocumentsAccount());
                      }, title: const Text('Dokumen', style: TextStyle(color: Colors.white70)), leading: const Icon(Iconsax.document_1_bold, color: Colors.white70), trailing: const CupertinoListTileChevron(), minLeadingWidth: 13),
                      ListTile(onTap: (){}, title: const Text('Pengaturan Akun', style: TextStyle(color: Colors.white70)), leading: const Icon(Iconsax.setting_2_bold, color: Colors.white70), trailing: const CupertinoListTileChevron(), minLeadingWidth: 13),
                    ],
                  );
                case "info":
                  return ListView(
                    children: [
                      ListTile(title: const Text('Balance', style: TextStyle(color: Colors.white54)), trailing: Text("\$ ${detailAccount[0]['balance']}", style: const TextStyle(color: Colors.white70)), minLeadingWidth: 13),
                      ListTile(title: const Text('Leverage', style: TextStyle(color: Colors.white54)), trailing: Text("1:${detailAccount[0]['leverage'].toString().replaceRange(3, null, "")}", style: const TextStyle(color: Colors.white70)), minLeadingWidth: 13),
                      ListTile(title: const Text('Fixed Rate', style: TextStyle(color: Colors.white54)), trailing: Text("${detailAccount[0]['fixed_rate']}", style: const TextStyle(color: Colors.white70)), minLeadingWidth: 13),
                      ListTile(title: const Text('Currency', style: TextStyle(color: Colors.white54)), trailing: Text("${detailAccount[0]['currency']}", style: const TextStyle(color: Colors.white70)), minLeadingWidth: 13),
                      const ListTile(title: Text('Server', style: TextStyle(color: Colors.white54)), trailing: Text("DelapanBelas-Live", style: TextStyle(color: Colors.white70)), minLeadingWidth: 13),
                    ],
                  );
                case "transaksi":
                  return const NestedTabBar("TRANSAKSI");
                default:
                  return Center(
                    child: Text(
                      'This is the $label tab',
                      style: const TextStyle(fontSize: 36, color: Colors.white60),
                    ),
                  );
                }
              }
            ).toList()
          ),
        ),
      )
    );
  }
}

class NestedTabBar extends StatefulWidget {
  const NestedTabBar(this.outerTab, {super.key});

  final String outerTab;

  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        TabBar.secondary(
          controller: _tabController,
          tabs: const <Widget>[Tab(text: 'OPEN'), Tab(text: 'PENDING'), Tab(text: 'CLOSED')],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: List.generate(3, (i){
              if(i == 0){
                return ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return CustomListtile.openPosition(size: size, openTime: "2025-03-27 11:03:44", profit: 10);
                  },
                );
              }else if(i == 1){
                return ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return CustomListtile.openPosition(size: size, openTime: "2025-03-27 11:03:44", profit: -4);
                  },
                );
              }else{
                return ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return CustomListtile.openPosition(size: size, openTime: "2025-03-27 11:03:44", profit: 3);
                  },
                );
              }
            })
          ),
        ),
      ],
    );
  }
}