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
              items:  <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  activeIcon: Icon(TeenyIcons.home, color: GlobalVariablesType.mainColor, size: 20),
                  icon: const Icon(OctIcons.home, color: Color.fromARGB(255, 93, 93, 91)),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.candlestick_chart, color: GlobalVariablesType.mainColor),
                  icon: const Icon(Icons.candlestick_chart_outlined, color: Color.fromARGB(255, 93, 93, 91)),
                  label: 'Accounts',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(CupertinoIcons.arrow_up_arrow_down, color: GlobalVariablesType.mainColor),
                  icon: const Icon(CupertinoIcons.arrow_up_arrow_down, color:Color.fromARGB(255, 93, 93, 91)),
                  label: 'Quotes',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(CupertinoIcons.settings, color: GlobalVariablesType.mainColor),
                  icon: const Icon(CupertinoIcons.settings, color: Color.fromARGB(255, 93, 93, 91)),
                  label: 'Settings',
                ),
              ],
              fixedColor: GlobalVariablesType.mainColor,
              currentIndex: selectedIndexGlobal.value,
              unselectedItemColor: const Color.fromARGB(255, 93, 93, 91),
              type: BottomNavigationBarType.fixed,
              unselectedIconTheme: const IconThemeData(color: Colors.black38),
              unselectedLabelStyle: const TextStyle(color: Color.fromARGB(255, 93, 93, 91)),
              showUnselectedLabels: true,
              selectedLabelStyle: TextStyle(color:GlobalVariablesType.mainColor),
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