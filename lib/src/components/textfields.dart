import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:delapanbelasfx/src/helpers/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EmailTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final bool? readOnly;
  final TextEditingController? controller;
  const EmailTextField({super.key, this.hintText, this.labelText, this.controller, this.readOnly});

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  RxBool isEmail = false.obs;

  @override
  void initState() {
    super.initState();
    if(validateEmailBool(widget.controller?.text) == true){
      isEmail(true);
    }    
  }
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        readOnly: widget.readOnly ?? false,
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autofillHints: const [AutofillHints.email],
        style: kDefaultTextStyleCustom(fontSize: 13),
        keyboardAppearance: Brightness.dark,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Mohon isikan ${widget.labelText}';
          }else if(validateEmailBool(value) == false){
            return 'Mohon isikan ${widget.labelText} yang benar';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: const Icon(Icons.email, color: GlobalVariablesType.mainColor),
          labelText: widget.labelText,
          labelStyle: const TextStyle(color: GlobalVariablesType.mainColor),
          hintStyle: TextStyle(color: Colors.white24, fontSize: GlobalVariablesType.defaultFontSize),
          filled: false,
          suffix: AnimatedContainer(
            duration: const Duration(milliseconds: 500), 
            padding: const EdgeInsets.all(2),
            decoration:  BoxDecoration(
              color: isEmail.value == false ? Colors.red : GlobalVariablesType.mainColor,
              shape: BoxShape.circle),
            child: isEmail.value == false ? const Icon(Icons.close, color: Colors.white, size: 16) : const Icon(Icons.done, color: Colors.white, size: 16),    
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: GlobalVariablesType.mainColor
            )
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: GlobalVariablesType.mainColor
            )
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: GlobalVariablesType.mainColor
            )
          )
         ),
         onChanged: (value) {
          if(validateEmailBool(value) == true){
            isEmail(true);
          }else{
            isEmail(false);
          }
        },
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  const PasswordTextField({super.key, this.hintText, this.labelText, this.controller});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  RxBool isEightCharacter = false.obs;
  RxBool obscureText = true.obs;
  
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText.value,
        keyboardAppearance: Brightness.dark,
        autofillHints: const [AutofillHints.password],
        style: kDefaultTextStyleCustom(fontSize: 13),
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: Icon(Icons.password, color: GlobalVariablesType.mainColor),
          labelText: widget.labelText,
          labelStyle: TextStyle(color: GlobalVariablesType.mainColor),
          hintStyle: TextStyle(color: Colors.white24, fontSize: GlobalVariablesType.defaultFontSize),
          filled: false,
          suffix: GestureDetector(
            onTap: (){
              setState(() {
                obscureText.value = !obscureText.value;
              });
            },
            child: obscureText.value == true ?  Icon(Icons.visibility, color: GlobalVariablesType.mainColor) :  Icon(Icons.visibility_off, color: GlobalVariablesType.mainColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: GlobalVariablesType.mainColor
            )
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: GlobalVariablesType.mainColor
            )
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: GlobalVariablesType.mainColor
            )
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red
            )
          )
        ),
        validator: (value){
          RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~/]).{8,}$');
          var passNonNullValue = value ?? "";
          if(passNonNullValue.isEmpty){
            return ("Mohon inputkan kata sandi");
          }
          else if(passNonNullValue.length < 8){
            return ("Kata sandi kurang dari 8 karakter");
          }
          else if(!regex.hasMatch(passNonNullValue)){
            return ("Kata sandi tidak terdapat huruf kapital, huruf kecil, angka atau simbol");
          }
          return null;
        },
         onChanged: (value) {
          if(value.length < 8){
            isEightCharacter(false);
          }else{
            isEightCharacter(true);
          }
        },
      ),
    );
  }
}

class PasswordConfirmations extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextEditingController? controllerTarget;
  const PasswordConfirmations({super.key, this.hintText, this.labelText, this.controller, this.controllerTarget});

  @override
  State<PasswordConfirmations> createState() => _PasswordConfirmationsState();
}

class _PasswordConfirmationsState extends State<PasswordConfirmations> {
  bool? isEightCharacter;
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
       controller: widget.controller,
       obscureText: obscureText,
       keyboardAppearance: Brightness.dark,
       style: kDefaultTextStyleCustom(fontSize: 13),
       decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Icon(Icons.password, color: GlobalVariablesType.mainColor),
        labelText: widget.labelText,
        labelStyle: TextStyle(color: GlobalVariablesType.mainColor),
        hintStyle: TextStyle(color: Colors.white24, fontSize: GlobalVariablesType.defaultFontSize),
        filled: false,
        suffix: GestureDetector(
          onTap: (){
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: obscureText == true ?  Icon(Icons.visibility, color: GlobalVariablesType.mainColor) :  Icon(Icons.visibility_off, color: GlobalVariablesType.mainColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: isEightCharacter == false ? Colors.red : GlobalVariablesType.mainColor
          )
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: isEightCharacter == false ? Colors.red : GlobalVariablesType.mainColor
          )
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: isEightCharacter == false ? Colors.red : GlobalVariablesType.mainColor
          )
        )
       ),
       validator: (value) {
        if(value!.isEmpty) {
          return 'Empty';
        }
        if(value != widget.controllerTarget?.text) {
          return 'Not Match';
        }
        return null;
       },
       onChanged: (value) {
          if(value.length < 8 && value != widget.controllerTarget?.text){
            setState(() {
              isEightCharacter = false;
            });
          }else{
            setState(() {
              isEightCharacter = true;
            });
          }
       },
    );
  }
}


class PhoneTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final bool? forOTP;
  final Function()? onTapSendOTP;
  final TextEditingController? controller;
  final bool? readOnly;
  const PhoneTextField({super.key, this.hintText, this.labelText, this.controller, this.readOnly, this.forOTP, this.onTapSendOTP});

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  RxBool isPhone = false.obs;
  RxBool isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    if(widget.controller?.text != ''){
      if(validatePhone(widget.controller!.text.length) == true){
          isPhone(true);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => isLoading.value ? const SizedBox() : TextFormField(
         controller: widget.controller,
         keyboardType: TextInputType.phone,
         inputFormatters: [
            FilteringTextInputFormatter.deny(
              RegExp(r'^0+'),
            ),
          ],
         keyboardAppearance: Brightness.dark,
         readOnly: widget.readOnly ?? false,
         autovalidateMode: AutovalidateMode.onUserInteraction,
         style: kDefaultTextStyleCustom(fontSize: 13),
         validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Mohon isikan ${widget.labelText}';
            }else if(validatePhone(value.length) == false){
              return 'Jumlah angka kurang dari 11';
            }
            return null;
          },
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          prefixIcon: Icon(Icons.phone, color: GlobalVariablesType.mainColor),
          labelStyle: TextStyle(color: GlobalVariablesType.mainColor),
          hintStyle: TextStyle(color: Colors.white24, fontSize: GlobalVariablesType.defaultFontSize),
          filled: false,
          suffixIcon: widget.forOTP == null || widget.forOTP == false ? const SizedBox(width: 0) : isPhone.value ? CupertinoButton(padding: const EdgeInsets.only(top: 10), onPressed: widget.onTapSendOTP, child: const Text('Kirim OTP', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold))) : const SizedBox(),
          suffix: Obx(
            () => AnimatedContainer(
              duration: const Duration(milliseconds: 500), 
              padding: const EdgeInsets.symmetric(horizontal: 7),
              decoration: BoxDecoration(
                color: isPhone.value == false ? Colors.red : GlobalVariablesType.mainColor,
                shape: BoxShape.circle),
              child: isPhone.value == false ? const Icon(Icons.close, color: Colors.white, size: 16) : const Icon(Icons.done, color: Colors.white, size: 16),    
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: GlobalVariablesType.mainColor
            )
          ),
          enabledBorder:const UnderlineInputBorder(
            borderSide: BorderSide(
              color: GlobalVariablesType.mainColor
            )
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: GlobalVariablesType.mainColor
            )
          )
         ),
         onChanged: (value) {
            validatePhone(value.length);
         },
      ),
    );
  }

  bool? validatePhone(int length) {
    if(length > 9){
      isPhone(true);
    }else{
      isPhone(false);
    }
    return isPhone.value;
  }
}


class NameTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final bool? readOnly;
  final TextEditingController? controller;
  const NameTextField({super.key, this.hintText, this.labelText, this.controller, this.readOnly});

  @override
  State<NameTextField> createState() => _NameTextFieldState();
}

class _NameTextFieldState extends State<NameTextField> {
  bool? isName = false;

  @override
  void initState() {
    super.initState();
    if(validateName(widget.controller!.text) == true){
      setState(() {
        isName = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly ?? false,
       controller: widget.controller,
       autovalidateMode: AutovalidateMode.onUserInteraction,
       keyboardType: TextInputType.name,
       keyboardAppearance: Brightness.dark,
       style: kDefaultTextStyleCustom(fontSize: 13),
       decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        prefixIcon: Icon(CupertinoIcons.person_crop_circle, color: GlobalVariablesType.mainColor),
        labelStyle: TextStyle(color: GlobalVariablesType.mainColor),
        hintStyle: TextStyle(color: Colors.white24, fontSize: GlobalVariablesType.defaultFontSize),
        filled: false,
        suffix: AnimatedContainer(
          duration: const Duration(milliseconds: 500), 
          padding: const EdgeInsets.all(2),
          decoration:  BoxDecoration(
            color: isName == false ? Colors.red : GlobalVariablesType.mainColor,
            shape: BoxShape.circle),
          child: isName == false ? const Icon(Icons.close, color: Colors.white, size: 16) : const Icon(Icons.done, color: Colors.white, size: 16),    
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: GlobalVariablesType.mainColor
          )
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: GlobalVariablesType.mainColor
          )
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: GlobalVariablesType.mainColor
          )
        )
       ),
       validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Mohon isikan ${widget.labelText}';
        }
        return null;
      },
       onChanged: (value) {
          validateName(value);
       },
    );
  }

  bool? validateName(String? value) {
    if(value!.length > 2){
      setState(() {
        isName = true;
      });
    }else{
      setState(() {
        isName = false;
      });
    }
    // if(RegExp(r"\s").hasMatch(value)){
    //   setState(() {
    //     isName = true;
    //   });
    // }else{
    //   setState(() {
    //     isName = false;
    //   });
    // }
    return isName;
  }
}


class TextEditingOptionSelect extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final bool? readOnly;
  final bool? enable;
  final IconData? iconData;
  final Function()? onTap;
  final TextEditingController? controller;
  const TextEditingOptionSelect({super.key, this.enable ,this.hintText, this.labelText, this.controller, this.onTap, this.readOnly, this.iconData});

  @override
  State<TextEditingOptionSelect> createState() => _TextEditingOptionSelectState();
}

class _TextEditingOptionSelectState extends State<TextEditingOptionSelect> {
  bool? isName = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enable ?? true,
       readOnly: widget.readOnly ?? true,
       controller: widget.controller,
       keyboardAppearance: Brightness.dark,
       style: kDefaultTextStyleCustom(fontSize: 13),
       keyboardType: TextInputType.name,
       onTap: widget.readOnly == true ? (){} : widget.onTap,
       decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        prefixIcon: Icon(widget.iconData ?? Icons.menu, color: GlobalVariablesType.mainColor),
        labelStyle: TextStyle(color: GlobalVariablesType.mainColor),
        hintStyle: TextStyle(color: Colors.white24, fontSize: GlobalVariablesType.defaultFontSize),
        filled: false,
        // suffix: AnimatedContainer(
        //   duration: const Duration(milliseconds: 500), 
        //   padding: const EdgeInsets.all(2),
        //   decoration:  BoxDecoration(
        //     color: isName == false ? Colors.red : GlobalVariablesType.mainColor,
        //     shape: BoxShape.circle),
        //   child: isName == false ? const Icon(Icons.close, color: Colors.white, size: 16) : const Icon(Icons.done, color: Colors.white, size: 16),    
        // ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: GlobalVariablesType.mainColor
          )
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: GlobalVariablesType.mainColor
          )
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: GlobalVariablesType.mainColor
          )
        )
       ),
       onChanged: (value) {
          validateName(value);
       },
    );
  }

  bool? validateName(String value) {
    if(value.isNotEmpty){
      setState(() {
        isName = true;
      });
    }else{
      setState(() {
        isName = false;
      });
    }
    return isName;
  }
}


class AnyTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final bool? withLength;
  final bool? withOptionalText;
  final int? maxLength;
  final bool? readOnly;
  final Widget? prefix;
  final bool? withValidator;
  final Function()? onPressed;
  final bool? enable;
  final IconData? iconData;
  final String? prefixText;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  const AnyTextField({super.key, this.enable ,this.hintText, this.labelText, this.controller, this.textInputType, this.withLength, this.maxLength, this.withOptionalText, this.readOnly, this.iconData, this.prefixText, this.onPressed, this.withValidator, this.prefix});

  @override
  State<AnyTextField> createState() => _AnyTextFieldState();
}

class _AnyTextFieldState extends State<AnyTextField> {
  bool? isName = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enable ?? true,
      readOnly: widget.readOnly ?? false,
      maxLength: widget.withLength == true ? widget.maxLength : null,
       controller: widget.controller,
       onTap: widget.onPressed,
       keyboardType: widget.textInputType,
       keyboardAppearance: Brightness.dark,
       style: kDefaultTextStyleCustom(fontSize: 13),
       validator: widget.withValidator == true ? (value) {
        if (value == null || value.isEmpty) {
          return 'Mohon isikan ${widget.labelText}';
        }
        return null;
       } : null,
       decoration: InputDecoration(
        prefix: widget.prefix,
        counterStyle: kDefaultTextStyleCustom(),
        prefixIcon: Icon(widget.iconData ?? Icons.menu, color: GlobalVariablesType.mainColor),
        errorStyle: kDefaultTextStyleCustom(color: Colors.red),
        hintText: widget.hintText,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(top: 15, left: 10),
          child: Text(widget.prefixText ?? "", style: const TextStyle(color: CupertinoColors.activeBlue)),
        ),
        labelText: widget.labelText,
        suffix:widget.withOptionalText == true ? const Text("Optional") : null,
        labelStyle: TextStyle(color: GlobalVariablesType.mainColor),
        hintStyle: TextStyle(color: Colors.white24, fontSize: GlobalVariablesType.defaultFontSize),
        filled: false,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: GlobalVariablesType.mainColor
          )
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: GlobalVariablesType.mainColor
          )
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: GlobalVariablesType.mainColor
          )
        )
       ),
    );
  }
}
