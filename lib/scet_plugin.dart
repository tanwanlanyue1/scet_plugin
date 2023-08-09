import 'package:flutter/material.dart';
import 'package:scet_plugin/scet_ui/scet_ui.dart';
import 'package:scet_plugin/tool/wx/WxConfigData.dart';
import 'scet_plugin_platform_interface.dart';
import 'package:bot_toast/bot_toast.dart';
import 'components/toast_widget/toast_widget.dart';
import 'components/down_input/down_input.dart';
import 'tool/logOut/log_out.dart';
import 'tool/logOut/log_utils.dart';
import 'package:scet_plugin/tool/permission/permission_manage.dart';
import 'package:scet_plugin/tool/wx/wei_xin_miniprogram.dart';
import 'tool/time/utc_tolocal.dart';
import 'scet_ui/easyRefresh/easy_refreshs.dart';
import 'scet_ui/easyRefresh/custom_easy_refresher.dart';
import 'package:easy_refresh/easy_refresh.dart';
class ScetPlugin {
  /// 插件初始化
  /// navigatorKey 路由key
  static init({required GlobalKey<NavigatorState> key,required String appTitle,required bool isDebug}) async {
    print('---中联兴插件初始化---');
    ScetUi.init(key);

    LogOut.init(appTitle);

    PrintLog.init(title: appTitle, isDebug: isDebug);
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

  /// 开始微信jsSdk 初始化
  static Future<void> weiXinInit(WxConfigData wxConfigData) async {
    return ScetPluginPlatform.instance.weiXinInit(wxConfigData);
  }


  /// 开始微信js通讯 页面跳转
  static Future<String?> toWeiXinMiniProgramPage(String page) async {
    return ScetPluginPlatform.instance.toWeiXinMiniProgramPage(page);
  }

  /// 判断是否小程序
  static bool getIsMiniProgramn() {
    return ScetPluginPlatform.instance.getIsMiniProgramn();
  }

  /// 判断是否是微信 的 浏览器
  static bool getIsUsingWeChat() {
    return  ScetPluginPlatform.instance.getIsUsingWeChat();
  }

  /// web刷新标签栏
  static void setTitle(String title) {
    return  ScetPluginPlatform.instance.setTitle(title);
  }

  static void weiXinConfigCallbackList({Function? weiXinCallbackJsSdkInit}){
    return  ScetPluginPlatform.instance.weiXinConfigCallbackList(weiXinCallbackJsSdkInit: weiXinCallbackJsSdkInit);
  }
}
