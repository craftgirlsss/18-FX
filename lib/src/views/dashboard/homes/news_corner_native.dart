import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:delapanbelasfx/src/controllers/utils_controller.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NewsCornerNativePage extends StatefulWidget {
  final String? id;
  const NewsCornerNativePage({super.key, this.id});

  @override
  State<NewsCornerNativePage> createState() => _NewsCornerNativePageState();
}

class _NewsCornerNativePageState extends State<NewsCornerNativePage> {
  UtilsController utilsController = Get.put(UtilsController());
  getNews(){
    Future.delayed(Duration.zero, (){
      utilsController.getDetailsNewsAPI(id: widget.id);
    });
  }

  @override
  void initState() {
    getNews();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariablesType.backgroundColor,
      appBar: kDefaultAppBarCustom(context, autoImplyLeading: true, title: const Text("News Corener")),
      body: Obx(() =>
      Skeletonizer(
        containersColor: Colors.grey.shade800,
        enabled: utilsController.isLoading.value,
        child: utilsController.newsDetailModels.value == null ? const Text("Tidak ada data") : SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text(utilsController.newsDetailModels.value?.response.title ?? "Tidak ada judul", textAlign: TextAlign.center, style: kDefaultTextStyleCustom(fontSize: 19),)),
              const SizedBox(height: 30),
              utilsController.newsDetailModels.value!.response.picture == null ? Container(
                margin: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                height: 150,
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.white54, width: 0.2),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, color: Colors.white),
                      const SizedBox(height: 4),
                      Text("Tidak dapat memuat gambar", style: kDefaultTextStyleCustom(),)
                    ],
                  ),
                ),
              ) : Image.network(utilsController.newsDetailModels.value!.response.picture!, errorBuilder: (context, error, stackTrace) => 
              Container(
                margin: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                height: 150,
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.white54, width: 0.2),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, color: Colors.white),
                      const SizedBox(height: 4),
                      Text("Tidak dapat memuat gambar", style: kDefaultTextStyleCustom(),)
                    ],
                  ),
                ),
              )),
              const SizedBox(height: 20),
              Text(utilsController.newsDetailModels.value?.response.message != null ? utilsController.newsDetailModels.value!.response.message!.replaceAll('\\r\\n', ' ') : "Tidak ada konten", textAlign: TextAlign.justify, style: kDefaultTextStyleCustom(fontSize: 14, fontWeight: FontWeight.normal)),
              Padding(
                padding: const EdgeInsets.only(top: 20.0,bottom: 3),
                child: Row(
                  children: [
                    Text("Author : ", style: kDefaultTextStyleCustom(fontSize: 14)),
                    Text(utilsController.newsDetailModels.value?.response.author ?? 'Unknown', style: const TextStyle(color: CupertinoColors.activeBlue, fontStyle: FontStyle.italic, fontSize: 14)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Row(
                  children: [
                    Text("Date Released : ", style: kDefaultTextStyleCustom(fontSize: 14)),
                    Text(DateFormat('dd MMM yyyy').add_jms().format(DateTime.now()), style: const TextStyle(color: CupertinoColors.activeBlue, fontStyle: FontStyle.italic, fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ))
      // Obx(
      //   () => Skeletonizer(
      //       enabled: utilsController.isLoading.value ? true : false,
      //       ignoreContainers: true,
      //       child: ListView.builder(
      //         itemCount: 5,
      //         itemBuilder: (context, index) => Card(
      //               child: ListTile(
      //                 tileColor: Colors.black12,
      //                 title: Text("Hello", style: kDefaultTextStyleCustom(fontSize: 15),),
      //                 subtitle: Text("World", style: kDefaultTextStyleCustom(fontSize: 15),),
      //               ),
      //             ),
      //       ),
      //     ),
      // ),
    );
  }
}