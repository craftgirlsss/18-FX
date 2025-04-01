import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/components/loadings.dart';
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textfields.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:delapanbelasfx/src/helpers/focus_manager.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailProfile extends StatefulWidget {
  const DetailProfile({super.key});

  @override
  State<DetailProfile> createState() => _DetailProfileState();
}

class _DetailProfileState extends State<DetailProfile> {
  AccountsController accountsController = Get.find();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressPlaceController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController birthDatePlaceController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  bool editing = false;
  
  // Image Picker from gallery
  XFile? _imageFile;
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
    await uploadImage(imagePath: _imageFile!.path);
  }

  bool checkingDataIsNull(){
    if(addressPlaceController.text == '' 
      || cityController.text == ''
      || birthDateController.text == ''
      || birthDatePlaceController.text == ''
      || zipController.text == ''){
      return true;
    }
    return false;
  }
  
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), (){
      String? tanggalLahir = accountsController.detailTempModel.value?.response.personalDetail.tglLahir;
      if(tanggalLahir == "0000-00-00 "){
        birthDateController.text = "";
      }else{
        birthDateController.text = accountsController.detailTempModel.value!.response.personalDetail.tglLahir!;
      }
    });
    addressPlaceController.text = accountsController.detailTempModel.value?.response.personalDetail.address ?? '';
    phoneController.text = accountsController.detailTempModel.value?.response.personalDetail.phone ?? '';
    cityController.text = accountsController.detailTempModel.value?.response.personalDetail.city ?? '';
    // birthDateController.text = accountsController.detailTempModel.value?.response.personalDetail.tanggalLahir == "0000-00-00" ? '' : DateFormat('EEEE, dd MMM yyyy').format(DateTime.parse(accountsController.detailTempModel.value!.response!.personalDetail.tanggalLahir!));
    birthDatePlaceController.text = accountsController.detailTempModel.value?.response.personalDetail.tmptLahir ?? '';
    idNumberController.text = accountsController.detailTempModel.value?.response.personalDetail.typeId ?? '';
    zipController.text = accountsController.detailTempModel.value?.response.personalDetail.zip ?? '';
  }

  Future<void> uploadImage({String? imagePath}) async {
    final url = Uri.parse('https://api.dbsolution.app/avatar');
    final request = http.MultipartRequest('POST', url)
      ..headers.addAll({
        'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
        'Content-Type': 'application/x-www-form-urlencoded'
      })
      ..fields['id'] = accountsController.detailTempModel.value!.response.personalDetail.id!
      ..files.add(await http.MultipartFile.fromPath('avatar', imagePath!));
    final response = await request.send();
    if(kDebugMode){
      print("ini id di upload function ${accountsController.detailTempModel.value!.response.personalDetail.id!}");
      print("ini path file di upload function $imagePath");
    }
    if(response.statusCode == 200){
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      if(kDebugMode) print(jsonMap);
    }else{
      if(kDebugMode)print("ini response upload image ${response.statusCode}");
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    cityController.dispose();
    birthDateController.dispose();
    birthDatePlaceController.dispose();
    idNumberController.dispose();
    zipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: focusManager,
      child: Scaffold(
        backgroundColor: GlobalVariablesType.backgroundColor,
        appBar: kDefaultAppBarCustom(
          context, 
          title: Text(GlobalVariablesType.profileku),
          centerTitle: true,
          actions: [
            CupertinoButton(child: Text("Update", style: TextStyle(color: GlobalVariablesType.mainColor)), onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? password = prefs.getString('password');
               if(await accountsController.editProfile(
                 city: cityController.text,
                 address: addressPlaceController.text,
                 idNumber: idNumberController.text,
                 tanggalLahir: birthDateController.text,
                 tempatLahir: birthDatePlaceController.text,
                 zip: zipController.text,
               ) == true){
                 await accountsController.login(
                   email: accountsController.detailTempModel.value?.response.personalDetail.email,
                   password: password,
                   savedSessionLogin: true
                 ).then((value) {
                   Get.snackbar("Berhasil", "Berhasil ubah data profile", backgroundColor: Colors.white, colorText: Colors.black87);
                   Navigator.pop(context);
                 });
               }
            })
           // checkingDataIsNull() == false ? Container() : Obx(
           //    () => IconButton(
           //      onPressed: accountsController.isLoading.value ? (){} : () async {
           //        SharedPreferences prefs = await SharedPreferences.getInstance();
           //        String? password = prefs.getString('password');
           //      if(await accountsController.editProfile(
           //        city: cityController.text,
           //        address: addressPlaceController.text,
           //        idNumber: idNumberController.text,
           //        idType: idTypeController.text,
           //        tanggalLahir: birthDateController.text,
           //        tempatLahir: birthDatePlaceController.text,
           //        zip: zipController.text,
           //      ) == true){
           //        await accountsController.login(
           //          email: accountsController.detailTempModel.value?.response?.personalDetail.email,
           //          password: password,
           //          savedSessionLogin: true
           //        ).then((value) {
           //          Get.snackbar("Berhasil", "Berhasil ubah data profile", backgroundColor: Colors.white, colorText: Colors.black87);
           //          Navigator.pop(context);
           //        });
           //      }
           //    }, icon: const Icon(CupertinoIcons.floppy_disk)),
           //  )
          ]
        ),
        body: RefreshIndicator(
          onRefresh: () async {

          },
          child: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.transparent,
                    child: Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.05),
                              image: _imageFile == null ? accountsController.detailTempModel.value?.response.personalDetail.urlPhoto != null ? accountsController.detailTempModel.value?.response.personalDetail.urlPhoto == "-" ? const DecorationImage(image: AssetImage('assets/images/ic_launcher.png')) :  DecorationImage(image: NetworkImage(accountsController.detailTempModel.value!.response.personalDetail.urlPhoto!), fit: BoxFit.cover) : const DecorationImage(image: AssetImage('assets/images/empty_image.png'), fit: BoxFit.cover) : DecorationImage(image: FileImage(File(_imageFile!.path)), fit: BoxFit.cover)
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: (){
                                // Get.to(() => const StepperTrialPage());
                                pickImage();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black26, width: 0.5),
                                  color: GlobalVariablesType.mainColor
                                ),
                                child: const Icon(CupertinoIcons.camera, color: Colors.black),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Obx(() => Text(accountsController.detailTempModel.value?.response.personalDetail.name ?? "Unknown Name", textAlign: TextAlign.center, style: kDefaultTextStyleCustom(fontSize: 16, fontWeight: FontWeight.bold))),
                  const SizedBox(height: 2),
                  Obx(() => Text(accountsController.detailTempModel.value?.response.personalDetail.email ?? "unknonwn email", textAlign: TextAlign.center, style: kDefaultTextStyleCustom(color: Colors.white, fontWeight: FontWeight.normal),)),
                  const SizedBox(height: 20),
                  AnyTextField(
                    // enable: false,
                    labelText: "Phone Number",
                    // readOnly: true,
                    iconData: Icons.phone,
                    controller: phoneController,
                    hintText: "Phone Number",
                  ),
                  const SizedBox(height: 10),
                  AnyTextField(
                    // enable: accountsController.detailTempModel.value?.response?.personalDetail.city == null || accountsController.detailTempModel.value?.response?.personalDetail.city == '' ? true : false,
                    labelText: "City",
                    iconData: Icons.location_city_rounded,
                    // readOnly: editing == true ? accountsController.detailTempModel.value?.response?.personalDetail.city == null || accountsController.detailTempModel.value?.response?.personalDetail.city == '' ? true : false : false,
                    controller: cityController,
                    hintText: "City",
                  ),
                  const SizedBox(height: 10),
                  AnyTextField(
                    // enable: accountsController.detailTempModel.value?.response?.personalDetail.address == null || accountsController.detailTempModel.value?.response?.personalDetail.address == '' ? true : false,
                    labelText: "Full Address",
                    iconData: CupertinoIcons.placemark_fill,
                    // readOnly: editing == true ? accountsController.detailTempModel.value?.response?.personalDetail.address == null || accountsController.detailTempModel.value?.response?.personalDetail.address == '' ? true : false : false,
                    controller: addressPlaceController,
                    hintText: "Full Address",
                  ),
                  const SizedBox(height: 10),
                  TextEditingOptionSelect(
                    iconData: Clarity.calendar_solid,
                    // enable: accountsController.detailTempModel.value?.response?.personalDetail.tanggalLahir == null || accountsController.detailTempModel.value?.response?.personalDetail.tanggalLahir == '' ? true : false,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2000), //get today's date
                        firstDate:DateTime(1960), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime.now()
                      );
                      if(pickedDate != null ){
                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                        setState(() {
                            birthDateController.text = formattedDate; //set foratted date to TextField value.
                        });
                      }else{
                          Get.snackbar("Failed", "Please choose your birthdate", backgroundColor: Colors.white);
                      }
                    },
                    labelText: "Date Birth",
                    // readOnly: editing ? accountsController.detailTempModel.value?.response?.personalDetail.tanggalLahir == null || accountsController.detailTempModel.value?.response?.personalDetail.tanggalLahir == '' ? true : false : false,
                    controller: birthDateController,
                    hintText: "Date Birth",
                  ),
                  const SizedBox(height: 10),
                  AnyTextField(
                    iconData: CupertinoIcons.placemark_fill,
                    // enable: accountsController.detailTempModel.value?.response?.personalDetail.tempatLahir == null || accountsController.detailTempModel.value?.response?.personalDetail.tempatLahir == '' ? true : false,
                    labelText: "Birth Place",
                    // readOnly: editing == true ? accountsController.detailTempModel.value?.response?.personalDetail.tempatLahir == null || accountsController.detailTempModel.value?.response?.personalDetail.tempatLahir == '' ? true : false : false,
                    controller: birthDatePlaceController,
                    hintText: "Birth Place",
                  ),
                  const SizedBox(height: 10),
                  AnyTextField(
                    // enable: accountsController.detailTempModel.value?.response?.personalDetail.typeNumber == null || accountsController.detailTempModel.value?.response?.personalDetail.typeNumber == '' ? true : false,
                    withLength: true,
                    iconData: Iconsax.card_bold,
                    maxLength: accountsController.detailTempModel.value?.response.personalDetail.idNumber == null || accountsController.detailTempModel.value?.response.personalDetail.idNumber == '' ? 16 : null,
                    labelText: "ID Number (KTP)",
                    // readOnly: editing == true ? accountsController.detailTempModel.value?.response?.personalDetail.typeNumber == null || accountsController.detailTempModel.value?.response?.personalDetail.typeNumber == '' ? true : false : false,
                    controller: idNumberController,
                    hintText: "ID Number (KTP)",
                  ),
                  const SizedBox(height: 10),
                  AnyTextField(
                    // enable: accountsController.detailTempModel.value?.response?.personalDetail.zip == null || accountsController.detailTempModel.value?.response?.personalDetail.zip == '0' ? true : false,
                    withLength: true,
                    iconData: Clarity.map_solid_badged,
                    maxLength: accountsController.detailTempModel.value?.response.personalDetail.zip == null || accountsController.detailTempModel.value?.response.personalDetail.zip == '0' ? 5 : null,
                    labelText: "ZIP Code",
                    // readOnly: editing == true ? accountsController.detailTempModel.value?.response?.personalDetail.zip == null || accountsController.detailTempModel.value?.response?.personalDetail.zip == '0' ? true : false : false,
                    controller: zipController,
                    hintText: "ZIP Code",
                  ),
                ],
              ),
              Obx(() => accountsController.isLoading.value == true
              ? floatingLoading()
              : const SizedBox()),
            ],
          ),
        ),
      ),
    );
  }

  // Future editProfilePhoto({String? urlImage}) async {
  //   try {
  //     var headers = {
  //       'x-api-key': 'fewAHdSkx28301294cKSnczdAs',
  //       'Content-Type': 'application/x-www-form-urlencoded'
  //     };
  //     var request = http.MultipartRequest('POST',
  //         Uri.parse('https://api-crm.techcrm.net/v1/ibf/Auth/change_avatar'));
  //     request.headers.addAll(headers);
  //     request.fields.addAll({'id': accountsController.detailTempModel.value!.response!.personalDetail.id!});
  //     request.files.add(await http.MultipartFile.fromPath('avatar', urlImage!));
  //     http.StreamedResponse response = await request.send();

  //     if (response.statusCode == 200) {
  //       Get.snackbar("Berhasil", "Berhasil merubah foto profil",
  //           backgroundColor: Colors.green,
  //           colorText: Colors.white,
  //           duration: const Duration(seconds: 1));
  //     } else {
  //       Get.snackbar("Gagal",
  //           "Gagal merubah foto profile karna kode ${response.statusCode}",
  //           backgroundColor: Colors.red.shade400,
  //           colorText: Colors.white,
  //           duration: const Duration(seconds: 1));
  //     }
  //   } catch (e) {
  //     Get.snackbar("Gagal", "Gagal merubah foto profile karna ${e.toString()}",
  //         backgroundColor: Colors.red.shade400,
  //         colorText: Colors.white,
  //         duration: const Duration(seconds: 1));
  //   }
  // }
}