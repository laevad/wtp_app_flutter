import 'package:flutter/material.dart';

import '../../utils/constant.dart';

class CustomButtonSaveChanges extends StatelessWidget {
  final Function? onPressed;
  final String? text;
  const CustomButtonSaveChanges({
    Key? key,
    this.onPressed,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed!(),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Constant.lightColorScheme.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        child: Text(
          text!,
          style: const TextStyle(fontSize: 14, letterSpacing: 2.2),
        ),
      ),
    );
  }
}
