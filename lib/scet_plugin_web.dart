// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:convert';
import 'dart:html' as html;
import 'dart:js' as js;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:scet_plugin/tool/wx/WxConfigData.dart';

import 'scet_plugin_platform_interface.dart';

/// A web implementation of the ScetPluginPlatform of the ScetPlugin plugin.
class ScetPluginWeb extends ScetPluginPlatform {
  /// Constructs a ScetPluginWeb
  ScetPluginWeb();

  static void registerWith(Registrar registrar) {
    ScetPluginPlatform.instance = ScetPluginWeb();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getPlatformVersion() async {
    final version = html.window.navigator.userAgent;
    return version;
  }

  ///微信jssdk初始化
  @override
  Future<void> weiXinInit(WxConfigData wxConfigData) async {
    print('开始微信jsSdk初始化');
    return js.context.callMethod('weiXinInit',[jsonEncode(wxConfigData.toJson())]);
  }

  ///执行微信等待返回的数据
  ///weiXinCallbackJsSdkInit 会返回一个bool 提示小程序启动是否成功
  @override
  Future weiXinConfigCallbackList({
    Function? weiXinCallbackJsSdkInit
  }) async {
    //定义js可调用的方法
    js.context["weiXinCallback"] =  (e) {
      print("我调用到了flutter!");
      print("${e.toString()}");
      final data = jsonDecode(e);
      if(data['type'] == 'weiXinCallback-jsSdkInit'){
        weiXinCallbackJsSdkInit?.call(data['data']);
      }
      return e;
    };
  }

  /// Returns a [String] containing the version of the platform.
  /// 开始微信js通讯
  @override
  Future<String?> toWeiXinMiniProgramPage(String page) async {
    print('开始微信js通讯-页面跳转');
    return js.context.callMethod('toWeiXinMiniProgramPage',[page]);
  }

  /// 判断是否小程序
  @override
  bool getIsMiniProgramn()  {
    String userAgent = html.window.navigator.userAgent;
    return userAgent.contains('miniProgram');
  }

  /// 判断是否是微信 的 浏览器
  @override
  bool getIsUsingWeChat() {
    String userAgent = html.window.navigator.userAgent;
    return userAgent.contains('MicroMessenger');
  }

  /// 刷新页面标题
  @override
  void setTitle(String title) {
    html.document.title = title;
  }
}
