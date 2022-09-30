import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final Function? onPressed;

  const CustomAppBar({
    Key? key,
    this.title,
    this.centerTitle = false,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.onPressed,
  })  : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  CustomAppBarState createState() => CustomAppBarState();
}

class CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CustomText(
          text: widget.title ?? '',
          color: const Color(0xff2E353D),
          fontSize: 18.0,
          fontWeight: FontWeight.w600),
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
      centerTitle: widget.centerTitle,
      backgroundColor: Colors.white,
      titleSpacing: 0.0,
      leading: widget.automaticallyImplyLeading
          ? IconButton(
              icon:
                  const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              onPressed: () => widget.onPressed!(),
            )
          : null,
      actions: widget.actions,
    );
  }
}
