import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:delapanbelasfx/src/components/action_sheet.dart';
import 'package:delapanbelasfx/src/components/list_bank.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textfields.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:delapanbelasfx/src/helpers/focus_manager.dart';

class StepperPageRegister extends StatefulWidget {
  const StepperPageRegister({super.key});

  @override
  State<StepperPageRegister> createState() => _StepperPageRegisterState();
}

class _StepperPageRegisterState extends State<StepperPageRegister> {
  int activeCurrentStep = 0;
  TextEditingController emailContrller = TextEditingController();
  TextEditingController referalCodeController = TextEditingController();
  TextEditingController idPersonalController = TextEditingController();
  TextEditingController fullNameContrller = TextEditingController();
  TextEditingController genderContrller = TextEditingController();
  TextEditingController noHPController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController bankAccountController = TextEditingController();
  bool isChecked = false;
  int initialItem = 6;

  @override
  void dispose() {
    emailContrller.dispose();
    referalCodeController.dispose();
    fullNameContrller.dispose();
    genderContrller.dispose();
    noHPController.dispose();
    genderContrller.dispose();
    bankAccountController.dispose();
    bankNameController.dispose();
    idPersonalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => focusManager(),
      child: Scaffold(
        backgroundColor: GlobalVariablesType.backgroundColor,
        body: SafeArea(
          child: Theme(
            data: ThemeData(
            canvasColor: GlobalVariablesType.mainColor,
            colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: GlobalVariablesType.mainColor,
                secondary: Colors.black,
              ),
            ),
            child: Stepper(
              currentStep: activeCurrentStep,
              elevation: 0,
              controlsBuilder: (context, onStepCancel) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: GlobalVariablesType.mainColor,
                        ),
                        onPressed: (){
                          if (activeCurrentStep < (stepList().length - 1)) {
                            setState(() {
                              activeCurrentStep += 1;
                            });
                          } 
                        },
                        child: Text('NEXT', style: kDefaultTextStyleCustom(fontSize: 14)),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: GlobalVariablesType.mainColor,
                        ),
                        onPressed: (){
                          if (activeCurrentStep == 0) {
                            return;
                          }
                          setState(() {
                            activeCurrentStep -= 1;
                          });
                        },
                        child: activeCurrentStep == 0 ? Text("CANCEL", style: kDefaultTextStyleCustom(fontSize: 14)) : Text('PREVIOUS', style: kDefaultTextStyleCustom(fontSize: 14)),
                      ),
                    ),
                  ],
                );
              },
              connectorColor: WidgetStateProperty.resolveWith((states) {
                if(states.contains(WidgetState.selected)){
                  return Colors.green;
                }
                return Colors.black26;
              }),
              // onStepContinue takes us to the next step
              onStepContinue: () {
                if (activeCurrentStep < (stepList().length - 1)) {
                  setState(() {
                    activeCurrentStep += 1;
                  });
                } 
              },
               
              // onStepCancel takes us to the previous step
              onStepCancel: () {
                if (activeCurrentStep == 0) {
                  return;
                }
                setState(() {
                  activeCurrentStep -= 1;
                });
              },
               
              // onStepTap allows to directly click on the particular step we want
              onStepTapped: (int index) {
                setState(() {
                  activeCurrentStep = index;
                });
              },
              type: StepperType.horizontal,
              steps: stepList()),
          ),
        ),
      ),
    );
  }

  List<Step> stepList() => [
    Step(
      state: activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
      isActive: activeCurrentStep >= 0,
      title: Text('Personal', style: kDefaultTextStyleCustom(color: Colors.black)),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              color: Colors.transparent,
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white10,
                      image: DecorationImage(image: AssetImage('assets/images/default-picture.png'), fit: BoxFit.cover)
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: (){
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: GlobalVariablesType.mainColor
                        ),
                        child: const Icon(CupertinoIcons.camera, color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            NameTextField(
              hintText: "Input your name",
              labelText: "Full Name",
              controller: fullNameContrller,
            ),
            const SizedBox(height: 15),
            EmailTextField(
              hintText: "Input your email",
              labelText: "Email",
              controller: emailContrller,
            ),
            const SizedBox(height: 15),
            PhoneTextField(
              readOnly: false,
              hintText: "Input your Phone Number",
              labelText: "Phone",
              controller: noHPController,
            ),
            const SizedBox(height: 15),
            TextEditingOptionSelect(
              hintText: "Select Gender",
              labelText: "Gender",
              controller: genderContrller,
              onTap: () => showCupertinoActionSheet(
                context, 
                cupertinoActionSheet: [
                  CupertinoActionSheetAction(
                    onPressed: (){
                      setState(() {
                        genderContrller.text = "Male";
                      });
                      Navigator.pop(context);
                    }, 
                    child: const Text("Male")
                  ),
                  CupertinoActionSheetAction(
                    onPressed: (){
                      setState(() {
                        genderContrller.text = "Female";
                      });
                      Navigator.pop(context);
                    }, 
                    child: const Text("Female")
                  ),
              ],
              message: "Choose Your Gender",
              title: "Gender"),
            ),
            const SizedBox(height: 15),
            TextEditingOptionSelect(
              controller: birthDateController,
              labelText: "Birth Date",
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000), //get today's date
                  firstDate:DateTime(1960), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime.now()
                );
                if(pickedDate != null ){                      
                  String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                  setState(() {
                      birthDateController.text = formattedDate; //set foratted date to TextField value. 
                  });
                }else{
                    Get.snackbar("Failed", "Please choose your birthdate");
                }
              },
            ),
            const SizedBox(height: 15),
            AnyTextField(
              hintText: "ID Personal or NIK",
              labelText: "ID Personal or NIIK",
              withLength: true,
              maxLength: 16,
              textInputType: TextInputType.number,
              controller: idPersonalController,
            ),
            const SizedBox(height: 15),
          ],
        ),
      )
    ),


    // This is Step2 here we will enter our address
    Step(state: activeCurrentStep <= 1 ? StepState.editing : StepState.complete,
      isActive: activeCurrentStep >= 1,
      title: Text('Payment', style: kDefaultTextStyleCustom(color: Colors.black)),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextEditingOptionSelect(
              hintText: "Bank Name",
              labelText: "Bank Name",
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
            const SizedBox(height: 15),
            AnyTextField(
              hintText: "Bank Account Number",
              labelText: "Bank Account Number",
              textInputType: TextInputType.number,
              controller: bankAccountController,
            ),
            const SizedBox(height: 15),
            AnyTextField(
              hintText: "ID Personal or NIK",
              labelText: "ID Personal or NIK",
              withLength: true,
              maxLength: 16,
              textInputType: TextInputType.number,
              controller: idPersonalController,
            ),
            const SizedBox(height: 15),
          ],
        ),
      )
    ),
        // This is Step3 here we will display all the details
        // that are entered by the user
    Step(
        state: StepState.complete,
        isActive: activeCurrentStep >= 2,
        title: Text('Confirm', style: kDefaultTextStyleCustom(color: Colors.black)),
        content: Container(
          color: Colors.transparent,
            child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Text('Name: ${name.text}'),
            // Text('Email: ${email.text}'),
            // Text('Password: ${pass.text}'),
            // Text('Address : ${address.text}'),
            // Text('PinCode : ${pincode.text}'),
          ],
        ),
      ),
    )
      ];
}