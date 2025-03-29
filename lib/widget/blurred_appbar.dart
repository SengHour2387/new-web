import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget appBar;
  const BlurredAppbar({super.key , required this.appBar});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: appBar,
      ),
    );
  }
  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}
