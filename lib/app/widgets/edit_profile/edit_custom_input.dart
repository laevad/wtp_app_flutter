import 'package:flutter/material.dart';

import '../../utils/constant.dart';

//ignore: must_be_immutable
class EditCustomInput extends StatefulWidget {
  final String? labelText, hintText;
  final bool? isPass;
  bool showPass;

  EditCustomInput({
    Key? key,
    this.labelText,
    this.hintText,
    this.isPass = false,
    required this.showPass,
  }) : super(key: key);

  @override
  State<EditCustomInput> createState() => _EditCustomInputState();
}

class _EditCustomInputState extends State<EditCustomInput> {
  final _focusNode = FocusNode();
  _focusListener() {
    setState(() {});
  }

  @override
  void initState() {
    _focusNode.addListener(_focusListener);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 3.0, // Set here what you wish!
      shadowColor: Colors.grey,
      child: TextFormField(
        autocorrect: false,
        focusNode: _focusNode,
        style: TextStyle(color: Constant.lightColorScheme.primary),
        decoration: InputDecoration(
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(color: Constant.lightColorScheme.primary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(color: Constant.lightColorScheme.primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Constant.lightColorScheme.primary),
          ),
          filled: true,
          contentPadding:
              const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          labelText: widget.labelText,
          hintText: widget.hintText,
          labelStyle: TextStyle(color: Constant.lightColorScheme.primary),
          hintStyle: TextStyle(
              color: Constant.lightColorScheme.primary.withOpacity(0.5)),
        ),
      ),
    );
  }
}
