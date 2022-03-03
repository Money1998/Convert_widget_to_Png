

import 'package:flutter/material.dart';
import 'package:untitled/Common/constant.dart';

class CustomEditText extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? inputType;
  final ValueChanged<String>?onChanged;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final void Function(String)? onSubmit;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  const CustomEditText({Key? key, this.controller, this.inputType, this.hintText, this.validator, this.onSubmit, this.focusNode, this.textInputAction,this.labelText,this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      focusNode: focusNode,
      keyboardType: inputType ?? TextInputType.text,
      textInputAction: textInputAction ?? TextInputAction.done,
      style: editTextStyle,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      toolbarOptions: const ToolbarOptions(
          selectAll: false,
          cut: false,
          copy: false,
          paste: false
      ),
      decoration: InputDecoration(
        errorMaxLines: 2,
        filled: true,
        counterText: "",
        labelText: labelText,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(color: greyTextColor),
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: editBorderColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: editBorderColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
      ),
      validator: validator,
      onFieldSubmitted: onSubmit,
    );
  }
}
