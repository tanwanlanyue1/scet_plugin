// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;
import 'dart:js' as js;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:js/js.dart';

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


  /// Returns a [String] containing the version of the platform.
  static Future<String?> WeiXinDownLoad(String filePath) async {
    print('开始微信js通讯');
    return js.context.callMethod('wxPostMessage',[filePath]);
  }

  /// 判断是否小程序
  static bool isMiniProgram() {
    String userAgent = html.window.navigator.userAgent;
    return userAgent.contains('miniProgram');
  }

  /// 判断是否是微信 的 浏览器
  static bool isUsingWeChat() {
    String userAgent = html.window.navigator.userAgent;
    return userAgent.contains('MicroMessenger');
  }
}
