import 'package:flutter/material.dart';

import '../../utils/constant.dart';

//ignore: must_be_immutable
class EditCustomInput extends StatefulWidget {
  final String? labelText, hintText;
  final bool? isPass;
  final TextEditingController? controller;
  final String? errorMsg;
  bool isShowPass;

  EditCustomInput({
    Key? key,
    this.controller,
    this.labelText,
    this.hintText,
    this.errorMsg,
    this.isPass = false,
    this.isShowPass = false,
  }) : super(key: key);

  @override
  State<EditCustomInput> createState() => _EditCustomInputState();
}

class _EditCustomInputState extends State<EditCustomInput> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 0,
      shadowColor: Colors.grey,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPass! ? widget.isShowPass : false,
        autocorrect: false,
        style: TextStyle(color: Constant.lightColorScheme.primary),
        decoration: InputDecoration(
          errorText: widget.errorMsg == '' ? null : widget.errorMsg,
          errorMaxLines: 2,
          errorStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.none),
          suffixIcon: widget.isPass!
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      widget.isShowPass = !widget.isShowPass;
                    });
                  },
                  icon: widget.isShowPass
                      ? const Icon(Icons.remove_red_eye_rounded)
                      : const Icon(Icons.remove_red_eye_outlined),
                  color: Colors.grey,
                )
              : null,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Constant.lightColorScheme.primaryContainer,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Constant.lightColorScheme.primaryContainer,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
            borderSide: BorderSide(
              color: Constant.lightColorScheme.primary,
            ),
          ),
          filled: true,
          contentPadding: const EdgeInsets.only(
            bottom: 10.0,
            left: 10.0,
            right: 10.0,
          ),
          labelText: widget.labelText,
          hintText: widget.hintText,
          labelStyle: TextStyle(
            color: Constant.lightColorScheme.primary,
          ),
          hintStyle: TextStyle(
            color: Constant.lightColorScheme.primary.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
