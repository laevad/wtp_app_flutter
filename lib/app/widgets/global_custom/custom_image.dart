import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/constant.dart';

class CustomImage extends StatelessWidget {
  final String imageUrl;
  final String assetImage;
  final bool? isProfilePicture;
  final File? profilePicturePath;
  const CustomImage(
      {Key? key,
      required this.assetImage,
      required this.imageUrl,
      this.isProfilePicture = false,
      this.profilePicturePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: isProfilePicture == true ? 95 : 40,
        backgroundImage: profilePicturePath == null
            ? imageProvider
            : (profilePicturePath == null
                ? assetImage
                : FileImage(profilePicturePath!)) as ImageProvider<Object>,
        backgroundColor: Constant.lightColorScheme.primary,
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => CircleAvatar(
        backgroundColor: Constant.lightColorScheme.primaryContainer,
        radius: isProfilePicture == true ? 95 : 40,
        backgroundImage: AssetImage(assetImage),
      ),
    );
  }
}
