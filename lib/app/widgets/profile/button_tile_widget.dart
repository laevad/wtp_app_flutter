import 'package:flutter/material.dart';

import '../../utils/constant.dart';

class ButtonTileWidget extends StatelessWidget {
  final String title;
  final BuildContext context;
  final Function? onTap;
  final IconData? iconData;

  const ButtonTileWidget(
      {Key? key,
      required this.context,
      required this.title,
      required this.iconData,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: InkWell(
        splashColor: Constant.lightColorScheme.primaryContainer,
        hoverColor: Constant.lightColorScheme.primaryContainer,
        focusColor: Constant.lightColorScheme.primaryContainer,
        highlightColor: Constant.lightColorScheme.primaryContainer,
        onTap: onTap == null
            ? () {
                debugPrint('null here (on tap)');
              }
            : () => onTap!(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        iconData,
                        color: const Color(0xFFFB578E),
                      ),
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Constant.lightColorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Constant.lightColorScheme.onSurfaceVariant,
              )
            ],
          ),
        ),
      ),
    );
  }
}
