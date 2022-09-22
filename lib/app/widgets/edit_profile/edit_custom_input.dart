import 'package:flutter/material.dart';

import '../../utils/constant.dart';

//ignore: must_be_immutable
class EditCustomInput extends StatefulWidget {
  final String? labelText, hintText;
  final bool? isPass;
  final TextEditingController? textEditingController;
  bool showPass;

  EditCustomInput({
    Key? key,
    this.textEditingController,
    this.labelText,
    this.hintText,
    this.isPass = false,
    this.showPass = false,
  }) : super(key: key);

  @override
  State<EditCustomInput> createState() => _EditCustomInputState();
}

class _EditCustomInputState extends State<EditCustomInput> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 1.0, // Set here what you wish!
      shadowColor: Colors.grey,
      child: TextFormField(
        controller: widget.textEditingController,
        obscureText: widget.isPass! ? widget.showPass : false,
        autocorrect: false,
        style: TextStyle(color: Constant.lightColorScheme.primary),
        decoration: InputDecoration(
          suffixIcon: widget.isPass!
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      widget.showPass = !widget.showPass;
                    });
                  },
                  icon: widget.showPass
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
