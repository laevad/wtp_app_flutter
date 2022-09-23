import 'package:flutter/material.dart';

class LoginCustomBtn extends StatelessWidget {
  final Function? onPressed;
  const LoginCustomBtn({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          stops: [
            0.20,
            0.90,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFFB578E),
            Color(0xFFFDA58E),
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
        ),
        onPressed: () async => await onPressed!(),
        child: const Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
