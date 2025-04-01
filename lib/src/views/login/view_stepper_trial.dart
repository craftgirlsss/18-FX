import 'package:delapanbelasfx/src/components/alerts.dart';
import 'package:delapanbelasfx/src/helpers/phone_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/components/action_sheet.dart';
import 'package:delapanbelasfx/src/components/list_bank.dart';
import 'package:delapanbelasfx/src/components/loadings.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textfields.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';
import 'package:delapanbelasfx/src/controllers/register_controller.dart';
import 'package:delapanbelasfx/src/helpers/focus_manager.dart';
import 'package:delapanbelasfx/src/views/login/login.dart';
import 'package:delapanbelasfx/src/views/login/stepper_components_trial.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// import 'content_4.dart';

class StepperTrialPage extends StatefulWidget {
  final int? currentStep;
  final bool? fromLogin;
  final bool? loginWithGoogle;
  final bool? registerWithGoogle;
  final String? name;
  final String? phone;
  final String? email;
  final bool? normalyRegisteredProcess;
  const StepperTrialPage({super.key, this.currentStep, this.fromLogin, this.loginWithGoogle, this.registerWithGoogle, this.name, this.phone, this.email, this.normalyRegisteredProcess});

  @override
  State<StepperTrialPage> createState() => _StepperTrialPageState();
}

class _StepperTrialPageState extends State<StepperTrialPage> {
  final _formKey = GlobalKey<FormState>();
  AccountsController accountsController = Get.find();
  RegisterController registerController = Get.put(RegisterController());
  DateTime date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  RxInt selectedCountryIndex = 95.obs;
  PhoneUtils phoneUtils = PhoneUtils();

  // Controller form 1
  TextEditingController fullNameContrller = TextEditingController();
  TextEditingController emailContrller = TextEditingController();
  TextEditingController noHPController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressContrller = TextEditingController();
  TextEditingController countryContrller = TextEditingController();
  TextEditingController genderContrller = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  // Controller form 2
  int initialItem = 6;
  bool additionalBank = false;
  TextEditingController bankNameController = TextEditingController();
  TextEditingController bankName2Controller = TextEditingController();
  TextEditingController bankAccountNameController = TextEditingController();
  TextEditingController bankAccountName2Controller = TextEditingController();
  TextEditingController bankAccountTypeController = TextEditingController();
  TextEditingController bankAccountType2Controller = TextEditingController();
  TextEditingController bankAccountNumberController = TextEditingController();
  TextEditingController bankAccountNumber2Controller = TextEditingController();
  TextEditingController bankBranchController = TextEditingController();
  TextEditingController bankBranch2Controller = TextEditingController();

  // Controller form 3
  int initialItem3 = 2;
  TextEditingController birthDateController = TextEditingController();
  TextEditingController birthPlaceController = TextEditingController();
  TextEditingController idTypeController = TextEditingController();
  TextEditingController idPersonalController = TextEditingController();
  bool wasSelectIDType = false;

  RxString urlKTPImage = "".obs;
  RxString urlSelfiImage = "".obs;

  int? currentStep = 1;
  int stepLength = 3;
  bool? complete;

  next() {
    if (currentStep! <= stepLength) {
      goTo(currentStep! + 1);
    }
  }

  back() {
    if (currentStep! > 1) {
      goTo(currentStep! - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
    if (currentStep! > stepLength) {
      setState(() => complete = true);
    }
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.currentStep ?? 1;
    emailContrller.text = widget.email ?? "Unknown Email";
    fullNameContrller.text = widget.name ?? "Unknown Name";
    noHPController.text = widget.phone ?? accountsController.detailTempModel.value?.response.personalDetail.phone ?? "62";
    bankAccountNameController.text = accountsController.detailTempModel.value?.response.personalDetail.name ?? "";
    cityController.text = accountsController.detailTempModel.value?.response.personalDetail.city ?? "";
    addressContrller.text = accountsController.detailTempModel.value?.response.personalDetail.address ?? "";
    countryContrller.text = accountsController.detailTempModel.value?.response.personalDetail.country ?? "";
    genderContrller.text = accountsController.detailTempModel.value?.response.personalDetail.gender ?? "";
    zipCodeController.text = accountsController.detailTempModel.value?.response.personalDetail.zip ?? "";
    birthDateController.text = (accountsController.detailTempModel.value?.response.personalDetail.tglLahir == "0000-00-00 " || accountsController.detailTempModel.value?.response.personalDetail.tglLahir == null ? '' : accountsController.detailTempModel.value?.response.personalDetail.tglLahir)!;
    birthPlaceController.text = accountsController.detailTempModel.value?.response.personalDetail.tmptLahir ?? "";
  }

  @override
  void dispose() {
    fullNameContrller.dispose();
    emailContrller.dispose();
    noHPController.dispose();
    cityController.dispose();
    addressContrller.dispose();
    genderContrller.dispose();
    zipCodeController.dispose();
    countryContrller.dispose();
    bankName2Controller.dispose();
    bankAccountNumber2Controller.dispose();
    bankNameController.dispose();
    bankAccountNumberController.dispose();
    bankAccountName2Controller.dispose();
    bankAccountNameController.dispose();
    bankAccountTypeController.dispose();
    bankAccountType2Controller.dispose();
    birthDateController.dispose();
    birthPlaceController.dispose();
    idTypeController.dispose();
    idPersonalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        GestureDetector(
          onTap: () => focusManager(),
          child: Scaffold(
            backgroundColor: GlobalVariablesType.backgroundColor,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    NumberStepper(
                      totalSteps: stepLength,
                      width: MediaQuery.of(context).size.width,
                      curStep: currentStep,
                      stepCompleteColor: GlobalVariablesType.mainColor,
                      currentStepColor: const Color(0xffdbecff),
                      inactiveColor: const Color(0xffbababa),
                      lineWidth: 3.5,
                      nameStep: const ["Personal", "Payment", "Addtional"],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    if(currentStep! <= stepLength)
                      if(currentStep == 1)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text("Informasi Personal", style: kDefaultTextStyleCustom(fontSize: 20, fontWeight: FontWeight.bold),),
                                ),
                                NameTextField(
                                  hintText: "Input your name",
                                  labelText: "Nama Lengkap",
                                  readOnly: true,
                                  controller: fullNameContrller,
                                ),
                                EmailTextField(
                                  hintText: "Input your email",
                                  labelText: "Alamat Email",
                                  readOnly: true,
                                  controller: emailContrller,
                                ),
                                PhoneTextField(
                                  hintText: "required",
                                  forOTP: false,
                                  readOnly: widget.normalyRegisteredProcess == true ? true : false,
                                  labelText: "Nomor HP",
                                  controller: noHPController,
                                ),
                                AnyTextField(
                                  iconData: Clarity.building_solid,
                                  hintText: "optional",
                                  labelText: "Kota",
                                  controller: cityController,
                                ),
                                AnyTextField(
                                  iconData: CupertinoIcons.placemark_fill,
                                  hintText: "optional",
                                  labelText: "Alamat Lengkap",
                                  controller: addressContrller,
                                ),
                                AnyTextField(
                                  iconData: Clarity.flag_solid,
                                  onPressed: (){
                                    showCupertinoModalPopup<void>(
                                      context: context,
                                      builder: (BuildContext context) => Container(
                                        height: 216,
                                        padding: const EdgeInsets.only(top: 6.0),
                                        margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                        color: CupertinoColors.black,
                                        child: SafeArea(
                                          top: false, 
                                          child: CupertinoPicker(
                                            magnification: 1.22,
                                            squeeze: 1.2,
                                            useMagnifier: true,
                                            itemExtent: 32.0,
                                            scrollController: FixedExtentScrollController(initialItem: selectedCountryIndex.value),
                                            onSelectedItemChanged: (int selectedItem) {
                                              selectedCountryIndex(selectedItem);
                                              countryContrller.text = phoneUtils.countryCode[selectedCountryIndex.value]['country'];
                                            },
                                            children: List<Widget>.generate(phoneUtils.countryCode.length, (int index) {
                                              return Center(child: Text("${phoneUtils.countryCode[index]['country']}", style: const TextStyle(color: Colors.white),));
                                            }),
                                          )
                                        ),
                                      ),
                                    );
                                  },
                                  hintText: "optional",
                                  readOnly: true,
                                  labelText: "Negara",
                                  controller: countryContrller,
                                ),
                                AnyTextField(
                                  iconData: CupertinoIcons.placemark_fill,
                                  hintText: "optional",
                                  labelText: "Tempat Lahir",
                                  controller: birthPlaceController,
                                ),
                                TextEditingOptionSelect(
                                  iconData: Clarity.calendar_solid,
                                  controller: birthDateController,
                                  hintText: "optional",
                                  labelText: "Tanggal Lahir",
                                  onTap: (){
                                    showCupertinoModalPopup(
                                      context: context, 
                                      builder: (context) {
                                        return Container(
                                          height: size.height * 0.27,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                            ),
                                          ),
                                          child: CupertinoDatePicker(
                                            minimumYear: DateTime.now().year - 70,
                                            maximumYear: DateTime.now().year,
                                            mode: CupertinoDatePickerMode.date,
                                            onDateTimeChanged: (value) {
                                              setState(() {
                                                date = value;
                                                birthDateController.text = DateFormat('dd MMMM yyyy').format(value);
                                              });
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                TextEditingOptionSelect(
                                  hintText: "optional",
                                  iconData: Bootstrap.gender_ambiguous,
                                  labelText: "Gender",
                                  controller: genderContrller,
                                  onTap: () => showCupertinoActionSheet(
                                    context, 
                                    cupertinoActionSheet: [
                                      CupertinoActionSheetAction(
                                        onPressed: (){
                                          setState(() {
                                            genderContrller.text = "Laki-laki";
                                          });
                                          Navigator.pop(context);
                                        }, 
                                        child: const Text("Laki-laki")
                                      ),
                                      CupertinoActionSheetAction(
                                        onPressed: (){
                                          setState(() {
                                            genderContrller.text = "Perempuan";
                                          });
                                          Navigator.pop(context);
                                        }, 
                                        child: const Text("Perempuan", selectionColor: Colors.black)
                                      ),
                                  ],
                                  message: "Pilih gender",
                                  title: "Gender"),
                                ),
                                AnyTextField(
                                  maxLength: 5,
                                  iconData: Iconsax.gps_outline,
                                  textInputType: TextInputType.number,
                                  withLength: true,
                                  hintText: "optional",
                                  labelText: "Kode Pos",
                                  controller: zipCodeController,
                                ),
                              ],
                            ),
                          ),
                        )
                      else if(currentStep == 2)
                        Padding(
                          padding: GlobalVariablesType.defaultPadding!,
                          child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text("Informasi Finansial", style: kDefaultTextStyleCustom(fontSize: 20, fontWeight: FontWeight.bold),),
                                ),
                                TextEditingOptionSelect(
                                  hintText: "optional",
                                  iconData: BoxIcons.bxs_bank,
                                  labelText: "Nama Bank",
                                  controller: bankNameController,
                                  onTap: (){
                                    showModalBottomSheet(
                                      context: context, 
                                      builder: (context) => 
                                        CupertinoPicker(
                                          itemExtent: 50,
                                          diameterRatio: 5,
                                          backgroundColor: CupertinoColors.darkBackgroundGray,
                                          useMagnifier: true,
                                          scrollController: FixedExtentScrollController(initialItem: initialItem),
                                          onSelectedItemChanged: (index) {
                                            setState(() {
                                              initialItem = index;
                                              bankNameController.text = listBank[index];
                                            },
                                          );
                                      },
                                      children: List.generate(
                                        listBank.length,
                                        (index) => Center(
                                              child: Text(
                                                listBank[index],
                                                style: kDefaultTextStyleCustom(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        )
                                      );
                                  }
                                ),
                                AnyTextField(
                                  hintText: "optional",
                                  iconData: CupertinoIcons.person_circle,
                                  labelText: "Nama Pemilik Rekening Bank",
                                  textInputType: TextInputType.name,
                                  controller: bankAccountNameController,
                                ),
                                TextEditingOptionSelect(
                                  hintText: "optional",
                                  iconData: BoxIcons.bx_wallet,
                                  labelText: "Tipe Rekening",
                                  onTap: () => showCupertinoActionSheet(
                                    context, 
                                    cupertinoActionSheet: [
                                      CupertinoActionSheetAction(
                                        onPressed: (){
                                          setState(() {
                                            bankAccountTypeController.text = "Tabungan";
                                          });
                                          Navigator.pop(context);
                                        }, 
                                        child: const Text("Tabungan")
                                      ),
                                      CupertinoActionSheetAction(
                                        onPressed: (){
                                          setState(() {
                                            bankAccountTypeController.text = "Giro";
                                          });
                                          Navigator.pop(context);
                                        }, 
                                        child: const Text("Giro")
                                      ),
                                      CupertinoActionSheetAction(
                                        onPressed: (){
                                          setState(() {
                                            bankAccountTypeController.text = "Lainnya";
                                          });
                                          Navigator.pop(context);
                                        }, 
                                        child: const Text("Lainnya")
                                      ),
                                  ],
                                  message: "Choose Your Bank Account Type",
                                  title: "Bank Information"),
                                  controller: bankAccountTypeController,
                                ),
                                AnyTextField(
                                  hintText: "optional",
                                  iconData: OctIcons.number,
                                  labelText: "Nomor Rekening",
                                  textInputType: TextInputType.number,
                                  controller: bankAccountNumberController,
                                ),
                                AnyTextField(
                                  hintText: "optional",
                                  labelText: "Cabang Bank",
                                  iconData: CupertinoIcons.placemark_fill,
                                  textInputType: TextInputType.name,
                                  controller: bankBranchController,
                                ),
                                const SizedBox(height: 15),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: GlobalVariablesType.mainColor,
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      additionalBank = !additionalBank;
                                    });
                                  }, 
                                  icon: Icon(additionalBank == false ? Icons.add : Icons.delete, color: Colors.black, size: 18),
                                  label: Text(additionalBank == false ? "Add more bank" : "Cancel", style: kDefaultTextStyleCustom(color: Colors.black),),
                                ),
                                
                                // Additional Bank
                                additionalBank ? Container(
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      TextEditingOptionSelect(
                                        hintText: "optional",
                                        iconData: BoxIcons.bxs_bank,
                                        labelText: "Nama Bank 2",
                                        controller: bankName2Controller,
                                        onTap: (){
                                          showModalBottomSheet(
                                            context: context, 
                                            builder: (context) => 
                                              CupertinoPicker(
                                                itemExtent: 50,
                                                diameterRatio: 5,
                                                backgroundColor: CupertinoColors.darkBackgroundGray,
                                                useMagnifier: true,
                                                scrollController: FixedExtentScrollController(initialItem: initialItem),
                                                onSelectedItemChanged: (index) {
                                                  setState(() {
                                                    initialItem = index;
                                                    bankName2Controller.text = listBank[index];
                                                  },
                                                );
                                            },
                                            children: List.generate(
                                              listBank.length,
                                              (index) => Center(
                                                    child: Text(
                                                      listBank[index],
                                                      style: kDefaultTextStyleCustom(fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            );
                                        }
                                      ),
                                    AnyTextField(
                                  hintText: "optional",
                                  iconData: CupertinoIcons.person_circle,
                                  labelText: "Nama Pemilik Rekening 2",
                                  textInputType: TextInputType.name,
                                  controller: bankAccountName2Controller,
                                ),
                                    TextEditingOptionSelect(
                                      hintText: "optional",
                                      iconData: BoxIcons.bx_wallet,
                                      labelText: "Tipe Rekening 2",
                                      onTap: () => showCupertinoActionSheet(
                                        context,
                                        cupertinoActionSheet: [
                                          CupertinoActionSheetAction(
                                            onPressed: (){
                                              setState(() {
                                                bankAccountType2Controller.text = "Tabungan";
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Tabungan")
                                          ),
                                          CupertinoActionSheetAction(
                                            onPressed: (){
                                              setState(() {
                                                bankAccountType2Controller.text = "Giro";
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Giro")
                                          ),
                                          CupertinoActionSheetAction(
                                            onPressed: (){
                                              setState(() {
                                                bankAccountTypeController.text = "Lainnya";
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Lainnya")
                                          ),
                                      ],
                                      message: "Choose Your Bank Account Type",
                                      title: "Bank Information"),
                                      controller: bankAccountType2Controller,
                                    ),
                                    AnyTextField(
                                      hintText: "optional",
                                      iconData: OctIcons.number,
                                      labelText: "Nomor Rekening Bank 2",
                                      textInputType: TextInputType.number,
                                      controller: bankAccountNumber2Controller,
                                    ),
                                    AnyTextField(
                                      hintText: "optional",
                                      iconData: CupertinoIcons.placemark_fill,
                                      labelText: "Cabang Bank 2",
                                      textInputType: TextInputType.name,
                                      controller: bankBranch2Controller,
                                    ),
                                    const SizedBox(height: 20),
                                    ],
                                  ),
                                ) : Container()
                              ],
                            ),
                        )
                      else if(currentStep == 3)
                        Padding(
                          padding: GlobalVariablesType.defaultPadding!,
                          child: Column(
                            children: [
                              Padding(padding: const EdgeInsets.only(bottom: 20),
                                child: Text("Informasi Tambahan", style: kDefaultTextStyleCustom(fontSize: 20, fontWeight: FontWeight.bold),),
                              ),
                              AnyTextField(
                                hintText: "optional",
                                iconData: OctIcons.number,
                                labelText: "Nomor Induk Kependudukan (NIK)",
                                withLength: true,
                                maxLength: 16,
                                textInputType: TextInputType.number,
                                controller: idPersonalController,
                              ),
                                const SizedBox(height: 20),
                                /*
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          CupertinoButton(
                                            onPressed: () async {
                                              await ktpImagePicker();
                                            },
                                            padding: EdgeInsets.zero,
                                            child: Obx(() => 
                                              Container(
                                                width: size.width / 3,
                                                height: size.width / 3,
                                                clipBehavior: Clip.hardEdge,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.white),
                                                  borderRadius: BorderRadius.circular(10),
                                                  image: urlKTPImage.value == "" ? null : DecorationImage(image: FileImage(File(urlKTPImage.value)), fit: BoxFit.cover)
                                                ),
                                                child: urlKTPImage.value == "" ? const Icon(FontAwesome.id_card, color: Colors.white) : const SizedBox(),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          const Text("Foto KTP", style: TextStyle(color: Colors.white))
                                        ],
                                      )
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          CupertinoButton(
                                            onPressed: () async {
                                              await selfiImagePicker();
                                            },
                                            padding: EdgeInsets.zero,
                                            child: Obx(() => 
                                              Container(
                                                width: size.width / 3,
                                                height: size.width / 3,
                                                clipBehavior: Clip.hardEdge,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.white),
                                                  borderRadius: BorderRadius.circular(10),
                                                  image: urlSelfiImage.value == "" ? null : DecorationImage(image: FileImage(File(urlSelfiImage.value)), fit: BoxFit.cover)
                                                ),
                                                child: urlSelfiImage.value == "" ? const Icon(BoxIcons.bx_face, color: Colors.white) : const SizedBox(),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          const Text("Foto Selfie", style: TextStyle(color: Colors.white))
                                        ],
                                      )
                                    ),
                                  ],
                                ),
                                */
                              ],
                            ),
                        )
                      else
                        const Text("error")
                    else
                      const Text("data")
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey
                      ),
                      onPressed: currentStep == 1
                          ? (){}
                          : () {
                              back();
                            },
                      child: Text('Back', style: kDefaultTextStyleCustom(color: Colors.black, fontSize: 13),),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Obx(
                      () => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: GlobalVariablesType.mainColor
                        ),
                        onPressed: registerController.isLoading.value == true ? (){} : () async {
                          if(currentStep == 1){
                            print(accountsController.userID.value);
                            if(noHPController.text == "62"){
                              Get.snackbar("Gagal", "Nomor HP dibutuhkan", backgroundColor: Colors.red, colorText: Colors.white);
                            }else{
                              if(await registerController.step1(
                                phone: noHPController.text,
                                city: cityController.text,
                                address: addressContrller.text,
                                country: countryContrller.text,
                                gender: genderContrller.text,
                                zip: zipCodeController.text,
                                tempatLahir: birthPlaceController.text,
                                tglLahir: DateFormat('yyyy-MM-dd').format(date)
                              ) == true){
                                alertDialogCustomSuccess(
                                  onTap: (){
                                    Navigator.pop(context);
                                    next();
                                  },
                                  textButton: "Lanjutkan",
                                  title: "Berhasil",
                                  message: registerController.responseMessage.value
                                );
                              }else{
                                alertError(
                                  message: registerController.responseMessage.value,
                                  title: "Gagal",
                                  onTap: (){
                                    Navigator.pop(context);
                                  }
                                );
                              }
                            }
                          } else if(currentStep == 2){
                            if(await registerController.step2(
                              bank1Account: bankAccountNumberController.text,
                              bank1branch: bankBranchController.text,
                              bank1name: bankNameController.text,
                              bank1type: bankAccountTypeController.text,
                              bank2account: bankAccountNumber2Controller.text,
                              bank2branch: bankBranch2Controller.text,
                              bank2name: bankName2Controller.text,
                              bank2type: bankAccountType2Controller.text
                            ) == true){
                              alertDialogCustomSuccess(
                                onTap: (){
                                  Navigator.pop(context);
                                  next();
                                },
                                textButton: "Lanjutkan",
                                title: "Berhasil",
                                message: registerController.responseMessage.value
                              );
                            }else{
                              alertError(
                                message: registerController.responseMessage.value,
                                title: "Gagal",
                                onTap: (){
                                  Navigator.pop(context);
                                }
                              );
                            }
                          } else if(currentStep == 3){
                              if(await registerController.step3(
                                idNumber: idPersonalController.text,
                                idType: "KTP"
                              )){
                                alertDialogCustomSuccess(
                                  onTap: (){
                                    Get.offAll(() => const LoginPage());
                                  },
                                  message: registerController.responseMessage.value,
                                  title: "Berhasil"
                                );
                              }else{
                                alertError(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  message: registerController.responseMessage.value,
                                  title: "Gagal",
                                );
                              }
                            }
                          },
                        child: Text(
                          currentStep == stepLength ? 'Finish' : 'Next', style: kDefaultTextStyleCustom(color: Colors.black, fontSize: 13),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Obx(() => registerController.isLoading.value == true
            ? floatingLoading()
            : const SizedBox()),
      ],
    );
  }

  Future<void> selfiImagePicker() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked = await picker.pickImage(source: ImageSource.camera, imageQuality: 50, preferredCameraDevice: CameraDevice.front);
    if(imagePicked != null){
      urlSelfiImage.value = imagePicked.path;
    }else{
      Get.snackbar("Gagal", "Gagal mendapatkan gambar", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> ktpImagePicker() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked = await picker.pickImage(source: ImageSource.camera, imageQuality: 50, preferredCameraDevice: CameraDevice.rear);
    if(imagePicked != null){
      urlKTPImage.value = imagePicked.path;
    }else{
      Get.snackbar("Gagal", "Gagal mendapatkan gambar", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}