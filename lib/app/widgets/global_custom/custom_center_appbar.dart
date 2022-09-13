import 'package:flutter/material.dart';

import '../../utils/constant.dart';

class CustomCenterApp extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  const CustomCenterApp({Key? key, this.title})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  State<CustomCenterApp> createState() => _CustomCenterAppState();
}

class _CustomCenterAppState extends State<CustomCenterApp> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        widget.title!,
        style: TextStyle(
          color: Constant.lightColorScheme.onSurfaceVariant,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 1,
    );
  }
}
