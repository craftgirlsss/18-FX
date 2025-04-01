import 'package:delapanbelasfx/src/components/cards_button.dart';
import 'package:delapanbelasfx/src/components/loadings.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/controllers/utils_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class DocumentsAccount extends StatefulWidget {
  final String? loginID;
  const DocumentsAccount({super.key, this.loginID});

  @override
  State<DocumentsAccount> createState() => _DocumentsAccountState();
}

class _DocumentsAccountState extends State<DocumentsAccount> {
  DateTime now = DateTime.now();
  UtilsController utilsController = Get.put(UtilsController());

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, (){
      utilsController.downloadDocuments(id: "1049203").then((bool result){
        if(kDebugMode) print(result);
        if(!result) Get.snackbar("Gagal", utilsController.responseMessage.value, backgroundColor: Colors.red, colorText: Colors.white);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text("Daftar Dokumen"),
            ),
            body: RefreshIndicator(
              color: GlobalVariablesType.mainColor,
              backgroundColor: Colors.black,
              onRefresh: () async {
                utilsController.downloadDocuments();
              },
              child: Obx(
                () => utilsController.documentModels.value?.response == null 
                ? ListView(
                  children: [
                    SizedBox(
                      width: size.width,
                      height: size.height / 1.3,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(AntDesign.file_pdf_outline, size: 35, color: Colors.white),
                          SizedBox(height: 5),
                          Text("Dokumen tidak tersedia", style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                  ],
                ) 
                : ListView(
                  padding: const EdgeInsets.all(10),
                  children: List.generate(utilsController.documentModels.value?.response.length ?? 0, (i){
                    if(utilsController.documentModels.value!.response.isEmpty){
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.file_download_off_outlined, size: 35, color: Colors.white),
                            Text("Dokumen tidak tersedia")
                          ],
                        ),
                      );
                    }
                    return CardsButton.cardDocument(
                      size: size,
                      dateCreated: "2025-03-10",
                      documentTitle: utilsController.documentModels.value?.response[i].title,
                      onPressed: (){}
                    );
                  }),
                ),
              ),
            ),
          ),
          Obx(() => utilsController.isLoading.value ? floatingLoading() : const SizedBox())
        ],
      ),
    );
  }
}