
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scet_plugin/tool/screen/adapter.dart';

import 'scet_plugin_platform_interface.dart';
import 'package:scet_plugin/tool/screen/screen.dart';
import 'package:scet_plugin/components/down_input/down_input.dart';

import 'package:scet_plugin/tool/router_animate/router_fade_route.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:bot_toast/bot_toast.dart';
class ScetPlugin {

  Future<String?> getPlatformVersion() {
    return ScetPluginPlatform.instance.getPlatformVersion();
  }

  //App 项目使用的吐司插件初始化需要的参数
  botToastInit(){
    return BotToastInit();
  }

  botToastNavigatorObserver(){
    return BotToastNavigatorObserver();
  }
}
