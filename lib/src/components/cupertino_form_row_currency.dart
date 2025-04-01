import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCupertinoFormRowCurrency extends StatefulWidget {
  final Function()? onPressed;
  final bool? readOnly;
  final String? currencyType;
  final TextEditingController? controller;
  final String? placeholder;
  final TextInputType? textInputType;
  final String? prefix;
  final TextInputAction? textInputAction;
  final bool? autoFocuse;
  final Function()? onEditingComplete;
  final Function(String value)? onFieldSubmitted;
  const CustomCupertinoFormRowCurrency({super.key, this.controller, this.placeholder, this.textInputType, this.prefix, this.textInputAction, this.onPressed, this.readOnly, this.currencyType, this.autoFocuse, this.onEditingComplete, this.onFieldSubmitted});

  @override
  State<CustomCupertinoFormRowCurrency> createState() => _CustomCupertinoFormRowCurrencyState();
}

class _CustomCupertinoFormRowCurrencyState extends State<CustomCupertinoFormRowCurrency> {
  static const _locale = 'en';
  String? _formatNumber(String? s) => NumberFormat.decimalPattern(_locale).format(int.parse(s ?? '0'));
  // String get _currency => NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CupertinoFormRow(
      key: _formKey,
      prefix: Text(widget.prefix ?? 'Prefix', style: const TextStyle(fontSize: 14)),
      child: CupertinoTextFormFieldRow(
        readOnly: widget.readOnly ?? true,
        onTap: widget.readOnly == true ? widget.onPressed ?? () => debugPrint("FieldFormRow ditekan") : null,
        style: const TextStyle(fontWeight: FontWeight.normal, color: CupertinoColors.activeBlue, fontSize: 15),
        autofocus: widget.autoFocuse ?? false,
        controller: widget.controller,
        keyboardType: widget.textInputType ?? TextInputType.name,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        placeholder: widget.placeholder ?? 'Type here',
        placeholderStyle: const TextStyle(color: Colors.black12, fontWeight: FontWeight.w500, fontSize: 12),
        prefix: Text(widget.currencyType ?? '', style: const TextStyle(color: CupertinoColors.activeBlue, fontWeight: FontWeight.w500, fontSize: 15)),
        validator: (value) {
          return value == null || value.isEmpty
            ? 'Please Fill this form'
            : null;
        },
        onEditingComplete: widget.onEditingComplete,
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: (string) {
          if(string.isNotEmpty){
            string = _formatNumber(string.replaceAll(',', '')) ?? '';
            widget.controller?.value = TextEditingValue(
              text: string,
              selection: TextSelection.collapsed(offset: string.length),
            );
          }
        },
      ),
    );
  }
}