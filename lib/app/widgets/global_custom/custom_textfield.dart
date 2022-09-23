import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? errorMsg;
  final String? labelText;
  final bool? isObscure;
  const CustomTextField(
      {Key? key,
      this.controller,
      required this.errorMsg,
      this.labelText,
      this.isObscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscure!,
      decoration: InputDecoration(
        // ignore
        errorText: errorMsg == '' ? null : errorMsg,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(14),
          ),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        labelText: labelText,
      ),
    );
  }
}
