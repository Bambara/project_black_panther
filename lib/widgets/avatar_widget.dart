import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({Key? key, required this.provider, required this.size}) : super(key: key);

  final ImageProvider provider;

  //final String title;
  //final Function function;
  // final double heightFactor;
  // final double widthFactor;
  // final double boarderRadius;
  // final bool boarderStatus;
  final double size;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return GFAvatar(
      // image: const AssetImage('assets/images/company_logo.jpg'),
      backgroundImage: provider,
      size: size,
      backgroundColor: Colors.transparent,
      // borderRadius: BorderRadius.circular(screenWidth * boarderRadius),
      child: provider.isBlank == false ? const Center() : const Center(child: Text('Profile Image')),
    );
  }
}
