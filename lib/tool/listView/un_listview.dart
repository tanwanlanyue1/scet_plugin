import 'package:flutter/material.dart';
/*
* $作用：去除ListView 滑動波紋
* $參考：https://blog.csdn.net/u013894711/article/details/102572581
* */
class OverScrollBehavior extends ScrollBehavior{

  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails  details) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS: return child;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
            child: child,
            //不显示头部水波纹
            showLeading: false,
            //不显示尾部水波纹
            showTrailing: false,
            axisDirection: details.direction,
            color: Theme.of(context).colorScheme.secondary
        );
      case TargetPlatform.linux: return child;
      case TargetPlatform.macOS: return child;
      case TargetPlatform.windows: return child;
    }
    return Container();
  }

}