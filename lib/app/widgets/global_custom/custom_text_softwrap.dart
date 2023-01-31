import 'package:flutter/material.dart';

import '../../utils/constant.dart';

class CustomTextWrap extends StatelessWidget {
  final String? text;
  const CustomTextWrap({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          maxLines: 2,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          text!,
          style: TextStyle(
              color: Constant.lightColorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
