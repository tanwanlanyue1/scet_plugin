import 'package:flutter/material.dart';
import 'package:scet_plugin/scet_ui/scet_ui.dart';
import 'scet_plugin_platform_interface.dart';
import 'package:bot_toast/bot_toast.dart';
import 'components/toast_widget/toast_widget.dart';
import 'components/down_input/down_input.dart';
class ScetPlugin {
  /// 插件初始化
  /// navigatorKey 路由key
  static init(){
    print('---中联兴插件初始化---');
  }

  Future<String?> getPlatformVersion() {
    return ScetPluginPlatform.instance.getPlatformVersion();
  }

  //App 项目使用的吐司插件初始化需要的参数
  static TransitionBuilder botToastInit(){
    return BotToastInit();
  }

  //App 项目使用的吐司插件初始化需要的参数
  static BotToastNavigatorObserver botToastNavigatorObserver(){
    return BotToastNavigatorObserver();
  }

  /// 开始微信js通讯 下载
  static Future<String?> weiXinDownLoad(String filePath) async {
    return ScetPluginPlatform.instance.weiXinDownLoad(filePath);
  }

  /// 判断是否小程序
  static bool getIsMiniProgramn() {
    return ScetPluginPlatform.instance.getIsMiniProgramn();
  }

  /// 判断是否是微信 的 浏览器
  static bool getIsUsingWeChat() {
    return  ScetPluginPlatform.instance.getIsUsingWeChat();
  }

}
