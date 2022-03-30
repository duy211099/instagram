import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserProfileImage extends StatelessWidget {
  final double radius;
  final String profileImageUrl;
  final File? profileImage;

  const UserProfileImage({
    Key? key,
    required this.radius,
    required this.profileImageUrl,
    this.profileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[50],
      backgroundImage: _backgroundImage(),
      child: _noProfileIcon(),
    );
  }

  Icon? _noProfileIcon() {
    if (profileImage == null && profileImageUrl.isEmpty) {
      return Icon(
        Icons.account_circle,
        size: radius * 2,
        color: Colors.grey[400],
      );
    } else {
      return null;
    }
  }

  ImageProvider<Object>? _backgroundImage() {
    if (profileImage != null) {
      return FileImage(profileImage!);
    }
    if (profileImageUrl.isNotEmpty) {
      return CachedNetworkImageProvider(profileImageUrl);
    }
    return null;
  }
}
