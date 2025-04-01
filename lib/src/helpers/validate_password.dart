import 'package:flutter/material.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';

bool validateStructure(String value){
  String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

extension PasswordValidator on String {
  bool isValidPassword() {
  return RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
    .hasMatch(this);
  }
}


class Roweliminateonenum extends StatelessWidget {
  const Roweliminateonenum({
    super.key,
    required this.hasPasswordOneNumber,
  });

  final bool hasPasswordOneNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              color: hasPasswordOneNumber ? GlobalVariablesType.mainColor : Colors.transparent,
              border: hasPasswordOneNumber
                  ? Border.all(color: Colors.transparent)
                  : Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(50)),
          child: const Center(
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text("Minimal terdapat 1 angka", style: kDefaultTextStyleCustom(color: GlobalVariablesType.mainColor),)
      ],
    );
  }
}

class Roweliminatelowup extends StatelessWidget {
  const Roweliminatelowup({
    super.key,
    required this.hasLowerUpper,
  });

  final bool hasLowerUpper;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              color: hasLowerUpper ? GlobalVariablesType.mainColor : Colors.transparent,
              border: hasLowerUpper
                  ? Border.all(color: Colors.transparent)
                  : Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(50)),
          child: const Center(
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text("Huruf kecil dan besar", style: kDefaultTextStyleCustom(color: GlobalVariablesType.mainColor))
      ],
    );
  }
}

class RoweliminateSymbols extends StatelessWidget {
  const RoweliminateSymbols({
    super.key,
    required this.hasLowerUpper,
  });

  final bool hasLowerUpper;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              color: hasLowerUpper ? GlobalVariablesType.mainColor : Colors.transparent,
              border: hasLowerUpper
                  ? Border.all(color: Colors.transparent)
                  : Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(50)),
          child: const Center(
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text("Terdapat Symbol", style: kDefaultTextStyleCustom(color: GlobalVariablesType.mainColor))
      ],
    );
  }
}

class Roweliminatenumber extends StatelessWidget {
  const Roweliminatenumber({
    super.key,
    required this.isPasswordEightCharacters,
  });

  final bool isPasswordEightCharacters;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              color:
                  isPasswordEightCharacters ? GlobalVariablesType.mainColor : Colors.transparent,
              border: isPasswordEightCharacters
                  ? Border.all(color: Colors.transparent)
                  : Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(50)),
          child: const Center(
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text("Panjang minimal 8 karakter", style: kDefaultTextStyleCustom(color: GlobalVariablesType.mainColor),)
      ],
    );
  }
}

class RoweliminateSamePassword extends StatelessWidget {
  const RoweliminateSamePassword({
    super.key,
    required this.isPasswordSameWithOther,
  });

  final bool isPasswordSameWithOther;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              color:
                  isPasswordSameWithOther ? GlobalVariablesType.mainColor : Colors.transparent,
              border: isPasswordSameWithOther
                  ? Border.all(color: Colors.transparent)
                  : Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(50)),
          child: const Center(
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text("Password Sama", style: kDefaultTextStyleCustom(color: GlobalVariablesType.mainColor),)
      ],
    );
  }
}