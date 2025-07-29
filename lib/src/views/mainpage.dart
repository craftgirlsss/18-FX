import 'package:delapanbelasfx/src/views/dashboard/accounts/index.dart';
import 'package:delapanbelasfx/src/views/dashboard/homes/index.dart';
import 'package:delapanbelasfx/src/views/dashboard/markets/markets_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/main.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard/setting/settings.dart';
// import 'dashboard/feeds/feeds.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>  with AutomaticKeepAliveClientMixin<MainPage>{
  AccountsController controllers = Get.find();

  List<Widget> menuItems = const[
    HomeNative(),
    AccountsV2(),
    MarketPage(),
    SettingsPage()
  ];
  
  Future<String?> getID()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id') ?? '';
  }

  @override
  void initState() {
    pageController = PageController(initialPage: selectedIndexGlobal.value);
    // getID().then((value) => print("ini getID() => $value"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ValueListenableBuilder(
      valueListenable: selectedIndexGlobal,
      builder: (context, value, child) => Scaffold(
        backgroundColor: GlobalVariablesType.backgroundColor,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          allowImplicitScrolling: true,
          onPageChanged: (index){
            setState(() {
              selectedIndexGlobal.value = index;
            });
          },
          children: menuItems
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.white54,
                width: 0.2
              )
            )
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: GlobalVariablesType.backgroundColor,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.red),
            child: BottomNavigationBar(
              items:  const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.newspaper_outlined, color: GlobalVariablesType.mainColor),
                  icon: Icon(Icons.newspaper_outlined, color: Colors.black26),
                  label: 'Beranda',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(Iconsax.card_outline, color: GlobalVariablesType.mainColor),
                  icon: Icon(Iconsax.card_outline, color: Colors.black26),
                  label: 'Accounts',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(HeroIcons.arrows_up_down, color: GlobalVariablesType.mainColor),
                  icon: Icon(HeroIcons.arrows_up_down, color:Colors.black26),
                  label: 'Quotes',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(CupertinoIcons.settings, color: GlobalVariablesType.mainColor),
                  icon: Icon(CupertinoIcons.settings, color: Colors.black26),
                  label: 'Settings',
                ),
              ],
              fixedColor: GlobalVariablesType.mainColor,
              currentIndex: selectedIndexGlobal.value,
              unselectedItemColor: Colors.black26,
              type: BottomNavigationBarType.fixed,
              unselectedIconTheme: const IconThemeData(color: Colors.black26),
              unselectedLabelStyle: const TextStyle(color: Colors.black26),
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(color:GlobalVariablesType.mainColor),
              showSelectedLabels: true,
              enableFeedback: true,
              onTap: (index) {
                selectedIndexGlobal.value = index;
                menuItems[selectedIndexGlobal.value];
                pageController.jumpToPage(selectedIndexGlobal.value);
              },
            ),
          ),
        ),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}