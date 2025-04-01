import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoFormRow extends StatefulWidget {
  final Function()? onPressed;
  final Function(String)? onChange;
  final bool? readOnly;
  final TextEditingController? controller;
  final String? placeholder;
  final TextInputType? textInputType;
  final String? prefix;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final int? minLength;
  final Widget? prefixWidget;
  const CustomCupertinoFormRow({super.key, this.controller, this.placeholder, this.textInputType, this.prefix, this.textInputAction, this.onPressed, this.readOnly, this.onChange, this.maxLength, this.minLength, this.prefixWidget});

  @override
  State<CustomCupertinoFormRow> createState() => _CustomCupertinoFormRowState();
}

class _CustomCupertinoFormRowState extends State<CustomCupertinoFormRow> {
  @override
  Widget build(BuildContext context) {
    return CupertinoFormRow(
      prefix: Text(widget.prefix ?? 'Prefix', style: const TextStyle(fontSize: 14)),
      child: CupertinoTextFormFieldRow(
        onChanged: widget.onChange,
        maxLength: widget.maxLength,
        readOnly: widget.readOnly ?? true,
        onTap: widget.readOnly == true ? widget.onPressed ?? () => debugPrint("FieldFormRow ditekan") : null,
        style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15, color: CupertinoColors.activeBlue),
        controller: widget.controller,
        keyboardType: widget.textInputType ?? TextInputType.name,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        placeholder: widget.placeholder ?? 'Type here',
        prefix: widget.prefixWidget ?? const SizedBox(),
        placeholderStyle: const TextStyle(color: Colors.black12, fontSize: 12, fontWeight: FontWeight.w500),
        validator: (value) {
          if(widget.maxLength != null){
            if(value!.length < (widget.minLength ?? 15)){
              return 'Mohon isikan ID minimal ${widget.minLength ?? 15} karakter';
            }
            return null;
          }
          return value == null || value.isEmpty
              ? 'Please Fill this form'
              : null;
        },
      ),
    );
  }
}