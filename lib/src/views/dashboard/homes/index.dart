import 'package:country_flags/country_flags.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:delapanbelasfx/src/components/cards_button.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/pie_chart.dart';
import 'package:delapanbelasfx/src/controllers/utils_controller.dart';
import 'package:delapanbelasfx/src/helpers/annotated_region.dart';
import 'package:delapanbelasfx/src/helpers/url_launchers.dart';
import 'package:delapanbelasfx/src/views/dashboard/homes/detail_news.dart';
import 'package:delapanbelasfx/src/views/dashboard/setting/detail_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeNative extends StatefulWidget {
  const HomeNative({super.key});

  @override
  State<HomeNative> createState() => _HomeNativeState();
}

class _HomeNativeState extends State<HomeNative> with SingleTickerProviderStateMixin{
  late TabController tabController;
  RxInt selectedPromoIndex = 0.obs;
  RxBool showInfoAndPromo = false.obs;
  RxBool showNewsInfo = false.obs;
  PageController pageControllerPromo = PageController();
  UtilsController utilsController = Get.put(UtilsController());

  RxList bannerPhoto = [
    'assets/images/1.jpg',
    'assets/images/2.jpg'
  ].obs;

  List<Map<String, String>> dataMarket = [
    {
      "market" : "USDJPY",
      "flag_pair" : "US",
      "flag_paired" : "JP" 
    },
    {
      "market" : "USDCAD",
      "flag_pair" : "US",
      "flag_paired" : "CA" 
    },
    {
      "market" : "EURUSD",
      "flag_pair" : "NZ",
      "flag_paired" : "US" 
    },
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    Future.delayed(Duration.zero, () async {
      await utilsController.getImageSlider().then((result){
        if(result){
          showInfoAndPromo(true);
        }
      });
      await utilsController.getListNewsAPI().then((result){
        if(result){
          showNewsInfo(true);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return defaultAnnotatedRegion(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: GlobalVariablesType.backgroundColor,
          appBar: GlobalAppBar.appbarMainPage(
            actions: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: (){},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(20)),
                  child: const Row(
                    children: [
                      Icon(EvaIcons.gift, color: Colors.white, size: 17),
                      SizedBox(width: 5),
                      Text("Panen Cuan", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 11))
                    ],
                  ),
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(CupertinoIcons.bell, color: Colors.black), onPressed: (){}
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(CupertinoIcons.profile_circled, color: Colors.black), onPressed: (){
                  Get.to(() => const DetailProfile());
                }
              ),
            ],
            leading: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/ic_launcher.png'),
                  ),
                ],
              )
            )
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Trading Signal TridentPRO", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: (){},
                        child: const Text("Lihat Semua", style: TextStyle(fontSize: 14, color: Colors.black45),))
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  padding: const EdgeInsets.only(right: 15, top: 15, bottom: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 20),
                    ]
                  ),
                  child: Column(
                    children: List.generate(dataMarket.length, (index) => marketItem(
                      marketName: dataMarket[index]['market'],
                      flagPair: dataMarket[index]['flag_pair'],
                      flagPaired: dataMarket[index]['flag_paired']
                    )),
                  ),
                ),

                //Info dan Promo
                Obx(
                  () => showInfoAndPromo.value ? Container(
                    width: size.width,
                    color: GlobalVariablesType.backgroundColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Info dan Promo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: (){},
                                child: const Text("Lihat Semua", style: TextStyle(fontSize: 14, color: Colors.black54),)),
                            ],
                          ),
                        ),
                  
                        SizedBox(
                        width: size.width,
                        height: size.width / 2.1,
                        child: Obx(
                          () => PageView.builder(
                            controller: pageControllerPromo,
                            physics: const BouncingScrollPhysics(),
                            pageSnapping: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: utilsController.responseImageSlider.value?.response.length,
                            onPageChanged: (value) {
                              selectedPromoIndex(value);
                            },
                            itemBuilder: (context, index) {
                              return CupertinoButton(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                onPressed: (){
                                  launchUrls(utilsController.responseImageSlider.value!.response[index].link!);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(image: NetworkImage(utilsController.responseImageSlider.value!.response[index].picture!),
                                    fit: BoxFit.cover
                                    ),
                                  )),
                                ).marginZero.paddingZero;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => Center(
                            child: SmoothPageIndicator(
                              controller: pageControllerPromo,
                              count: utilsController.responseImageSlider.value!.response.length,
                              effect: const WormEffect(
                                dotHeight: 5,
                                dotWidth: 20,
                                dotColor: Colors.black12,
                                type: WormType.thinUnderground,
                                activeDotColor: GlobalVariablesType.mainColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ) : const SizedBox(),
                ),
                const SizedBox(height: 20),

                Obx(
                  () => showNewsInfo.value ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("News Sentiment", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: (){},
                              child: const Text("Lihat Semua", style: TextStyle(fontSize: 14, color: Colors.black54),)),
                          ],
                        ),
                      ),
                  
                      Obx(
                        () => Column(
                          // children: List.generate(utilsController.newsModels.value!.response.length, (index) => widgetNewsSentiment()),
                          children: List.generate(
                            utilsController.newsModels.value!.response.length, 
                            (index) => CardsButton.cardNews(
                              author: utilsController.newsModels.value?.response[index].author,
                              title: utilsController.newsModels.value?.response[index].title,
                              urlImage: utilsController.newsModels.value?.response[index].picture,
                              onPressed: (){
                                Get.to(() => DetailNews(
                                  viewer: '12',
                                  date: DateFormat('MMMM, dd yyyy').format(utilsController.newsModels.value?.response[index].tanggal != null ? DateTime.parse(utilsController.newsModels.value!.response[index].tanggal!) : DateTime.now()),
                                  content: utilsController.newsModels.value?.response[index].message,
                                  title: utilsController.newsModels.value?.response[index].title,
                                  newsImage: utilsController.newsModels.value?.response[index].picture,
                                ));
                              }
                            )
                          ),
                        ),
                      ),
                    ],
                  ) : const SizedBox(),
                )
                //News Sentiment
              ],
            ),
          ),
        ),
      )
    );
  }

  // Market Item
  Container marketItem({String? marketName, String? flagPair, String? flagPaired}){
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Flag
                Row(
                  children: [
                    Stack(
                      children: [
                        CountryFlag.fromCountryCode(
                          flagPair ?? 'US',
                          width: 35,
                          shape: const Circle(),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: CountryFlag.fromCountryCode(
                            flagPaired ?? 'JP',
                            width: 25,
                            shape: const Circle(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(marketName ?? "USDJPY", style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold, color: Colors.black)),
                        const Text("2 hour(s) ago", style: TextStyle(fontSize: 10, color: Colors.black54))
                      ],
                    )
                  ],
                ),

                //take profit
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Take Profit", style: TextStyle(fontSize: 9, color: Colors.black)),
                    Text("152.0", style: TextStyle(fontSize: 11, color: Colors.black54))
                  ],
                ),

                //stop loss
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Stop Loss", style: TextStyle(fontSize: 9, color: Colors.black)),
                    Text("152.15", style: TextStyle(fontSize: 11, color: Colors.black54))
                  ],
                ),

                //potensi cuan
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Potensi Cuan", style: TextStyle(fontSize: 9, color: Colors.black)),
                    Text("\$533", style: TextStyle(fontSize: 11, color: Colors.black54))
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 7, right: 20, top: 8, bottom: 8),
                  decoration: const BoxDecoration(
                    color: GlobalVariablesType.mainColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: const Text("Buy on 70.0% of probabilities by Trading Central", style: TextStyle(fontSize: 9, color: Colors.white60)),
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                height: 35,
                width: 80,
                child: CupertinoButton(
                  borderRadius: BorderRadius.circular(30),
                  padding: EdgeInsets.zero,
                  color: GlobalVariablesType.mainColor,
                  child: const Text("Buy", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)), onPressed: (){}),
              )
            ],
          ),
          const Divider(thickness: 0.5)
        ],
      ),
    );
  }


  Container widgetNewsSentiment({String? marketName, String? flagPair, String? flagPaired}){
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(AntDesign.gold_fill, color: Colors.orangeAccent),
                      const SizedBox(width: 3),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(marketName ?? "XAUUSD", style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold, color: Colors.black)),
                          Text(marketName ?? "Gold vs US Dollar", style: const TextStyle(fontSize: 10, color: Colors.black54)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text("Saat ini sentiment berita adalah 96% Sell", style: TextStyle(fontSize: 10, color: Colors.black54)),
                  const SizedBox(height: 8),
                  Container(
                    width: 80,
                    height: 3,
                    color: Colors.red,
                  )
                ],
              ),
              PieChart(
                data: const [
                  PieChartData(Colors.purple, 60),
                  PieChartData(Colors.blue, 25),
                  PieChartData(Colors.orange, 15),
                ],
                radius: 40,
              ),
            ],
          ),
          const Divider(thickness: 0.5)
        ],
      )
    );
  }



  Widget tabSection(BuildContext context) {
  return DefaultTabController(
    length: 2,
    child: Column(
      children: <Widget>[
        Container(
          color: Colors.transparent,
          child: const TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextStyle(),
            unselectedLabelColor: Colors.black38,
            tabs: [
              Tab(text: "Berita"),
              Tab(text: "Bulettin"),
            ]),
        ),
        Container(
          color: Colors.transparent,
          height: 200,
          child: TabBarView(
            children: [
              Container(
                color: Colors.transparent,
                width: double.infinity,
                height: double.infinity,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesome.newspaper),
                      Text("Tidak ada Berita"),
                    ],
                  )
                ),
              ),
              Container(
                color: Colors.transparent,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Clarity.bullet_list_line),
                      Text("Tidak ada Bulletin"),
                    ],
                  )
                ),
              ),
          ]),
        ),
      ],
    ),
  );
}
}