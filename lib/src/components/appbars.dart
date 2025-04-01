import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:icons_plus/icons_plus.dart';
import 'main_variable.dart';

AppBar kDefaultAppBarTitle({String? title, double? fontSize, bool? centerTitle}){
  return AppBar(
    elevation: GlobalVariablesType.elevation,
    centerTitle: centerTitle ?? false,
    backgroundColor: GlobalVariablesType.backgroundColor,
    automaticallyImplyLeading: GlobalVariablesType.autoImplyLeadingAppBarFalse,
    title: Text(title ?? GlobalVariablesType.titleSplashScreen!, style: kDefaultTextStyleTitleAppBar(fontSize: 18)),
  );
}

AppBar kDefaultAppBarCustom(context,{
  bool autoImplyLeading = true,
  List<Widget>? actions,
  Widget? title, double? fontSize, bool? centerTitle}){
  return AppBar(
    automaticallyImplyLeading: autoImplyLeading,
    elevation: GlobalVariablesType.elevation,
    centerTitle: centerTitle ?? false,
    backgroundColor: GlobalVariablesType.backgroundColor,
    leading: autoImplyLeading ? Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(CupertinoIcons.back, color: GlobalVariablesType.mainColor,)),
    ) : null,
    title: title,
    actions: actions,
  );
}

AppBar kDefaultAppBarGoBackOnly(context, {String? title}){
  return AppBar(
    title: Text(title ?? '', style: kDefaultTextStyleCustom(color: GlobalVariablesType.mainColor, fontSize: 15, fontWeight: FontWeight.bold),),
    centerTitle: true,
    elevation: GlobalVariablesType.elevation,
    backgroundColor: GlobalVariablesType.backgroundColor,
    leading: IconButton(
      onPressed: (){
        Navigator.pop(context);
      },
      icon:Icon(Icons.arrow_back_rounded, color: GlobalVariablesType.mainColor,)),
  );
}


class AppBarHomePage extends StatefulWidget {
  final String? urlImage;
  const AppBarHomePage({super.key, this.urlImage});

  @override
  State<AppBarHomePage> createState() => _AppBarHomePageState();
}

class _AppBarHomePageState extends State<AppBarHomePage> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return AppBar(
    backgroundColor: GlobalVariablesType.backgroundColor,
    leadingWidth: 60,
    elevation: 0,
    leading: Padding(
      padding: const EdgeInsets.only(left: 12),
      child: GestureDetector(
        onTap: (){},
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            // color: Colors.grey.withOpacity(0.2),
            color: Colors.transparent,
            shape: BoxShape.circle,
            image: widget.urlImage != null ? DecorationImage(image: NetworkImage(widget.urlImage!), fit: BoxFit.cover) : const DecorationImage(image: AssetImage('assets/images/default-picture.png'), fit: BoxFit.cover)
          ),
        ),
      ),
    ),
    title: GestureDetector(
      onTap: (){},
      child: Text("Saputra Budianto", style: kDefaultTextStyleTitleAppBar(fontSize: 17))),
    actions: [
      Stack(
        children: [
          IconButton(
            onPressed: (){
              setState(() {
                counter = counter + 1;
              });
              // print(counter);
            }, 
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.14),
                shape: BoxShape.circle
              ),
              child: Icon(CupertinoIcons.bell_solid, 
              color: GlobalVariablesType.buttonTextColor![1],),
            )),
          counter != 0 ? Positioned(
                right: 11,
                top: 11,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '$counter',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ) : Container()
        ],
      )
    ],
  );
  }
}


AppBar appBarHomePage(context, {String? name, String? urlPhoto, Function()? onPressedNotification, Function()? onPressedProfile, bool availableNotofication = false, InAppWebViewController? webViewController}){
  return AppBar(
    surfaceTintColor: Colors.transparent,
    backgroundColor: GlobalVariablesType.backgroundColor,
    leadingWidth: 60,
    elevation: 0,
    centerTitle: true,
    // leading: GestureDetector(
    //   onTap: onPressedProfile,
    //   child: Padding(
    //     padding: const EdgeInsets.only(left: 12),
    //     child: Container(
    //         width: 50,
    //         height: 50,
    //         decoration: BoxDecoration(
    //           // color: Colors.grey.withOpacity(0.2),
    //           color: Colors.transparent,
    //           shape: BoxShape.circle,
    //           image: urlPhoto != null ? DecorationImage(image: NetworkImage(urlPhoto), fit: BoxFit.cover) : const DecorationImage(image: AssetImage('assets/images/default-picture.png'), fit: BoxFit.cover)
    //         ),
    //       ),
    //     ),
    // ),
    actions: [
      IconButton(
        tooltip: "Refresh",
        onPressed: (){
          webViewController?.reload();
        },
        icon: const Icon(Clarity.refresh_line, size: 20)
      )
    ],
    title: GestureDetector(
      onTap: onPressedProfile,
      child: Text("Quotes", style: kDefaultTextStyleTitleAppBar(fontSize: 18))),
    // actions: [
    //   Stack(
    //     children: [
    //       IconButton(
    //             onPressed: onPressedNotification, 
    //             icon: Container(
    //               padding: const EdgeInsets.all(6),
    //               decoration: BoxDecoration(
    //                 color: GlobalVariablesType.mainColor.withOpacity(0.14),
    //                 shape: BoxShape.circle
    //               ),
    //               child: Icon(CupertinoIcons.bell_solid, 
    //               color: GlobalVariablesType.mainColor,),
    //             ),
    //         ),
    //       availableNotofication ? Positioned(
    //         right: 7,
    //         top: 7,
    //         child: Container(
    //           width: 10,
    //           height: 10,
    //           decoration: BoxDecoration(
    //             shape: BoxShape.circle,
    //             color: Colors.green.shade300,
    //           ),
    //         ),
    //       ) : Container()
    //     ],
    //   ),
    // ],
    bottom: PreferredSize(preferredSize: const Size.fromHeight(32), child: Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white30, width: 0.2),
        )
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Market", style: kDefaultTextStyleCustom(color: Colors.white60, fontSize: 15, fontWeight: FontWeight.bold),),
            Text("Bid", style: kDefaultTextStyleCustom(color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),),
            Text("Ask", style: kDefaultTextStyleCustom(color: Colors.green, fontSize: 15, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    )),
  );
}

class GlobalAppBar {
  static AppBar defaultAppBar({String? title, List<Widget>? actions, Color? iconColor}){
    return AppBar(
      forceMaterialTransparency: true,
      backgroundColor: Colors.black,
      elevation: 0,
      iconTheme: IconThemeData(color: iconColor ?? Colors.white60),
      title: Text(title ?? "App Bar", style: TextStyle(fontWeight: FontWeight.bold, color: iconColor ?? Colors.white60)),
      actions: actions,
    );
  }

  static AppBar appbarMainPage({List<Widget>? actions, Color? iconColor, Widget? leading}){
    return AppBar(
      backgroundColor: Colors.white,
      forceMaterialTransparency: true,
      elevation: 0,
      leadingWidth: 200,
      leading: leading,
      iconTheme: IconThemeData(color: iconColor ?? Colors.white60),
      actions: actions,
    );
  }


  static AppBar appbarMarket({var bottom, List<Widget>? actions, Color? iconColor, Widget? leading, double? toolbarHeight}){
    return AppBar(
      toolbarHeight: toolbarHeight,
      backgroundColor: Colors.white,
      forceMaterialTransparency: true,
      bottom: bottom,
      elevation: 0,
      leadingWidth: 200,
      leading: leading,
      iconTheme: IconThemeData(color: iconColor ?? Colors.white60),
      actions: actions,
    );
  }

  static AppBar appBarChatTab({var bottom, List<Widget>? actions, Color? iconColor, Widget? leading, double? toolbarHeight, String? title}){
    return AppBar(
      toolbarHeight: toolbarHeight,
      backgroundColor: Colors.white,
      forceMaterialTransparency: true,
      bottom: bottom,
      elevation: 0,
      title: const Text("Customer Service"),
      leading: leading,
      iconTheme: IconThemeData(color: iconColor ?? Colors.white60),
      actions: actions,
    );
  }
}